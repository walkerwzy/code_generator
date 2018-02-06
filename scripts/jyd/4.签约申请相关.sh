#!/bin/bash
author='Evan'
projectname='FamilyDoctor'
passkeys='code,flag,message'
fileuri='/Users/Evan/Desktop/index.html'
offset=1
debug=true
verbose=false
modulename='taskAgreementapply'
httpclient='PMLRESTBaseDoctor'
models=(
#查询签约申请配置信息
'modelAgreementapplyGetConfigData','modelAgreementapplyGetConfigServices'
#新建签约申请（草稿）
'modelAgreementapplyAddData'
#修改签约申请（草稿）
'modelAgreementapplyModifyData'
#提交签约申请（审核）
'modelAgreementapplySubmitData'
#删除签约申请（放弃签约）
'modelAgreementapplyDeleteData'
#签约申请详情
'modelAgreementapplyDetailData'
'modelAgreementapplyDetailAgreementServicePkgs'
'modelAgreementapplyDetailAgreementTags'
'modelAgreementapplyDetailCrowdRelationDTOS'
'modelAgreementapplyDetailAgreementAttachs'
#签约申请详情(只获取展示的有效字段)
'modelAgreementapplyBriefDetailData'
#签约申请列表
'modelAgreementapplyListData','modelAgreementapplyListItems','modelAgreementapplyListAgreementServicePkgs'
#医生确认签约关系修改相关信息接口
'modelAgreementapplyUpdateAgreementInfo'
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
