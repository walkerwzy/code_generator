#!/bin/bash
author='walker'
projectname='Homedoctor'
passkeys='code,flag,message'
fileuri='/Users/walker/Desktop/index.html'
debug=true
verbose=false
models=(
#获取配置信息
'modelAgreementConfigResponse,modelAgreementConfigInfo'
#查询签约申请详情
'modelAgreementDetailResponse,modelAgreementDetailInfo,modelAgreementServicePkgItem,modelAgreementTagItem,modelAgreementAttathItem'
#新建签约申请（草稿）
'modelAgreementApplyAddResponse'
#修改签约申请（草稿）
'modelAgreementApplyModifyResponse'
#提交签约申请（审核）
'modelAgreementSubmitResponse,modelAgreementSubmitInfo'
#删除签约申请订单
'modelAgreementApplyDelResponse'
#查询签约申请列表
'modelAgreementApplyListResponse,modelAgreementApplyListItem'
)
datakeys=(
'agreementServicePkgs'
'agreementTags'
'agreementAttachs'
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