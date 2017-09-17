//
//  modelAgreementType.h
//  Homedoctor
// 
//  Created by walker on 2017-9-18.
//  Copyright © 2017 WeDoctor Group  All rights reserved.
// 

#import <PMRESTLib/PMRESTLib.h>


@interface modelAgreementType : PMLModelBase

/**
 * 签约关系类别 1个人签约，2是团队签约
 */
@property (nonatomic, assign) NSInteger type;


@end