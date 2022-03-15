#!/bin/bash
author='walker'
projectname='FamilyDoctor'
passkeys='code,flag,message'
fileuri='/Users/walker/Desktop/index.html'
offset=1
debug=true
verbose=false
modulename='taskDoctorGroup'
httpclient='PMLRESTBaseDoctor'
models=(
#团队列表
modelDoctorGroupListItem,modelExpertRoleDOListItem
#团队详情
modelDoctorGroupInfo,modelExpertRoleDOListItem
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
