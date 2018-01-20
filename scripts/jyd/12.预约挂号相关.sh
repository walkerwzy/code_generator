#!/bin/bash
author='zhangjie'
projectname='FamilyDoctor'
passkeys='code,flag,message'
fileuri='/Users/zhangjie/Desktop/index.html'
offset=1
debug=true
verbose=false
modulename='taskorderguahao'
httpclient='PMLRESTBaseDoctor'
models=(
#医生排班
'modelDoctorSchedulingList,modelDoctorshiftCaseList'
#获取下单配置
'modelOrderConfiguration,modelOrdertimeSectionsList,modelRequiredConfigModelsList,modelRequireEntrys,modelNameValues'
#提交订单
'modelOrdersubmit'
#订单列表
'modelOrdersubmitlist,modelOrdersubmitlistItem'
#订单详情
'modelOrderdetails'
#取消订单
'modelOrderCancel'
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
