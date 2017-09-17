//
//  modelAgreementAttatch.h
//  Homedoctor
// 
//  Created by walker on 2017-9-18.
//  Copyright © 2017 WeDoctor Group  All rights reserved.
// 

#import <PMRESTLib/PMRESTLib.h>


@interface modelAgreementAttatch : PMLModelBase

/**
 * 签约申请uuId 不可空
 */
@property (nonatomic, copy) NSString *agreementApplyUuid;

/**
 * 证件资料类型1-未知2-身份证3-户口本4-医保卡5-签约协议 不可空
 */
@property (nonatomic, assign) NSInteger status;

/**
 *  证件资料图片地址 不可空
 */
@property (nonatomic, copy) NSString *attachUrl;


@end