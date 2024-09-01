* 解析文档html页面, 自动生成实体类(默认提供objective-c模板, 可自定义其它语言模板), 请求类
* 不同分支支持confuence, swagger, yapi
* 主要还是根据对应的后端的编辑习惯形成的DOM结构具体来调整, 一般不可能立等可取

# 演示

1. node js请升级到最新版
2. `npm install`
3. `./run.sh` 或 `bash run.sh`

# 基本使用

```
./app.js -C aaa,bbb,ccc -K aaa,bbb,ccc -P aaa,bbb,ccc
```

或

```
./app.js -c aaa -c bbb -k aaa -k bbb -p aaa -p ccc
```

视参数多少自行使用, 

# 项目使用

请详阅`run.sh`
1. 根据项目和接口实际情况修改`run.sh`头部的变量
2. 遍历文档, 以接口为单位, 为每一个接口设定自定义的类名
    + 有必要的话, 修改文档格式, 我们默认的格式为: |`字段变量`|`字段名`|`字段类型`|`说明`|
    + 如果格式不对, 比如字段类型不在第三列, 将中止解析. 去更改原始文档再试吧
3. 遍历文档, 把简单类型以外的字段提到 `datakey` 变量
4. 请新建一个script文件夹, 每一个接口生成一个script文件, 以保留对该接口的类定义
5. 每次生成的 Model 会在根目录的`output`文件夹, 请更名为接口名后应用到项目中去
6. 文件地址给的是绝对路径, 如果要给相对路径, 请从源码根目录开始

# 参数介绍

+ 类名: 本次生成所需要用到的所有自定义类名, 请按文档顺序自上而下. 目前请保证参数个数与需要的个数一致, 用`-c`一次一个, 可重复, 或`-C`, 逗号分隔, 不支持空格
+ 基类名: 见示例. 目前只支持两个基类 `-b`
+ 不处理的键: 跳过, 不写到文件, 如果有基类的情况, 适用此属性. `-p, -P`
+ 子类对应的键: 如果该键对应的是一个对象或对象数组, 请传入键名. `-k, -K`

请用`-h`命令查看更多帮助

# 模板介绍

模板文件用ES2015的模板字符串语法编写, 请参阅[文档](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Template_literals), 或项目里的模板文件示例 
