#!/bin/bash
author='Evan'
projectname='Familydoctor'
passkeys='code,flag,message'
fileuri='/Users/Evan/Desktop/index.html'
debug=true
verbose=false
modulename='taskSign'
models=(
#根据身份证号码查询签约记录
'modelAgreementbycardNo'
'modelagreementServicePkgs'
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