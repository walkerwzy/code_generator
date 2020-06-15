#!/bin/bash
author='Evan'
projectname='FamilyDoctor'
passkeys='code,flag,message'
fileuri='/Users/Evan/Desktop/index.html'
offset=1
debug=true
verbose=true
modulename='taskSignArea'
httpclient='PMLRESTBaseDoctor'
models=(
#根据上级区域ID获取街道信息
'modelSignareaGetListUnderDistrictData'
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
