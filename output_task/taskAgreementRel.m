//
//  taskAgreementRel.h
//  Homedoctor
// 
//  Created by walker on 2017-9-18.
//  Copyright © 2017 WeDoctor Group  All rights reserved.
// 

#import "taskAgreementRel.h"

#define kEndpointmethodAgreementIsbind			@"/agreement/isbind.json"		// 是否存在绑定关系
#define kEndpointmethodAgreementBindpatient			@"/agreement/bindpatient.json"		// 绑定签约关系
#define kEndpointmethodAgreementType			@"/agreement/type.json"		// 查询用户签约信息类别
#define kEndpointmethodAgreementInfo			@"/agreement/info.json"		// 查询签约信息（个人签约）
#define kEndpointmethodAgreementGroupinfo			@"/agreement/groupinfo.json"		// 查询签约信息（团队签约）
#define kEndpointmethodAgreementUpdatedefault			@"/agreement/updatedefault.json"		// 修改用户默认签约关系
#define kEndpointmethodAgreementList			@"/agreement/list.json"		// 查询居民签约信息列表
#define kEndpointmethodAgreementDetail			@"/agreement/detail.json"		// 查询签约详情
#define kEndpointmethodAgreementDetailbyct			@"/agreement/detailbyct.json"		// 查询签约详情（第三方，非登陆）
#define kEndpointmethodAgreementServicepkgList			@"/agreement/servicepkg/list.json"		// 签约套餐列表信息
#define kEndpointmethodAgreementServicepkgDetail			@"/agreement/servicepkg/detail.json"		// 签约服务包详情

@implementation taskAgreementRel

PMTASK_INIT_SINGLETON

+ (NSDictionary<NSString *,id> *)modelClassesByResourcePath {
    return @{
				kEndpoint/agreement/isbind.json:		[modelIsQianYueResponse class],
				kEndpoint/agreement/bindpatient.json:		[modelBindPatientResponse class],
				kEndpoint/agreement/type.json:		[modelAgreementTypeResponse class],
				kEndpoint/agreement/info.json:		[modelUserAgreementResponse class],
				kEndpoint/agreement/groupinfo.json:		[modelGroupBindResponse class],
				kEndpoint/agreement/updatedefault.json:		[modelModifyBindResponse class],
				kEndpoint/agreement/list.json:		[modelUserBindListResponse class],
				kEndpoint/agreement/detail.json:		[modelAgreementDetailResponse class],
				kEndpoint/agreement/detailbyct.json:		[modelThirdQueryBindDetailResponse class],
				kEndpoint/agreement/servicepkg/list.json:		[modelServicePkgsListResponse class],
				kEndpoint/agreement/servicepkg/detail.json:		[modelServicePkgDetailResponse class]
             };
}


PMTASK_EXPORT_IMP(methodAgreementIsbind, modelIsQianYueResponse)
PMTASK_EXPORT_IMP(methodAgreementBindpatient, modelBindPatientResponse)
PMTASK_EXPORT_IMP(methodAgreementType, modelAgreementTypeResponse)
PMTASK_EXPORT_IMP(methodAgreementInfo, modelUserAgreementResponse)
PMTASK_EXPORT_IMP(methodAgreementGroupinfo, modelGroupBindResponse)
PMTASK_EXPORT_IMP(methodAgreementUpdatedefault, modelModifyBindResponse)
PMTASK_EXPORT_IMP(methodAgreementList, modelUserBindListResponse)
PMTASK_EXPORT_IMP(methodAgreementDetail, modelAgreementDetailResponse)
PMTASK_EXPORT_IMP(methodAgreementDetailbyct, modelThirdQueryBindDetailResponse)
PMTASK_EXPORT_IMP(methodAgreementServicepkgList, modelServicePkgsListResponse)
PMTASK_EXPORT_IMP(methodAgreementServicepkgDetail, modelServicePkgDetailResponse)

@end