//
//  modelUBAgreementInfo.h
//  Homedoctor
// 
//  Created by walker on 2017-9-18.
//  Copyright © 2017 WeDoctor Group  All rights reserved.
// 

#import <PMRESTLib/PMRESTLib.h>


@interface modelUBAgreementInfo : PMLModelBase

/**
 * 签约关系UUID
 */
@property (nonatomic, copy) NSString *agreementUuid;

/**
 * 签约申请UUID
 */
@property (nonatomic, copy) NSString *agreementApplyUuid;

/**
 * 医生标准id
 */
@property (nonatomic, copy) NSString *expertId;

/**
 * 医生姓名
 */
@property (nonatomic, copy) NSString *expertName;

/**
 * 就诊人id
 */
@property (nonatomic, assign) NSInteger patientId;

/**
 * 姓名
 */
@property (nonatomic, copy) NSString *patientName;

/**
 * 患者头像照片地址
 */
@property (nonatomic, copy) NSString *patientImg;

/**
 * 签约时间
 */
@property (nonatomic, copy) NSString *signTime;

/**
 * 生效时间
 */
@property (nonatomic, copy) NSString *effectiveTime;

/**
 * 失效时间
 */
@property (nonatomic, copy) NSString *invalidTime;

/**
 * 签约关系状态 数据字典
 */
@property (nonatomic, assign) NSInteger status;

/**
 * 是否默认签约关系 数据字典
 */
@property (nonatomic, assign) NSInteger isDefault;


@end