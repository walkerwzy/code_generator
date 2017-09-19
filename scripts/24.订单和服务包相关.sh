#!/bin/bash
author='walker'
projectname='Homedoctor'
passkeys='code,flag,message'
fileuri='/Users/walker/Desktop/index.html'
debug=true
verbose=false
models=(
#获取扫码后待操作的订单
#订单列表
'modelOrderListDetail'
#服务包退订
#去支付（修改订单状态为待支付）
#线下支付
#订单拒绝
#订单确认
#订单取消
#生成签约服务订单
#获取配置项
'modelOrderConfigInfo,modelOrderConfigShowItem,modelOrderConfigRequireItem'
#保存草稿
'modelAgreementTagsInfo'
#修改草稿
'modelAgreementTagsInfo'
#草稿详情
'modelAgreemntOrderDetailInfo,modelAgreementAttatch,modelAgreementTagsInfo'
#订单校验
#订单支付
'modelOrderSubmitInfo'
#订单详情
'modelOrderDetailInfo,modelOrderDetailImgInfo,modelOrderDetailPkgItem'
#服务包详情
'modelServicePackageInfo,modelServicePackageDO'
#服务包列表（签约个人和签约团队的所有服务包）
'modelServicePackageInfo'
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