#!/bin/bash
author='walker'
projectname='Homedoctor'
passkeys='code,flag,message'
fileuri='/Users/walker/Desktop/index.html'
debug=true
verbose=false
modulename=taskAgreementApply
models=(
#获取配置信息
'modelAgreementConfigInfo'
#查询签约申请详情
'modelAgreementApplyDetailInfo,modelAgreementServicePkgItem,modelAgreementTagItem,modelAgreementAttathItem'
#新建签约申请（草稿）
#修改签约申请（草稿）
#提交签约申请（审核）
'modelAgreementSubmitInfo'
#删除签约申请订单
#查询签约申请列表
'modelAgreementApplyListItem'
)
datakeys=(
'agreementServicePkgs'
'agreementTags'
'agreementAttachs'
)

# for model in ${models[@]}; do
# 	desp=${desp}${model%%:*},
# 	types=${types}${model#*:},
# done
# types=${types}
# desp=${desp}

for model in ${models[@]}; do
    types=${types}${model},
done
types=${types}

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
	-K ${keys} \
    -P ${passkeys} \
    -f ${fileuri} \
    -a ${author} \
    -m ${modulename} \
    -j ${projectname}