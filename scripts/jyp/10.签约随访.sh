#!/bin/bash
author='walker'
projectname='Homedoctor'
passkeys='code,flag,message'
fileuri='/Users/walker/Desktop/index.html'
debug=true
verbose=false
modulename='taskFollowUp'
models=(
#随访模板列表
'modelFollowTemplateListItem'
#随访模板详情
'modelFollowTemplateDetail,modelFollowTemplateDetailField,modelFollowTemplateFieldOption'
#随访记录列表
'modelFollowUpListItem'
#随访评价
#随访详情
'modelFollowUpDetailInfo,modelFollowUpDetailField'
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