#!/bin/bash
author='walker'
projectname='Homedoctor'
passkeys='code,flag,message'
fileuri='/Users/walker/Desktop/index.html'
debug=true
verbose=false
modulename='taskDrugOrder'
models=(
#创建购药订单
'modelDrugOrderInfo,modelDrugOrderBuyListItem'
#购药订单详情
'modelDrugOrderInfo,modelDrugOrderBuyListItem'
#购药订单列表
'modelDrugOrderInfo,modelDrugOrderBuyListItem'
#查询购药订单物流信息
'modelDrugExpressInfo,modelDrugExpressListItem'
#删除购药订单信息
#取消未支付购药订单
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