# 基本使用

```
./app.js -C aaa,bbb,ccc -K aaa,bbb,ccc -P aaa,bbb,ccc
```

或

```
./app.js -c aaa -c bbb -k aaa -k bbb -p aaa -p ccc
```

视参数多少自行使用, 

或者将带参数命令写入`run.sh`文件并执行该文件

# 参数介绍

+ 类名: 本次生成所需要用到的所有自定义类名, 请按文档顺序自上而下. 目前请保证参数个数与需要的个数一致, 用`-c`一次一个, 可重复, 或`-C`, 逗号分隔, 不支持空格
+ 基类名: 见示例. 目前只支持两个基类 `-b`
+ 不处理的键: 跳过, 不写到文件, 如果有基类的情况, 适用此属性. `-p, -P`
+ 子类对应的键: 如果该键对应的是一个对象或对象数组, 请传入键名. `-k, -K`

请用`-h`命令查看更多帮助

# 模板介绍

模板文件用ES2015的模板字符串语法编写, 请参阅[文档](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Template_literals) 
