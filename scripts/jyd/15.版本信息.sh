#!/bin/bash
author='walker'
projectname='FamilyDoctor'
passkeys='code,flag,message'
fileuri='/Users/walker/Desktop/index.html'
offset=0
debug=true
verbose=false
modulename='taskVersionInfo'
models=(
#获取版本信息
'modelVersionInfo'
#下载地址(GET)
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
    -o ${offset}
