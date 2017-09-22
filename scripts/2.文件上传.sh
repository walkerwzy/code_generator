#!/bin/bash
author='Evan'
projectname='Homedoctor'
passkeys='code,flag,message'
fileuri='/Users/Evan/Desktop/index.html'
debug=true
verbose=false
modulename='taskFileUpload'
models=(
#文件上传
'modelFileUpload'
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
    -j ${projectname}