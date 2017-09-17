//
//  modelAgreementServicePksInfo.h
//  Homedoctor
// 
//  Created by walker on 2017-9-18.
//  Copyright © 2017 WeDoctor Group  All rights reserved.
// 

#import <PMRESTLib/PMRESTLib.h>


@interface modelAgreementServicePksInfo : PMLModelBase

/**
 * 签约申请uuid 不可空
 */
@property (nonatomic, copy) NSString *agreementApplyUuid;

/**
 * 服务套餐id  不可空
 */
@property (nonatomic, assign) NSInteger servicePkgId;


@end