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
# 调整折扣率
''
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