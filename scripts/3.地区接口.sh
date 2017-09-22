#!/bin/bash
author='jiangli'
projectname='Homedoctor'
passkeys='code,flag,message'
fileuri='/Users/jiangli/Desktop/index.html'
debug=true
verbose=false
modulename='taskArea'
models=(
#地区列表
'modelAreaListList'
#根据IP地址定位省市区
'modelAreaGetbyipItem'
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
