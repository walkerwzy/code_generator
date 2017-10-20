let fs = require('fs-extra'),
    path = require('path'),
    strlist = 'list<string>',
    intlist = 'list<int>';

(async () => {

let data = await readFile("data.json");
let json = JSON.parse(data);
console.log("//========start========")
parsejson(json);
})().catch(console.log);

function parsejson(json, isRecursive) {
    for (let key in json) {
        let tplstr = "`@property (nonatomic, ${hold}) ${type}${name};`",
            hold = "copy",
            type = "NSString *",
            name = key,
            value = json[key];
        if(isRecursive) tplstr = "`// @property (nonatomic, ${hold}) ${type}${name};`";
        if(isInt(value)){
            hold = "assign";
            type = "NSInteger "
            console.log(eval(tplstr));
        }else if(isFloat(value)){
            hold = "assign";
            type = "CGFloat "
            console.log(eval(tplstr));
        }else{
            if(typeof value == 'object' && value != null) {
                // 碰到数组或对象, 执行一次子递归
                if(isArray(value)){
                    console.log(`//-------数组: ${key} 开始`);
                    parsejson(value[0], true);
                }else {
                    console.log(`//-------对象: ${key} 开始`);
                    parsejson(value, true);
                }
                console.log(`//-------${key} 结束`)
            }else{
                console.log(eval(tplstr));
            }
        }
    }
}

async function readFile(filename) {
 let fullpath = path.resolve(filename); 
 return await fs.readFile(fullpath, 'utf8').catch(console.log);
}

function isInt(n){
    return Number(n) === n && n % 1 === 0;
}

function isFloat(n){
    return Number(n) === n && n % 1 !== 0;
}

function isArray(n){
    return Object.prototype.toString.call(n) === '[object Array]'
}

// async function json_to_code () {
//     let copyright   = "WeDoctor Group",
//         projectname = "",
//         author      = "walker",
//         model_path  = "templates/model",
//         task_path   = "templates/httpclient",
//         // 模板内容
//         h_content   = await getFileContent(model_path, 'template.h'),
//         m_content1  = await getFileContent(model_path, 'template.m'),
//         m_content2  = await getFileContent(model_path, 'templatebase.m'),
//         h_task      = await getFileContent(task_path, 'task.h'),
//         m_task      = await getFileContent(task_path, 'task.m');
//     let out_model   = "output_model_single",
//         exist_file  = []; // 重复定义的类, 只生成一次, 生成过一次就丢到这个数组里打标
//     await fs.emptyDir(out_model); // 创建/清空输出文件夹
//     entities.forEach(async (model, index) => {
//         // 有些子类字段是一样的, 我们写脚本的时候把类名写成一样的, 此处会 pass 掉
//         // 但只对单次执行脚本有效
//         if(classCollect.filter(m=>m==model.className).length>1) {
//             if(exist_file.includes(model)) return;
//             exist_file.push(model);
//         }
//         let m_content = model.isRoot ? m_content2 : m_content1;
//         // 输出路径
//         let h_file = getPath(out_model, model.className+'.h'),
//             m_file = getPath(out_model, model.className+'.m');
//         await renderFile(h_file, eval(h_content)).catch(console.log);
//         await renderFile(m_file, eval(m_content)).catch(console.log);
//     });
// }