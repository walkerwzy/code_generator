./app.js \
    -C modelIsQianYueResponse,modelBindPatientResponse,modelAgreementTypeResponse,\
modelAgreementType,modelUserAgreementResponse,modelUserAgreementInfo,modelGroupBindResponse,\
modelGroupBindInfo,modelBindGroupRole,modelBindGroupDoctor,modelModifyBindResponse,\
modelUserBindListResponse,modelUBAgreementInfo,modelAgreementDetailResponse,\
modelAgreementdetailInfo,modelAgreementServicePksInfo,modelAgreementTagInfo,\
modelAgreementAttatch,modelThirdQueryBindDetailResponse,nouse1,nouse2,nouse3,nouse4,\
modelServicePkgsListResponse,modelServicePkgsListItem,modelServicePkgDetailResponse,\
modelServicePkgDetailInfo,modelServicePkgDetailContent \
	-K detailDOList,agreementAttachs,agreementTags,agreementServicePkgs,expertList,groupRoleList \
    -P code,flag,message \
    -f /Users/walker/Desktop/index.html \
    -a walker \
    -j HomeDoctor \
    -d true \
    --verbose

