#!/bin/bash
author='walker'
projectname='FamilyDoctor'
passkeys='code,flag,message'
fileuri='/Users/walker/Desktop/index.html'
offset=0
debug=true
verbose=false
modulename='taskStatistics'
httpclient='PMLRESTBaseDoctor'
models=(
#签约统计
modelStatisticAgreementByYear
#签约统计(月)
modelStatisticAgreementByMonth,modelStatisticExpertCountMonthDO,modelStatisticFocusNumMonthDO
#服务统计
modelStatisticServiceByYear,modelStatisticServiceTopItem
#服务统计(月)
modelStatisticServiceMonthDO
#服务统计明细列表
modelStatisticServiceList,modelStatisticServiceListItem
#签约统计明细列表
modelStatisticAgreementList,modelStatisticAgreementListItem
#导出服务统计明细列表
#导出签约统计明细列表
#重点人群统计
modelStatisticKeyCrowdDetail,modelStatisticKeyCrowdListItem
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
