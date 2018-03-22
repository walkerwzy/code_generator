#!/bin/bash
author='maweefeng'
projectname='FamilyDoctor'
passkeys='code,flag,message'
fileuri='/Users/maweefeng/Desktop/index.html'
offset=1
debug=true
verbose=false
modulename='taskAgreement'
httpclient='PMLRESTBaseDoctor'
models=(
#签约关系列表
'modelAgreeDataList','modelAgreeDataListItem','modelAgreeServicePkgsItem'
#签约居民基础信息(只获取展示的有效字段)
'modelAgreementCitizenItem' 'modelAgreementagreementAttachDTOList' 'modelAgreementcrowdRelationDOList'

#签约关系详情
'modelAgreeDetailList','modelAgreementServicePkgsItem','modelServicePkgOrderDTOListItem','modelAgreementTagsListItem','modeltxWdInfoListItem'
#修改签约居民信息

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
