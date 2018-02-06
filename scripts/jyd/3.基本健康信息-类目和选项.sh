#!/bin/bash
author='Evan'
projectname='FamilyDoctor'
passkeys='code,flag,message'
fileuri='/Users/Evan/Desktop/index.html'
offset=0
debug=true
verbose=true
modulename='taskAgrmhealth'
httpclient='PMLRESTBaseDoctor'
models=(
#基本健康信息模版
'modelAgrmhealthListData','modelAgrmhealthListAgrmFieldDOList','modelAgrmhealthListAgrmFieldOptionDOList'
#添加健康基本信息
'modelAgrmhealthAddData'
#查询基本健康信息详情
'modelAgrmhealthDetailData','modelAgrmhealthDetailAgrmSubmitFieldDOList','modelAgrmhealthDetailAgrmSubmitOptionDOList'
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
