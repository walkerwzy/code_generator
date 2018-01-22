#!/bin/bash
author='maweefeng'
projectname='FamilyDoctor'
passkeys='code,flag,message'
fileuri='/Users/maweefeng/Desktop/index.html'
offset=1
debug=true
verbose=false
modulename='taskCrowdlist'
httpclient='PMLRESTBaseDoctor'
models=(
#人群划分Data
'modelCrowdListData'
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
