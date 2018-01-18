#!/bin/bash
author='walker'
projectname='FamilyDoctor'
passkeys='code,flag,message'
fileuri='/Users/walker/Desktop/index.html'
offset=1
debug=true
verbose=false
modulename='taskUserInfo'
httpclient='PMLRESTBaseDoctor'
models=(
#用户登录
'modelUserProfile'
#修改用户密码
#找回密码
#微信免登陆
'modelUesrWechat'
#退出登录
#个人信息
'modelUserDoctorInfo'
#更改医生个人信息
#获取签约患者的头像和姓名
'modelUserDisplayInfo'
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
