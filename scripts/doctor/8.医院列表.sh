#!/bin/bash
author='walker'
projectname='WYMTCPersonalModule'
passkeys=''
fileuri='/Users/walker/Desktop/index.html'
offset=1
debug=true
verbose=false
prefix='WYMTCPM'
modulename='taskDoctorInfo'
httpclient='NSObject'
models=(
#互联网医院列表
'hospitalDetail'
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
