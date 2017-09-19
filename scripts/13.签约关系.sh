#!/bin/bash
author='walker'
projectname='Homedoctor'
passkeys='code,flag,message'
fileuri='/Users/walker/Desktop/index.html'
debug=true
verbose=false
modulename='taskAgreementRel'
models=(
#是否存在绑定关系
#绑定签约关系
#查询用户签约信息类别
'modelAgreementType'
#查询签约信息（个人签约）
'modelUserAgreementInfo'
#查询签约信息（团队签约）
'modelGroupBindInfo,modelBindGroupRole,modelBindGroupDoctor'
#修改用户默认签约关系
#查询居民签约信息列表
'modelUBAgreementInfo'
#查询签约详情
'modelAgreementDetailInfo,modelAgreementServicePksItem,modelAgreementTagItem,modelAgreementAttatchItem'
#查询签约详情（第三方，非登陆）
'modelAgreementDetailInfo3rd,modelAgreementServicePksItem,modelAgreementTagItem,modelAgreementAttatchItem'
#签约套餐列表信息
'modelServicePkgsListItem'
#签约服务包详情
'modelServicePkgDetailInfo,modelServicePkgDetailContent'
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