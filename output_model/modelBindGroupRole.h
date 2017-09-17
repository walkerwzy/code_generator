//
//  modelBindGroupRole.h
//  Homedoctor
// 
//  Created by walker on 2017-9-18.
//  Copyright © 2017 WeDoctor Group  All rights reserved.
// 

#import <PMRESTLib/PMRESTLib.h>
#import modelBindGroupDoctor.h


@interface modelBindGroupRole : PMLModelBase

/**
 * 角色名称
 */
@property (nonatomic, copy) NSString *roleName;

/**
 * 角色uuid
 */
@property (nonatomic, copy) NSString *uuid;

/**
 * 角色成员列表
 */
@property (nonatomic, strong) NSArray<modelBindGroupDoctor *> *expertList;


@end