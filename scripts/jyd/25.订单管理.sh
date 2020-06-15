#!/bin/bash
author='zhangjie'
projectname='FamilyDoctor'
passkeys='code,flag,message'
fileuri='/Users/zhangjie/Desktop/index.html'
offset=1
debug=true
verbose=false
modulename='taskordermanage'
httpclient='PMLRESTBaseDoctor'
models=(
#获取签约的订单详细订单包的信息
'modelDingDanBao,modelServicePkgItemDTOS'
#订单信息列表
'modelOrderInfolist,modelOrderInfolistItem,modelOrderInfolistItemOrderList'
#修改订单审核状态
# 'modelOrderStatus'
#添加服务订单
#订单详情
'modelOrderdetail,modelServicePkgOrderDetailDOS'
#订单服务包详情
'modelOrderFuwubaodetail,modelFuwuservicePkgItemDTOS'
#订单服务包取消
# 'modelOrderFuwubaodeCancel'
#订单消息列表
'modelOrderxiaoxilist,modelOrderxiaoxilistItem'
#订单未读消息数量
# 'modelOrderxiaoxiWeiDu'
#订单消息阅读
# 'modelOrderCancel'
#订单消息删除
# 'modelOrderCancel'
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
