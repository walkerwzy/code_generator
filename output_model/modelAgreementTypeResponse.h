//
//  modelAgreementTypeResponse.h
//  Homedoctor
// 
//  Created by walker on 2017-9-18.
//  Copyright © 2017 WeDoctor Group  All rights reserved.
// 

#import <PMRESTLib/PMRESTLib.h>
#import modelAgreementType.h


@interface modelAgreementTypeResponse : PMLResponseModelBaseHD

/**
 *  
 */
@property (nonatomic, strong) modelAgreementType *data;


@end