#!/bin/bash
author='walker'
projectname='Homedoctor'
passkeys='code,flag,message'
fileuri='/Users/walker/Desktop/index.html'
debug=true
verbose=false
modulename=taskAgreementRel
models=(
'是否存在绑定关系:modelIsQianYueResponse'
'绑定签约关系:modelBindPatientResponse'
'查询用户签约信息类别:modelAgreementTypeResponse,modelAgreementType'
'查询签约信息（个人签约）:modelUserAgreementResponse,modelUserAgreementInfo'
'查询签约信息（团队签约）:modelGroupBindResponse,modelGroupBindInfo,modelBindGroupRole,modelBindGroupDoctor'
'修改用户默认签约关系:modelModifyBindResponse'
'查询居民签约信息列表:modelUserBindListResponse,modelUBAgreementInfo'
'查询签约详情:modelAgreementDetailResponse,modelAgreementdetailInfo,modelAgreementServicePksInfo,modelAgreementTagInfo,modelAgreementAttatch'
'查询签约详情（第三方，非登陆）:modelThirdQueryBindDetailResponse,modelAgreementdetailInfo,modelAgreementServicePksInfo,modelAgreementTagInfo,modelAgreementAttatch'
'签约套餐列表信息:modelServicePkgsListResponse,modelServicePkgsListItem'
'签约服务包详情:modelServicePkgDetailResponse,modelServicePkgDetailInfo,modelServicePkgDetailContent'
)
datakeys=(
'detailDOList'
'agreementAttachs'
'agreementTags'
'agreementServicePkgs'
'expertList'
'groupRoleList'
)

for model in ${models[@]}; do
	desp=${desp}${model%%:*},
	types=${types}${model#*:},
done
types=${types}
desp=${desp}

for key in ${datakeys[@]}; do
	keys=${keys}${key},
done
keys=${keys}
# 如果 datakey 比较简单, 请直接覆盖keys变量

if [ "$debug" = true ] ; then
	enableDebug='--debug'
fi

if [ "$verbose" = true ] ; then
	enableVerbose='--verbose'
fi

./app.js ${enableVerbose} ${enableDebug} \
    -C ${types} \
    -D ${desp} \
	-K ${keys} \
    -P ${passkeys} \
    -f ${fileuri} \
    -a ${author} \
    -m ${modulename} \
    -j ${projectname}