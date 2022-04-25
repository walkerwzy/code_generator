#!/bin/bash
author='walker'
projectname='AfterSales'
passkeys='code,errorArgs,success,message'
fileuri='/Users/walker/Desktop/index.html'
debug=true
verbose=true
modulename='LAReverseSettleViewModel'
prefix='LARS'
skiptable=0
models=(
# 工单结算列表
'LAMaintenancePayListItemModel'
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