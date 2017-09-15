#!/bin/bash
author='walker'
projectname='Homedoctor'
passkeys='code,flag,message'
fileuri='/Users/walker/Desktop/index.html'
models=(
#获取扫码后待操作的订单
'modelPendingOrderListResponse'
#订单列表
'modelOrderListResponse,modelOrderListDetail'
#服务包退订
'modelServicePackageTDResponse'
#去支付（修改订单状态为待支付）
'modelOrderToPayResponse'
#线下支付
'modelOfflinePayResonse'
#订单拒绝
'modelOrderRefuseResponse'
#订单确认
'modelOrderConfirmResponse'
#订单取消
'modelOrderCancelResponse'
#生成签约服务订单
'modelOrderQianyueResponse'
#获取配置项
'modeOrdereConfigResponse,modelOrderConfigInfo,modelOrderConfigShowItem,modelOrderConfigRequireItem'
#保存草稿
'modelOrderSaveResponse,modelAgreementTagsInfo'
#修改草稿
'modelOrderModifyResponse,modelAgreementTagsInfo'
#草稿详情
'modelAgreementOrderDetailResponse,modelAgreemntOrderDetailInfo,modelAgreementAttatch,modelAgreementTagsInfo'
#订单校验
'modelOrderApplyResponse'
#订单支付
'modelOrderSubmitResponse,modelOrderSubmitInfo'
#订单详情
'modelOrderDetailResponse,modelOrderDetailInfo,modelOrderDetailImgInfo,modelOrderDetailPkgItem'
#服务包详情
'modelServicePackageResponse,modelServicePackageInfo,modelServicePackageDO'
#服务包列表（签约个人和签约团队的所有服务包）
'modelServicePkgListResponse,modelServicePackageInfo'
)
datakeys=(
'infoIsshow'
'isRequired'
'agreementAttachs'
'agreementTags'
'servicePkgDOList'
'servicePkgItemDOList'
'imgUrls'
)
debug=true
verbose=false

for name in ${models[@]}; do
	types=${types}${name},
done;
types=${types}cEOF
#如果 types 比较简单, 请直接覆盖types变量

for key in ${datakeys[@]}; do
	keys=${keys}${key},
done
keys=${keys}kEOF
#如果 datakey 比较简单, 请直接覆盖keys变量

if [ "$debug" = true ] ; then
	enableDebug='--debug'
fi

if [ "$verbose" = true ] ; then
	enableVerbose='--verbose'
fi

./app.js ${enableVerbose} ${enableDebug} \
    -C ${types} \
	-K ${keys} \
    -P ${passkeys} \
    -f ${fileuri} \
    -a ${author} \
    -j ${projectname}