//
//  modelUserAgreementInfo.h
//  Homedoctor
// 
//  Created by walker on 2017-9-18.
//  Copyright © 2017 WeDoctor Group  All rights reserved.
// 

#import <PMRESTLib/PMRESTLib.h>


@interface modelUserAgreementInfo : PMLModelBase

/**
 * 签约关系uuid
 */
@property (nonatomic, copy) NSString *agreementUuid;

/**
 * 签约申请uuid
 */
@property (nonatomic, copy) NSString *agreementApplyUuid;

/**
 * 签约医生所在医院ID
 */
@property (nonatomic, copy) NSString *hospitalId;

/**
 * 签约医生所在医院名称
 */
@property (nonatomic, copy) NSString *hospitalName;

/**
 * 签约医生所在医院地址
 */
@property (nonatomic, copy) NSString *hospitalAdd;

/**
 * 签约医生ID
 */
@property (nonatomic, copy) NSString *expertId;

/**
 * 签约医生用户ID
 */
@property (nonatomic, assign) NSInteger expertUserId;

/**
 * 签约医生姓名
 */
@property (nonatomic, copy) NSString *expertName;

/**
 * 签约医生头像
 */
@property (nonatomic, copy) NSString *expertImg;

/**
 * 签约医生职称
 */
@property (nonatomic, copy) NSString *techTitle;

/**
 * 签约医生性别
 */
@property (nonatomic, copy) NSString *sex;

/**
 * 擅长
 */
@property (nonatomic, copy) NSString *feature;

/**
 * 服务年限
 */
@property (nonatomic, copy) NSString *serviceYear;

/**
 * 患者所属用户id
 */
@property (nonatomic, assign) NSInteger patientUserId;

/**
 * 就诊人id
 */
@property (nonatomic, assign) NSInteger patientId;

/**
 * 就诊人姓名
 */
@property (nonatomic, copy) NSString *patientName;

/**
 * 就诊人头像地址
 */
@property (nonatomic, copy) NSString *patientImg;


@end