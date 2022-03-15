#!/bin/bash
author='walker'
projectname='AfterSales'
passkeys='code,errorArgs,success,message'
fileuri='/Users/walker/Desktop/index.html'
debug=true
verbose=true
modulename='LARepairSettleViewModel'
prefix='LA'
skiptable=0
models=(
# 结算单详情 注意，这里利用了创建时的返回类，如果有字段不同就生成自己的类
'LARSettleOrderModel,LARSProjListItemModel,LARSPartListItemModel,LARSChargeListItemModel,LARSettleInfoModel'
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
    -x ${prefix} \
    -o ${skiptable}