//
//  modelUserAgreementResponse.h
//  Homedoctor
// 
//  Created by walker on 2017-9-18.
//  Copyright © 2017 WeDoctor Group  All rights reserved.
// 

#import <PMRESTLib/PMRESTLib.h>
#import modelUserAgreementInfo.h


@interface modelUserAgreementResponse : PMLResponseModelBaseHD

/**
 *  
 */
@property (nonatomic, strong) modelUserAgreementInfo *data;


@end