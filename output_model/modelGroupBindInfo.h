//
//  modelGroupBindInfo.h
//  Homedoctor
// 
//  Created by walker on 2017-9-18.
//  Copyright © 2017 WeDoctor Group  All rights reserved.
// 

#import <PMRESTLib/PMRESTLib.h>
#import modelBindGroupRole.h


@interface modelGroupBindInfo : PMLModelBase

/**
 * 签约关系uuid
 */
@property (nonatomic, copy) NSString *agreementUuid;

/**
 * 签约申请uuid
 */
@property (nonatomic, copy) NSString *agreementApplyUuid;

/**
 * 签约团队所在医院ID
 */
@property (nonatomic, copy) NSString *hospitalId;

/**
 * 签约团队所在医院名称（所属社区）
 */
@property (nonatomic, copy) NSString *hospitalName;

/**
 * 团队头像（绝对路径）
 */
@property (nonatomic, copy) NSString *groupImg;

/**
 * 团队名称
 */
@property (nonatomic, copy) NSString *groupName;

/**
 * 电话
 */
@property (nonatomic, copy) NSString *fixTelephone;

/**
 * 团队简介
 */
@property (nonatomic, copy) NSString *groupRemark;

/**
 * 团队角色列表
 */
@property (nonatomic, strong) NSArray<modelBindGroupRole *> *groupRoleList;


@end