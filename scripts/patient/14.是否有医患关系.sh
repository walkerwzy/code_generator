#!/bin/bash
author='walker'
projectname='WYMTCPatientModule'
passkeys=''
fileuri='/Users/walker/Desktop/index.html'
offset=1
debug=true
verbose=false
prefix='WYMTCPT'
modulename='taskDoctorInfo'
httpclient='NSObject'
models=(
#与当前医生是否有医患关系
'PatientRelationDO'
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
