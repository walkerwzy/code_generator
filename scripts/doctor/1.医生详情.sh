#!/bin/bash
author='walker'
projectname='WYMTCPersonalModule'
passkeys=''
fileuri='/Users/walker/Desktop/index.html'
offset=0
debug=true
verbose=false
prefix='WYMTCPM'
modulename='taskUserInfo'
httpclient='PMLRESTBaseDoctor'
models=(
#医生详情
'modelUserProfile'
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
    -B ${httpclient} \
    -o ${offset}
