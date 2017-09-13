#!/usr/bin/env node

let fs = require('fs-extra'),
    path = require('path'),
    program = require('commander'),
    cheerio = require('cheerio'),
    $;

// 命令行参数
let collect = function(val, col) {
    col.push(val);
    return col;
};
let batchCollect = function(val) {
    return val.split(',');
};
program
    .version('0.0.1')
    .option('-f, --file [type]', 'set input file name','index.html')
    .option('-k, --datakeys [keys]', 'set data key names', collect, [])
    .option('-K, --batchdatakeys <key,key,key>', 'batch set data keys', batchCollect)
    .option('-b, --base [name]', 'set the base class names', collect, [])
    .option('-c, --classes [name]', 'set the sub class names', collect, [])
    .option('-C, --batchclasses <name,name,name>', 'batch set sub class names', batchCollect)
    .option('-p, --passkeys [key]', 'set exclued keys', collect, [])
    .option('-P, --batchpasskeys <key,key,key>', 'batch set exclued keys', batchCollect)
    .parse(process.argv);

let baseClasses     = program.base.length || ['PMLResponseBaseHD', 'PMLModelBase'],
    classCollect    = program.classes.length?program.classes : program.batchclasses||[],
    dataKeys        = program.datakeys.length?program.datakeys : program.batchdatakeys||[],
    passKeys        = program.passkeys.length?program.passkeys : program.batchpasskeys||[],
    nameFactory     = classNameGenerator();
dataKeys.push('data');      // 添加一个默认的 data 键, 要通用性的话, 这里不应该加
(async () => {
let content         = await readFile(program.file),
    $               = cheerio.load(content),
    contentJSON     = [];
await $(".wiki-content>.table-wrap").each(async (i, table) => {
    if(i%2 == 0) return;
    processTable(table);
}); 
await fs.writeJson('./output.json', contentJSON);  // for test
await parseTemplate(contentJSON);
console.log("done!");

function processTable(table, classMeta) {
    let modelName   = "",
        baseName    = baseClasses[0],
        isRoot      = true;     // 子类如果需要继承不同的基类, 则利用此标识
    if(classMeta) {
        // 有classMeta, 说明是一个子类
        modelName   = classMeta["model"];
        baseName    = baseClasses[1];
        isRoot      = false;
    }else{
        modelName = nameFactory.next().value;
    }
    let fileName_h = modelName + ".h",
        fileName_m = modelName + ".m",
        rowIsTable = false,
        props = [],
        complexProperty; // 如果当前行表示是个对象或数据, 把元数据保存, 用来生成子表格对应的类
    $(table).children(".confluenceTable").children("tbody").children("tr")
    .each(async (i,tr) => {
        if(rowIsTable){
            // 进入这个方法,说明上一行标识这一行是子类
            rowIsTable = false;
            return processTable($(tr).children("td").children(".table-wrap"), complexProperty);
        }
        let tds = $(tr).children('td');
        let nameMatch = /[a-z]+/ig.exec(tds.eq(0).text());
        if(!nameMatch) return; // 非英文则理解为不是属性名
        if(passKeys.indexOf(nameMatch[0])>=0) return;           // 包含预设排除关键字, 不需要处理
        let isComplexObj = dataKeys.indexOf(nameMatch[0])>=0;   // 包含预设子类关键字, 理解为复杂对象
        // 记录属性名, 类型, 注释等
        let pname = tds.eq(0).text().trim();
        let ptype = tds.eq(2).text().trim();
        let isArray = ptype.toLowerCase() == 'list';
        if(isComplexObj) ptype = nameFactory.next().value;
        let assume_type = assumeVarType(ptype, isArray, ptype);
        let prop = {
            "name": pname, 
            "des": tds.eq(1).text(), 
            "type": assume_type[0],
            "isArray": isArray
        };
        if(tds.eq(3).text().trim()) {
            prop["des"] = prop["des"] + " " + tds.eq(3).text();
        }
        if(isComplexObj){
            prop["model"] = assume_type[1];
            rowIsTable = true;
            complexProperty = prop;
        }
        props.push(prop);
       }); // end of basetable > tr > foreach
        contentJSON.push({"isRoot": isRoot, "className": modelName,"baseName": baseName, "props": props});
        console.log("生成模型:", modelName) 
     }
})();


// 类名生成器
function* classNameGenerator() {
    yield* classCollect;
}

async function readFile(filename) {
 let fullpath = path.join(__dirname, filename);
 console.log('start processing file:', fullpath);
 return await fs.readFile(fullpath, 'utf8')
 .catch(console.log);
}

async function createFile(filename) {
    let fullpath = path.join(__dirname, filename),
        stat = await fs.stat(fullpath).catch(e=>{
            console.log('create file', fullpath);
        });
    await fs.writeFile(fullpath, 'hey there')
    .catch(console.log);
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
    if(l_str.indexOf('string') >= 0) model_type = "NSString *";
    else if(['int', 'integer', 'long'].findIndex(v=>(new RegExp(v,'ig')).test(l_str)) >= 0) model_type = "NSInteger";
    else {
        console.log("====undefined type: =====", str);
        model_type = model + " *";
    }
    var_type  = isArray ? "NSArray<"+model_type+"> *" : model_type;;
    model_type = model_type.replace(' *','');
    return [var_type, model_type];
}

async function parseTemplate(data) {
    console.log("开始应用模板");
    // 暂时不支持别的语言, 为本项目使用(3个模板文件)
    // 以后要优化则要根据模板文件的个数有所个性化
    let copyright   = "民康",
        projectname = "项目名",
        date        = (new Date()).toLocaleDateString(),
        author      = "walker",
        // 模板内容
        h_content   = await fs.readFile(path.join(__dirname, 'template.h'), 'utf8').catch(console.log),
        m_content1  = await fs.readFile(path.join(__dirname, 'template.m'), 'utf8').catch(console.log),
        m_content2  = await fs.readFile(path.join(__dirname, 'templatebase.m'), 'utf8').catch(console.log);
    for(let model of data) {
        let m_content = model.isRoot ? m_content2 : m_content1;
        // 输出路径
        let h_file = path.join(__dirname, 'output', model.className+'.h'),
            m_file = path.join(__dirname, 'output', model.className+'.m');
        await fs.writeFile(h_file, eval(h_content), 'utf8').catch(console.log);
        await fs.writeFile(m_file, eval(m_content), 'utf8').catch(console.log);
    }
}
