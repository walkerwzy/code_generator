#!/bin/bash
author='walker'
projectname='WYMTCPaitentModule'
passkeys=''
fileuri='/Users/Evan/Desktop/index.html'
offset=1
debug=true
verbose=false
prefix='WYMTCPT'
modulename='taskDoctorInfo'
httpclient='NSObject'
models=(
#返回问诊接诊医生信息
'ConsultDoctorList','ConsultDoctorDO'
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
