#!/bin/bash
author='Evan'
projectname='Familydoctor'
passkeys='code,flag,message'
fileuri='/Users/Evan/Desktop/index.html'
debug=true
verbose=false
modulename='taskServicePkg'
models=(
#随访模板列表
'modelSuiFangModelListData'
#随访模板详情
'modelSuiFangData'
'modelSuiFangField'
'modelSuiFangOptions'
#添加随访
'modelSuiFangAddfields'
#更新随访
'modelOrderFuwubaodetail,modelFuwuservicePkgItemDTOS'
#随访列表
'modelSuiFangListData'
'modelSuiFangListItems'
#随访详情
'modelSuiFangDetailData'
'modelSuiFangDetailField'
'modelSuiFangDetailOptions'
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