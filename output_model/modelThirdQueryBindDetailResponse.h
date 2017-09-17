//
//  modelThirdQueryBindDetailResponse.h
//  Homedoctor
// 
//  Created by walker on 2017-9-18.
//  Copyright © 2017 WeDoctor Group  All rights reserved.
// 

#import <PMRESTLib/PMRESTLib.h>
#import modelAgreementdetailInfo.h


@interface modelThirdQueryBindDetailResponse : PMLResponseModelBaseHD

/**
 * 
 */
@property (nonatomic, strong) modelAgreementdetailInfo *data;


@end