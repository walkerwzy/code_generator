//
//  modelAgreementTagInfo.h
//  Homedoctor
// 
//  Created by walker on 2017-9-18.
//  Copyright © 2017 WeDoctor Group  All rights reserved.
// 

#import <PMRESTLib/PMRESTLib.h>


@interface modelAgreementTagInfo : PMLModelBase

/**
 * 签约申请uuid 不可空
 */
@property (nonatomic, copy) NSString *agreementApplyUuid;

/**
 * 标签id 不可空
 */
@property (nonatomic, assign) NSInteger tagId;

/**
 *  标签名称 不可空
 */
@property (nonatomic, copy) NSString *tagName;


@end