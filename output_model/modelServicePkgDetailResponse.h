//
//  modelServicePkgDetailResponse.h
//  Homedoctor
// 
//  Created by walker on 2017-9-18.
//  Copyright © 2017 WeDoctor Group  All rights reserved.
// 

#import <PMRESTLib/PMRESTLib.h>
#import modelServicePkgDetailInfo.h


@interface modelServicePkgDetailResponse : PMLResponseModelBaseHD

/**
 *  
 */
@property (nonatomic, strong) modelServicePkgDetailInfo *data;


@end