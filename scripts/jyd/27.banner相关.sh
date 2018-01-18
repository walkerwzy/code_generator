#!/bin/bash
author='walker'
projectname='FamilyDoctor'
passkeys='code,flag,message'
fileuri='/Users/walker/Desktop/index.html'
offset=1
debug=true
verbose=false
modulename='taskBanner'
httpclient='PMLRESTBaseDoctor'
models=(
#banner列表
modelBannerListItem
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
