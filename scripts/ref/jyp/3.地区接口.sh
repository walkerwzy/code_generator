#!/bin/bash
author='Evan'
projectname='Homedoctor'
passkeys='code,flag,message'
fileuri='/Users/walker/Desktop/index.html'
debug=true
verbose=false
modulename='taskArea'
models=(
#根据经纬度获取省市区
'modelDistrictDetail'
#地区列表
'modelAreaListItem'
#根据IP地址定位省市区
'modelDistrictDetailPatient'
#通过地区国标码查询地区信息
'modelAreaByCode'
#根据groupUUID获取团队服务区域
'modelGroupServiceArea'
#获取所有开通家医地区省市
'modelOpenedArea'
#根据省市获取省市区
'modelDistrictDetail'
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
    -j ${projectname}
