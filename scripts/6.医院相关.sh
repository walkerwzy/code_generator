#!/bin/bash
author='walker'
projectname='Homedoctor'
passkeys='code,flag,message'
fileuri='/Users/walker/Desktop/index.html'
debug=true
verbose=false
modulename='taskHospital'
models=(
#医院列表
'modelHospitalListItem'
#签约时间列表
'modelHosSignareaTimeInfo'
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