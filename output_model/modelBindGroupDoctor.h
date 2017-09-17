//
//  modelBindGroupDoctor.h
//  Homedoctor
// 
//  Created by walker on 2017-9-18.
//  Copyright © 2017 WeDoctor Group  All rights reserved.
// 

#import <PMRESTLib/PMRESTLib.h>


@interface modelBindGroupDoctor : PMLModelBase

/**
 * 医生userid
 */
@property (nonatomic, copy) NSString *doctorUserId;

/**
 * 医生姓名
 */
@property (nonatomic, copy) NSString *doctorName;


@end