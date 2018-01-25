#!/bin/bash
author='maweefeng'
projectname='FamilyDoctor'
passkeys='code,flag,message'
fileuri='/Users/maweefeng/Desktop/index.html'
offset=1
debug=true
verbose=false
modulename='taskServiceRecord'
httpclient='PMLRESTBaseDoctor'
models=(
#服务包使用情况，服务历史列表
'modelServiceRecordItem',
#插入服务包使用情况


)

for model in ${models[@]}; do
    types=${types}${model},
done
types=${types}

if [ "$debug" = true ] ; then
    enableDebug='--debug'
fi

if [ "$verbose" = true ] ; then
    enableVerbose='--verbose'
fi

./app.js ${enableVerbose} ${enableDebug} \
    -C ${types} \
    -P ${passkeys} \
    -f ${fileuri} \
    -a ${author} \
    -m ${modulename} \
    -j ${projectname} \
    -B ${httpclient} \
    -o ${offset}
