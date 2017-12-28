#!/bin/bash
author='walker'
projectname='Homedoctor'
passkeys='code,flag,message'
fileuri='/Users/walker/Desktop/index.html'
debug=true
verbose=false
modulename='taskMessage'
models=(
#订单消息列表
'modelOrderMessageListItem'
#设置订单消息为已读
#签约提醒消息列表
'modelMessageListItem'
#设置签约消息为已读
#服务预约消息列表
'modelServiceMessageListItem'
#设置服务预约消息为已读
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
