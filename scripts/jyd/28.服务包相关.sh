#!/bin/bash
author='Evan'
projectname='Familydoctor'
passkeys='code,flag,message'
fileuri='/Users/maweefeng/Desktop/index.html'
offset=1
debug=true
verbose=true
modulename='taskServicePkg'
httpclient='PMLRESTBaseDoctor'
models=(
#服务包列表
'modelServicePkgListData'
'modelServicePkgListItems'
#服务包详情
'modelServicePkgDetailData'
'modelServicePkgDetailitemList'
#服务包退订
#团队服务包查询
'modelServicePkgGroupDataList'
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
