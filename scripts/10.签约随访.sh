#!/bin/bash
author='walker'
projectname='Homedoctor'
passkeys='code,flag,message'
fileuri='/Users/walker/Desktop/index.html'
debug=true
verbose=false
models=(
# 随访模板列表
'modelFollowTemplateListResponse,modelFollowTemplateListItem'
# 随访模板详情
'modelFollowTemplateDetailResponse,modelFollowTemplateDetail,modelFollowTemplateDetailField,modelFollowTemplateFieldOption'
# 随访记录列表
'modelFollowUpListResponse,modelFollowUpListItem'
# 随访评价
'modelFollowEvaluateResponse'
# 随访详情
'modelFollowUpDetailResponse,modelFollowUpDetailInfo,modelFollowUpDetailField'
)
datakeys=(
'fields'
'options'
)

for name in ${models[@]}; do
	types=${types}${name},
done;
types=${types}cEOF
#如果 types 比较简单, 请直接覆盖types变量

for key in ${datakeys[@]}; do
	keys=${keys}${key},
done
keys=${keys}kEOF
#如果 datakey 比较简单, 请直接覆盖keys变量

if [ "$debug" = true ] ; then
	enableDebug='--debug'
fi

if [ "$verbose" = true ] ; then
	enableVerbose='--verbose'
fi

./app.js ${enableVerbose} ${enableDebug} \
    -C ${types} \
	-K ${keys} \
    -P ${passkeys} \
    -f ${fileuri} \
    -a ${author} \
    -j ${projectname}