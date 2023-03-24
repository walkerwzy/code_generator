#!/usr/bin/env node

let fs = require('fs-extra'),
    path = require('path'),
    program = require('commander'),
    cheerio = require('cheerio'),
    strlist = 'string[]',
    intlist = ['int[]','integer[]', 'int32[]', 'int64[]'],
    floatlist = 'float[]',
    $;

// 命令行参数
let collect = function(val, col) {
    col.push(val);
    return col;
};
let batchCollect = function(val) {
    val = val.replace(/\,+/ig, ',').replace(/,$/g,'');
    return val.split(',');
};

program
    .version('0.0.1')
    .usage('[option] <file ...>')
    .option('-f, --file <type>', 'set input file name','index.html')
    .option('-m, --module [name]', 'set the module name')
    .option('-b, --base [name]', 'set the base class names', collect, [])
    .option('-B, --clientbase [name', 'set the httpclient base class', 'NSObject')
    .option('-c, --classes [name]', 'set the class names', collect, [])
    .option('-C, --batchclasses [name,name,name]', 'batch sub class names', batchCollect, [])
    .option('-D, --batchdes [name]', 'set each root model a description', batchCollect, [])
    .option('-p, --passkeys [key]', 'set exclued keys', collect, [])
    .option('-P, --batchpasskeys [key,key,key]', 'batch set exclued keys', batchCollect, [])
    .option('-a, --author [name]', 'set the author name', 'walker')
    .option('-j, --project [name]', 'set the project name', 'Project')
    .option('-x, --prefix [name]', 'set the class prefix', 'LA')
    .option('-r, --copyright [name]', 'set the copyright name', 'Lotus Technology')
    .option('-o, --tableoffset [count]', 'how many table need skiped to parse', 0)
    .option('--debug', 'the output.json file will gen', false)
    .option('--verbose', 'show buzz logs', false)
    .parse(process.argv);
let baseClasses     = program.base.length || ['NSObject', 'NSObject'],
    classCollect    = [...program.classes, ...program.batchclasses],
    passKeys        = [...program.passkeys, ...program.batchpasskeys],
    tableoffset     = program.tableoffset,
    typeFactory     = classNameGenerator();

let entities        = [], // 实体类对应的数组
    methodArgs      = [], // 方法参数对应的数组
    endpoints       = [], // 接口请求地址数组
    req_methods     = [], // 接口请求方式数组(get, post...)
    responseModel   = [], // 接口返回值类型数组 => 完全由 endpoint 转化而来
    methods         = []; // 接口对应方法名数组 => 完全由 endpoint 转化而来 {name: param:}
    isRespArray     = []; // 接口返回值是否对象数组（还没测简单数组）
    isRespPrimary   = []; // 接口返回值是否基本类型
    methodTitles    = []; // 接口标题数组
    respFactory     = responseModelGenerator();

(async () => {
let content         = await readFile(program.file),
    $               = cheerio.load(content);

// 移除不需要的 table (目前只支持移除从0开始的)
// console.log(88888, $(".ant-table-body > table").length);
if(tableoffset>0) $(".ant-table-body > table").slice(0, tableoffset).remove();
// console.log(99999, $(".ant-table-body > table").length);
$(".caseContainer > .colHeader").remove();
// 解析路径
endpoints = [$(".panel-view .ant-row").eq(2).find(".colValue > .colValue").not(".tag-method").text()];
// 解析method: get/post
req_methods = [$(".panel-view .ant-row").eq(2).find(".tag-method").text()];
// 根据路径生成方法名, 响应类名
parseEndpoints();
console.log('endpoints:', endpoints);
console.log('request_methods:', req_methods);
console.log('response_types:', responseModel);
// 解析文本, 得到方法标题列表
methodTitles = [$('.panel-view .ant-row').first().find('.colName').text()];
console.log('titles:', methodTitles);
// 解析请求和响应的 Table
// console.log("---------------", $(".ant-table-body > table").length);
$(".ant-table-body > table").each((i, table) => {
    // console.log(333333,i);
    if(i%2 == 0) return parseRequestTable(table); // => 得到方法参数数组
    parseResponseTable(table, Math.floor(i/2));  // => 得到实体类数组
});
if(program.debug) await fs.writeJson('./output.json', entities).catch(console.log);
// 应用模板
await parseTemplate().catch(console.log);
// 完成
console.log("done!");

/**
 * 每行提取为如下json格式，然后再提取公共项
 {
    name: 'maintenanceNo',
    des: '工单编号 非必须 ',
    className: 'LAMaintenanceOrderSimpleList',
    baseName: false,
    type: 'NSString *',
    innerType: 'NSString',
    isArray: false,
    isObject: false,
    level: 1,
    hasIdKey: false
  },
 */
 function parseResponseTable(table, index) {
    let modelNames  = [responseModel[index]], // 按先后顺序出现的子类名（一旦一个子类处理完了，会从该表移除）
        baseName    = baseClasses[0],
        props       = []
    $(table).find("tbody").children("tr")
    .each((i,tr) => {
        if($(tr).text().trim().length == 0) return; // 空行不处理
        let tds = $(tr).children('td');
        let nameMatch = /[a-z0-9]+/ig.exec(tds.eq(0).text());
        if(!nameMatch) return;                                // 第一格非英文则理解为不是属性名
        if(passKeys.includes(nameMatch[0])) return;           // 包含预设排除关键字, 不需要处理

        let level = getRowLevel(tr);
        let pname = tds.eq(0).text().trim();
        let ptype = tds.eq(1).text().replace(/[\s\n]/g, '');
        if(!ptype || ptype.length == 0) 
            return console.log("当前行找不到类型定义, 请检查当前行数据: ",$(tr).html(), $(tr).text());
        let isArray = ['list', 'array'].includes(ptype.toLowerCase()) || ptype.indexOf('[]') >= 0;
        let isComplexObj = isObjectOrArray(nameMatch[0], ptype); // 包含预设子类关键字, 理解为复杂对象
        // level 0都不处理，只有data行需要判断一下是否只返了简单类型
        let str_ptype = ptype;  //  先保留ptype原始文本
        if(level == 0) {
            if(pname == "data") {
                // console.log(`row: ${i}, level: ${level}, name: ${pname}, type: ${ptype}`);
                if(ptype == "boolean"){  // 目前文档唯一会返的root简单类型是boolean
                    responseModel[index] = "id";  // 项目特征
                }
                isRespArray.push(isArray);
                isRespPrimary.push(!isComplexObj);
            }
            return;
        }
        // 比如：当前是1层，但是modelNames有两个，说明之前处理过子层，并且已经处理完了，那么就移除多余的名称
        if(level < modelNames.length) modelNames.pop();
        if(isComplexObj) {
            if(modelNames.length < level+1) {
                ptype = typeFactory.next().value; 
                modelNames.push(ptype);            // 也添加到子类表，子类按顺序从里面取名字
            }
            ptype = modelNames[level];
        }
        if(program.verbose) console.log(`row: ${i}, level: ${level}, name: ${pname}, isObject: ${isComplexObj}`, modelNames)
        if(isComplexObj) console.log(`${pname} ==> ${ptype}`);
        if(ptype == "object") 
            return console.log("object 行未发现对应的类:", $(tr).html(), $(tr).text(), tds.eq(4).html(), isComplexObj);
        if(!ptype || ptype.length == 0) 
            return console.log("类名个数不符", $(tr).text());  // 生成器没生成类名, 说明数量给少了
        if(ptype == 'list' || (ptype.indexOf('[]') >= 0  && isComplexObj)) 
            return console.log("没有找到该行 list 对应的类型, 请检查当前行数据:", $(tr).html(), tds.eq(2).text(), isComplexObj)
        let assume_type = assumeVarType(str_ptype, isArray, ptype);
        let pdes = tds.eq(4).text().trim() + ' ' + tds.eq(2).text().trim() + ' ' + tds.eq(5).text().trim(); 
        let prop = {
            "name": pname, 
            "des": pdes, 
            "className": modelNames[level-1],
            "baseName": baseName,
            "type": assume_type[0],
            "innerType": assume_type[1],
            "level": level,
            "isObject": isComplexObj,
            "hasIdKey": false,
        };
        if(pname == 'id') {
            prop["name"] = "theId";  // TODO: 也改成可配置的
            prop["hasIdKey"] = true;
        }
        props.push(prop);
       }); // end of basetable > tr > foreach


        if(program.verbose) console.log("props:", props);
        // 提取公共字段
        // 先提取类别
        let types = [... new Set(props.map(m => m["className"]))];
        types.forEach(m => entities.push({"className": m, props: []}));
        props.forEach(m => {
            let ents = entities.filter(e => e["className"] == m["className"]);
            if(ents.length == 0) return;
            let ent = ents[0];
            ent["isRoot"] = m["level"] == 1;
            ent["hasIdKey"] = props.filter(p=>p.className == m.className).some(p=>p.hasIdKey),
            ent["baseName"] = m["baseName"],
            ent["props"].push({
                "name": m["name"],
                "des": m["des"],
                "type": m["type"],
                "innerType": m["innerType"],
                "isObject": m["isObject"]
            })
        });
     }
function parseRequestTable(table) {
    let param_des = [];
    $(table).children("tbody").children("tr")
    .each((i, tr) => {
        // if(i<2) return;
        let tds     = Array.from($(tr).children('td'));
        // if($(tds[0]).text() == '业务参数' || $(tds[0]).text().trim().length == 0) return;
        let propdes = tds.map(t=>$(t).text().replace(/[\s\n]/ig, '')).join(' ');
        param_des.push(propdes);
    });
    methodArgs.push(param_des);
}

function capitalizeFirstLetter([first, ...rest]) {
  return first.toUpperCase() + rest.join('');
}

// 根据解析出路径, 响应类型, 和参数数组
function parseEndpoints(){
    // 注意: 这里是针对具体 URL 的样式进行更改的, 不同项目请仔细更改
    responseModel = endpoints.map(e=>program.prefix+capitalizeFirstLetter(e.substring(e.lastIndexOf('/')+1,e.length))+'Model');
    methods = endpoints.map(e=>'request'+capitalizeFirstLetter(e.substring(e.lastIndexOf('/')+1,e.length)));
}

function getRowLevel(row) {
    let level = 0;
    [...1e4+''].forEach((_, i) => { // 4层够了吧？（从level1开始，到level4)
        if($(row).hasClass("ant-table-row-level-"+i)) level = i; // 顺便用来跟类名数组的个数做比较，所以从1开始计数
    });
    return level;
}

})().catch(console.log);

// 响应类类名生成器
// 本实现中不使用, 所有类名由用户定义, 不由路径自动生成
function* responseModelGenerator() {
    yield* responseModel;
}

// 子类名生成器
function* classNameGenerator() {
    yield* classCollect;
}


async function readFile(filename) {
 let fullpath = path.resolve(filename); 
 if(program.verbose) console.log('start processing file:', fullpath);
 return await fs.readFile(fullpath, 'utf8').catch(console.log);
}

/**
 * 是否对象或数组(简单数组不算)
 * @param keystr: 属性名 (没有用到?)
 * @param typestr: 类型名
 */
function isObjectOrArray(keystr, typestr) {
    typestr = typestr.toLowerCase().replace(/[\s\n]/g, '');
    let isPrimaryType = ['number', 'int', 'int32', 'int64', 'integer', 'long', 'string', 'bool', 'boolean', 'date', 'date-time', 'float', 'double'].includes(typestr),
        isPrimaryList = [...intlist, strlist, floatlist].includes(typestr);
    return !isPrimaryType && !isPrimaryList;  // 不再考虑用户定义, 发现非简单类型都默认下一行是子表
}

/**
 * 根据关键字推断类型
 * @prarm str: 关键字
 * @param isArray: 是否数组类型
 * @param model: 自定义类型
 * @return 返回[变量类型, 模型类型, 元素类型]
 * 比如 [NSArray<Doctor *> *, Doctor *]
 * 一个用于建模, 一个用于写属性
 */
function assumeVarType(str, isArray, model) {
    let l_str = str.toLowerCase(), 
        model_type = str, // 类型 
        var_type = str;   // 字段
    if(['string','date', 'date-time', 'null'].includes(l_str)) model_type = "NSString *";
    else if(['bool', 'boolean'].includes(l_str)) model_type = "BOOL ";
    else if(['int', 'integer', 'long'].findIndex(v=>(new RegExp(v,'ig')).test(l_str)) >= 0) model_type = "NSInteger ";
    else if(['float', 'dobule', 'number'].findIndex(v=>(new RegExp(v,'ig')).test(l_str)) >= 0) model_type = "CGFloat ";
    else if(l_str == strlist) model_type = "NSArray<NSString *> *"
    else if(l_str == intlist) model_type = "NSArray<NSNumber *> *";
    else model_type = model + " *";
    var_type  = (isArray && l_str != strlist && l_str != intlist) ? "NSArray<"+model_type+"> *" : model_type;;
    model_type = model_type.replace(' *','');

    return [var_type, model_type];
}

function getPath(...components) {
    return path.join(__dirname, ...components);
}

function underscoreToCamel(all, letter, index, text) {
    // 第一个参数是当次匹配到的全文
    // 第二个参数是当次匹配到第一组, 以此类推
    // 只要参数数量足够, 最后两个就是第一个匹配的索引和原始文本
    return letter.toUpperCase();
}

async function getFileContent(...components) {
    let fullpath = getPath(...components);
    return await fs.readFile(fullpath, 'utf8').catch(console.log);
}

async function renderFile(filepath, tpl) {
    return await fs.writeFile(filepath, tpl, 'utf8').catch(console.log);
}

// 参数: 模型, 文本, 入参描述
async function parseTemplate() {
    if(program.verbose) console.log("开始应用模板");
    let copyright   = program.copyright,
        projectname = program.project,
        author      = program.author,
        modulename  = program.module,
		httpclient  = program.clientbase,
        prefix      = program.prefix,
        model_path  = "templates/model",
        task_path   = "templates/httpclient",
        // 模板内容
        h_content   = await getFileContent(model_path, 'template.h'),
        m_content1  = await getFileContent(model_path, 'template.m'),
        m_content2  = await getFileContent(model_path, 'template.m'),  // 本项目实体类基类都是NSObject
        h_task      = await getFileContent(task_path, 'task.h'),
        m_task      = await getFileContent(task_path, 'task.m');
    let out_model   = "output_model",
        out_task    = "output_task";
    await fs.emptyDir(out_model); // 创建/清空输出文件夹
    await fs.emptyDir(out_task); // 创建/清空输出文件夹
    console.log("开始生成实体类");
    // 先去重
    // let usedModels = [],
    //     datasource = [];
    // entities.forEach((model, index) => {
    //     if(!model.isObject) return; // 简单类型不生成类
    //     if(classCollect.filter(m=>m==model.className).length==1) return datasource.push(model);
    //     if(usedModels.includes(model.className)) return;
    //     usedModels.push(model.className);
    //     datasource.push(model);
    // });
    // datasource = entities.filter((m, i) => !isRespPrimary[i]);
    // datasource.forEach(async (model, index) => {
    entities.forEach(async (model, index) => {
        let m_content = model.isRoot ? m_content2 : m_content1;
        // 输出路径
        let h_file = getPath(out_model, model.className+'.h'),
            m_file = getPath(out_model, model.className+'.m');
        await renderFile(h_file, eval(h_content)).catch(console.log);
        await renderFile(m_file, eval(m_content)).catch(console.log);
    });
    // ===================
    // gen http request (task) file
    // ===================
    console.log("开始生成请求类");
    // 这里主要是为模板内写if写麻烦，越俎代疱在这里写上了生成值，前面的为NSString生成NSString *也是一样
    let resp_model  = (i) => {
        m = responseModel[i];  
        if(m == "id") return {"type": m, "param": m};
        if(isRespArray[i]) return {"type": m, "param": `NSArray<${m} *> * _Nonnull`};
        return {"type": m, "param": m + " * _Nonnull"};
    };
    let h_file      = getPath(out_task, `${modulename}.h`),
        m_file      = getPath(out_task, `${modulename}.m`);
    if(endpoints.length>methodArgs.length)
        return console.log("接口数量与入参数量不一致的", endpoints, methodArgs);  // 接口由解析文本来的, 入参描述由解析表格来的, 可能不一致, 但是入参可以多(有的接口不需要post->.json)
    if(endpoints.length>methodTitles.length)
        return console.log("接口数量与接口标题数量不一致", endpoints, methodTitles); // 分别由解析文本而来, 可能不一致
    if(endpoints.length<methodTitles.length)
        console.log("警告: 接口数量比接口标题数量少", endpoints, methodTitles); // 这是合理的, 有的接口写在文档上并不需要做请求
    endpoints = endpoints.map((e,i)=>{
        return {
            "httpclient": httpclient,
            "path": e,
            "req_method": req_methods[i],
            "method": methods[i],
            "model": resp_model(i),
            "isPrimary": isRespPrimary[i],
            "isArray": isRespArray[i],
            "des": methodTitles[i].replace(/[\s\n]/ig, ''),
            "args": methodArgs[i]
        }   
    });
    if(program.verbose) console.log("task file params:", endpoints);
    await renderFile(h_file, eval(h_task)).catch(console.log);
    await renderFile(m_file, eval(m_task)).catch(console.log);

    console.log('=====END=====')
}
