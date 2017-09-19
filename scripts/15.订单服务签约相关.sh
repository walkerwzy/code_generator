#!/bin/bash
author='walker'
projectname='Homedoctor'
passkeys='code,flag,message'
fileuri='/Users/walker/Desktop/index.html'
debug=true
verbose=false
modulename='taskAgreementApply'
models=(
#获取配置信息
'modelAgreementApplyConfigInfo'
#查询签约申请详情
'modelAgreementApplyDetailInfo,modelAgreementApplyServicePkgItem,modelAgreementApplyTagItem,modelAgreementApplyAttathItem'
#新建签约申请（草稿）
#修改签约申请（草稿）
#提交签约申请（审核）
'modelAgreementApplySubmitInfo'
#删除签约申请订单
#查询签约申请列表
'modelAgreementApplyListItem'
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