#!/bin/bash
author='walker'
projectname='Homedoctor'
passkeys='code,flag,message'
fileuri='/Users/walker/Desktop/index.html'
debug=true
verbose=false
modulename='taskRelationship'
models=(
#编辑头像
#家人关系列表
'modelFamilyRelationListItem'
#家人列表
'modelFamilyMemeberListItem'
#解除绑定
#提交实名信息（废弃）
#添加实名认证（并提交）
#修改家人实名认证信息(废弃)
#家人认证详情
'modelFamilyAttestationDetailInfo'
#删除联系人
#切换当前用户
#撤回授权申请
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
