#!/bin/bash

# models
models=(
#isbind
'modelIsQianYueResponse'
#bindagree
'modelBindPatientResponse'
#agreementtype
'modelAgreementTypeResponse,modelAgreementType'
#agreeuser
'modelUserAgreementResponse,modelUserAgreementInfo'
#agreegroup
'modelGroupBindResponse,modelGroupBindInfo,modelBindGroupRole,modelBindGroupDoctor'
#modify
'modelModifyBindResponse'
#useragreementlist
'modelUserBindListResponse,modelUBAgreementInfo'
#agreement
'modelAgreementDetailResponse,modelAgreementdetailInfo,modelAgreementServicePksInfo,modelAgreementTagInfo,modelAgreementAttatch'
#thirdpart
'modelThirdQueryBindDetailResponse,modelAgreementdetailInfo,modelAgreementServicePksInfo,modelAgreementTagInfo,modelAgreementAttatch'
#pkglist
'modelServicePkgsListResponse,modelServicePkgsListItem'
#pkddetail
'modelServicePkgDetailResponse,modelServicePkgDetailInfo,modelServicePkgDetailContent'
)
for name in ${models[@]}
do
	types=${types}${name},
done;
types=${types}cEOF
#如果 types 比较简单, 请直接覆盖types变量

datakeys=(
'detailDOList'
'agreementAttachs'
'agreementTags'
'agreementServicePkgs'
'expertList'
'groupRoleList'
)

for key in ${datakeys[@]}
do
	keys=${keys}${key},
done
keys=${keys}kEOF
echo keys;
#如果 datakey 比较简单, 请直接覆盖keys变量

./app.js \
    -C ${types} \
	-K ${keys} \
    -P code,flag,message \
    -f /Users/walker/Desktop/index.html \
    -a walker \
    -j HomeDoctor \
    -d true \
    -- verbose