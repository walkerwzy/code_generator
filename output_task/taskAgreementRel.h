//
//  taskAgreementRel.h
//  Homedoctor
// 
//  Created by walker on 2017-9-18.
//  Copyright © 2017 WeDoctor Group  All rights reserved.
// 

#import <PMRESTLib/PMRESTLib.h>
#import modelIsQianYueResponse;
#import modelBindPatientResponse;
#import modelAgreementTypeResponse;
#import modelUserAgreementResponse;
#import modelGroupBindResponse;
#import modelModifyBindResponse;
#import modelUserBindListResponse;
#import modelAgreementDetailResponse;
#import modelThirdQueryBindDetailResponse;
#import modelServicePkgsListResponse;
#import modelServicePkgDetailResponse;


@interface taskAgreementRel : PMLRESTBaseHD

/**
 * 是否存在绑定关系
 */
- (NSURLSessionDataTask *)methodAgreementIsbind:(NSDictionary *)params completion:(void (^)(modelIsQianYueResponse *response, NSError *error))completion;
/**
 * 绑定签约关系
 */
- (NSURLSessionDataTask *)methodAgreementBindpatient:(NSDictionary *)params completion:(void (^)(modelBindPatientResponse *response, NSError *error))completion;
/**
 * 查询用户签约信息类别
 */
- (NSURLSessionDataTask *)methodAgreementType:(NSDictionary *)params completion:(void (^)(modelAgreementTypeResponse *response, NSError *error))completion;
/**
 * 查询签约信息（个人签约）
 */
- (NSURLSessionDataTask *)methodAgreementInfo:(NSDictionary *)params completion:(void (^)(modelUserAgreementResponse *response, NSError *error))completion;
/**
 * 查询签约信息（团队签约）
 */
- (NSURLSessionDataTask *)methodAgreementGroupinfo:(NSDictionary *)params completion:(void (^)(modelGroupBindResponse *response, NSError *error))completion;
/**
 * 修改用户默认签约关系
 */
- (NSURLSessionDataTask *)methodAgreementUpdatedefault:(NSDictionary *)params completion:(void (^)(modelModifyBindResponse *response, NSError *error))completion;
/**
 * 查询居民签约信息列表
 */
- (NSURLSessionDataTask *)methodAgreementList:(NSDictionary *)params completion:(void (^)(modelUserBindListResponse *response, NSError *error))completion;
/**
 * 查询签约详情
 */
- (NSURLSessionDataTask *)methodAgreementDetail:(NSDictionary *)params completion:(void (^)(modelAgreementDetailResponse *response, NSError *error))completion;
/**
 * 查询签约详情（第三方，非登陆）
 */
- (NSURLSessionDataTask *)methodAgreementDetailbyct:(NSDictionary *)params completion:(void (^)(modelThirdQueryBindDetailResponse *response, NSError *error))completion;
/**
 * 签约套餐列表信息
 */
- (NSURLSessionDataTask *)methodAgreementServicepkgList:(NSDictionary *)params completion:(void (^)(modelServicePkgsListResponse *response, NSError *error))completion;
/**
 * 签约服务包详情
 */
- (NSURLSessionDataTask *)methodAgreementServicepkgDetail:(NSDictionary *)params completion:(void (^)(modelServicePkgDetailResponse *response, NSError *error))completion;

@end