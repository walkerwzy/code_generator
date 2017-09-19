#!/bin/bash
author='walker'
projectname='Homedoctor'
passkeys='code,flag,message'
fileuri='/Users/walker/Desktop/index.html'
debug=true
verbose=false
modulename='taskServicePackage'
models=(
#签约套餐列表
'modelServiceListItem'
#查询服务套餐信息
'modelServiceDetailInfo,modelServiceRecordLiteItem'
#签约医生或团队的服务包列表
'modelServiceListItem2'
#查询服务包中疾病标签列表（作废）
'modelServiceDiseaseItem'
#查询服务包中针对人群标签列表（所有人群，和服务包id无关）
'modelServiceCrowdTagItem'
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