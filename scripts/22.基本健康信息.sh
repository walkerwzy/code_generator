#!/bin/bash
author='walker'
projectname='Homedoctor'
passkeys='code,flag,message'
fileuri='/Users/walker/Desktop/index.html'
debug=true
verbose=false
modulename='taskAgrmHealth'
models=(
#基本健康信息模版
'modelAgrmHealthListItem,modelAgrmFieldItem,modelAgrmFieldOptionListItem'
#根据签约申请Id或者签约关系id查询基本健康信息
'modelAgrmSubmitFormListItem,modelAgrmSubmitFieldListItem,modelAgrmSubmitOptionListItem'
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