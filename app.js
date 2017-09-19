#!/usr/bin/env node

let fs = require('fs-extra'),
    path = require('path'),
    program = require('commander'),
    cheerio = require('cheerio'),
    strlist = 'list<string>',
    intlist = 'list<int>',
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
    .option('-c, --classes [name]', 'set the class names', collect, [])
    .option('-C, --batchclasses [name,name,name]', 'batch sub class names', batchCollect, [])
    .option('-D, --batchdes [name]', 'set each root model a description', batchCollect, [])
    .option('-p, --passkeys [key]', 'set exclued keys', collect, [])
    .option('-P, --batchpasskeys [key,key,key]', 'batch set exclued keys', batchCollect, [])
    .option('-a, --author [name]', 'set the author name', 'walker')
    .option('-j, --project [name]', 'set the project name', 'Project')
    .option('-r, --copyright [name]', 'set the copyright name', 'WeDoctor Group')
    .option('--debug', 'the output.json file will gen', false)
    .option('--verbose', 'show buzz logs', false)
    .parse(process.argv);
let baseClasses     = program.base.length || ['PMLResponseModelBaseHD', 'PMLModelBase'],
    classCollect    = [...program.classes, ...program.batchclasses],
    passKeys        = [...program.passkeys, ...program.batchpasskeys],
    typeFactory     = classNameGenerator();

let entities        = [], // 实体类对应的数组
    methodArgs      = [], // 方法参数对应的数组
    endpoints       = [], // 接口请求地址数组
    responseModel   = [], // 接口返回值类型数组 => 完全由 endpoint 转化而来
    methods         = []; // 接口对应方法名数组 => 完全由 endpoint 转化而来 {name: param:}
    methodTitles    = []; // 接口标题数组
    respFactory     = responseModelGenerator();

(async () => {
let content         = await readFile(program.file),
    $               = cheerio.load(content);
// 解析文本, 得到[enpoints, resopnsemodel, methods]
parseEndpoints($(".wiki-content p").text());
// 解析文本, 得到方法标题列表
$(".wiki-content *:has(.toc-macro)").remove(); // 移除目录
$(".wiki-content h1[id*=id-]").each((i,m) => methodTitles.push($(m).text()));
$(".wiki-content h2[id*=id-]").each((i,m) => methodTitles.push($(m).text()));
// 解析请求和响应的 Table
$(".wiki-content>.table-wrap").each((i, table) => {
    if(i%2 == 0) return parseRequestTable(table); // => 得到方法参数数组
    parseResponseTable(table);  // => 得到实体类数组
});  
if(program.debug) await fs.writeJson('./output.json', responseModel).catch(console.log);
// 应用模板
await parseTemplate().catch(console.log);
// 完成
if(program.verbose) console.log("done!");

function parseResponseTable(table, classMeta) {
    let modelName   = "",
        baseName    = baseClasses[0],
        isRoot      = true;     // 子类如果需要继承不同的基类, 则利用此标识
    if(classMeta) {
        // 有classMeta, 说明是一个子类
        modelName   = classMeta["model"];
        baseName    = baseClasses[1];
        isRoot      = false;
    }else{
        modelName = respFactory.next().value;
    }
    let rowIsTable = false,
        props = [],
        complexProperty; // 如果当前行表示是个对象或数据, 把元数据保存, 用来生成子表格对应的类
    $(table).children(".confluenceTable").children("tbody").children("tr")
    .each((i,tr) => {
        if($(tr).text().trim().length == 0) return; // 空行不处理
        if(rowIsTable){
            // 进入这个方法,说明上一行标识这一行是子类
            rowIsTable = false;
            // return parseResponseTable($(tr).children("td").children(".table-wrap"), complexProperty);
            // 有时候文档把子表格写在了第二个 td 里...
            return parseResponseTable($(tr).find(".table-wrap").eq(0), complexProperty);
        }
        let tds = $(tr).children('td');
        let nameMatch = /[a-z]+/ig.exec(tds.eq(0).text());
        if(!nameMatch) return;                                // 第一格非英文则理解为不是属性名
        if(passKeys.includes(nameMatch[0])) return;           // 包含预设排除关键字, 不需要处理
        // 记录属性名, 类型, 注释等
        let pname = tds.eq(0).text().trim();
        let ptype = tds.eq(2).text().trim() || "object";      // 没有足够的列, 说明下一行是一个对象, 被合并单元格了, 如果是数组会标明是 list 的
        let pdes  = tds.eq(3).text().trim() || "";
        if(!ptype || ptype.length == 0) 
            return console.log("当前行找不到类型定义, 请检查当前行数据: ",$(tr).html(), $(tr).text());
        let isComplexObj = isObjectOrArray(nameMatch[0], ptype);     // 包含预设子类关键字, 理解为复杂对象
        let isArray = ptype.toLowerCase() == 'list';
        if(isComplexObj) ptype = typeFactory.next().value;
        if(isComplexObj) console.log(`${pname} ==> ${ptype}`);
        if(ptype == "object") 
            return console.log("object 行未发现对应的类:", $(tr).html(), $(tr).text(), tds.eq(2).html(), isComplexObj);
        if(!ptype || ptype.length == 0) 
            return console.log("类名个数不符", $(tr).text());  // 生成器没生成类名, 说明数量给少了
        if(ptype == 'list') 
            return console.log("没有找到该行 list 对应的类型, 请检查当前行数据:", $(tr).html(), tds.eq(2).text(), isComplexObj)
        let assume_type = assumeVarType(ptype, isArray, ptype);
        let prop = {
            "name": pname, 
            "des": tds.eq(1).text(), 
            "type": assume_type[0],
            "isArray": isArray
        };
        if(pdes) {
            prop["des"] = prop["des"] + " " + pdes;
        }
        if(isComplexObj){
            prop["model"] = assume_type[1];
            rowIsTable = true;
            complexProperty = prop;
        }
        props.push(prop);
       }); // end of basetable > tr > foreach
        entities.push({"isRoot": isRoot, "className": modelName,"baseName": baseName, "props": props});
        if(program.verbose) console.log("生成模型:", modelName) 
     }
function parseRequestTable(table) {
    let param_des = [];
    $(table).children(".confluenceTable").children("tbody").children("tr")
    .each((i, tr) => {
        if(i<2) return;
        let tds     = Array.from($(tr).children('td'));
        if($(tds[0]).text() == '业务参数') return;
        let propdes = tds.map(t=>$(t).text()).join(' ');
        param_des.push(propdes);
    });
    methodArgs.push(param_des);
}

// 根据解析出路径, 响应类型, 和参数数组
function parseEndpoints(uris){
    endpoints       = uris.match(/\}\/.*?\.json/ig).map(m=>m.replace('}',''));  // 从文档中提取接口地址
    responseModel   = endpoints.map(e=>'Response'+e.replace(/\/(\w)/ig,underscoreToCamel).replace('.json',''))  // 从接口地址生成返回值名
    methods         = endpoints.map(e=>'method'+e.replace(/\/(\w)/ig,underscoreToCamel).replace('.json','')); // 从接口地址生成方法名
}
})().catch(console.log);

// 响应类类名生成器
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

// 是否对象或数组(简单数组不算)
function isObjectOrArray(keystr, typestr) {
    typestr = typestr.toLowerCase().trim();
    let isPrimaryType = ['int', 'integer', 'long', 'string', 'bool', 'boolean'].includes(typestr),
        isPrimaryList = [intlist, strlist].includes(typestr);
    return !isPrimaryType && !isPrimaryList;  // 不再考虑用户定义, 发现非简单类型都默认下一行是子表
}

/**
 * 根据关键字推断类型
 * @prarm str: 关键字
 * @param isArray: 是否数组类型
 * @param model: 自定义类型
 * @return 返回[变量类型, 模型类型]
 * 比如 [NSArray<Doctor *> *, Doctor *]
 * 一个用于建模, 一个用于写属性
 */
function assumeVarType(str, isArray, model) {
    let l_str = str.toLowerCase(), 
        model_type = str, // 类型 
        var_type = str;   // 字段
    if(l_str == 'string') model_type = "NSString *";
    else if(['bool', 'boolean'].includes(l_str)) model_type = "BOOL";
    else if(['int', 'integer', 'long'].findIndex(v=>(new RegExp(v,'ig')).test(l_str)) >= 0) model_type = "NSInteger";
    else if(l_str == strlist) model_type = "NSArray<NSString *> *"
    else if(l_str == intlist) model_type = "NSArray<NSInteger> *";
    else model_type = model + " *";
    var_type  = isArray ? "NSArray<"+model_type+"> *" : model_type;;
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

async function genFileFromTemplate(filepath, tpl) {
    return await fs.writeFile(filepath, tpl, 'utf8').catch(console.log);
}

// 参数: 模型, 文本, 入参描述
async function parseTemplate() {
    if(program.verbose) console.log("开始应用模板");
    let copyright   = program.copyright,
        projectname = program.project,
        author      = program.author,
        modulename  = program.module,
        model_path  = "templates/model",
        task_path   = "templates/httpclient",
        // 模板内容
        h_content   = await getFileContent(model_path, 'template.h'),
        m_content1  = await getFileContent(model_path, 'template.m'),
        m_content2  = await getFileContent(model_path, 'templatebase.m'),
        h_task      = await getFileContent(task_path, 'task.h'),
        m_task      = await getFileContent(task_path, 'task.m');
    let out_model   = "output_model",
        out_task    = "output_task",
        exist_file  = []; // 重复定义的类, 只生成一次, 生成过一次就丢到这个数组里打标
    await fs.emptyDir(out_model); // 创建/清空输出文件夹
    await fs.emptyDir(out_task); // 创建/清空输出文件夹
    if(program.verbose) console.log("开始生成实体类")
    entities.forEach(async (model, index) => {
        // 有些子类字段是一样的, 我们写脚本的时候把类名写成一样的, 此处会 pass 掉
        // 但只对单次执行脚本有效
        if(classCollect.filter(m=>m==model.className).length>1) {
            if(exist_file.includes(model)) return;
            exist_file.push(model);
        }
        let m_content = model.isRoot ? m_content2 : m_content1;
        // 输出路径
        let h_file = getPath(out_model, model.className+'.h'),
            m_file = getPath(out_model, model.className+'.m');
        await genFileFromTemplate(h_file, eval(h_content)).catch(console.log);
        await genFileFromTemplate(m_file, eval(m_content)).catch(console.log);
    });
    // ===================
    // gen http request (task) file
    // ===================
    if(program.verbose) console.log("开始生成请求类");
    let h_file      = getPath(out_task, `${modulename}.h`),
        m_file      = getPath(out_task, `${modulename}.m`);
    if(endpoints.length!=methodArgs.length)
        return console.log("接口数量与入参数量不一致的", endpoints, methodArgs);  // 接口由解析文本来的, 入参描述由解析表格来的, 可能不一致
    if(endpoints.length!=methodTitles.length)
        return console.log("接口数量与接口标题数量不一致", endpoints, methodTitles); // 分别由解析文本而来, 可能不一致
    endpoints = endpoints.map((e,i)=>{
        return {
        "path": e,
        "method": methods[i],
        "model": responseModel[i],
        "des": methodTitles[i],
        "args": methodArgs[i]
    }
    });
    await genFileFromTemplate(h_file, eval(h_task)).catch(console.log);
    await genFileFromTemplate(m_file, eval(m_task)).catch(console.log);

    console.log(`all done. model path [${out_model}], task path [${out_task}]`)
}
