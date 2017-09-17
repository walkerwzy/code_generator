//
//  modelGroupBindResponse.h
//  Homedoctor
// 
//  Created by walker on 2017-9-18.
//  Copyright © 2017 WeDoctor Group  All rights reserved.
// 

#import <PMRESTLib/PMRESTLib.h>
#import modelGroupBindInfo.h


@interface modelGroupBindResponse : PMLResponseModelBaseHD

/**
 *  
 */
@property (nonatomic, strong) modelGroupBindInfo *data;


@end