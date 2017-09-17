//
//  modelServicePkgDetailInfo.h
//  Homedoctor
// 
//  Created by walker on 2017-9-18.
//  Copyright © 2017 WeDoctor Group  All rights reserved.
// 

#import <PMRESTLib/PMRESTLib.h>
#import modelServicePkgDetailContent.h


@interface modelServicePkgDetailInfo : PMLModelBase

/**
 * 服务包总量
 */
@property (nonatomic, assign) NSInteger count;

/**
 * 服务包名称
 */
@property (nonatomic, copy) NSString *pkgName;

/**
 * 服务包内容
 */
@property (nonatomic, copy) NSString *pkgContent;

/**
 * 服务开始日期
 */
@property (nonatomic, copy) NSString *serStartDate;

/**
 * 服务结束日期
 */
@property (nonatomic, copy) NSString *serEndDate;

/**
 * 金额（分）
 */
@property (nonatomic, assign) NSInteger fee;

/**
 * 疾病标签
 */
@property (nonatomic, copy) NSString *diseaseTags;

/**
 * 针对人群
 */
@property (nonatomic, copy) NSString *crows;

/**
 * 已经服务的内容列表
 */
@property (nonatomic, strong) NSArray<modelServicePkgDetailContent *> *detailDOList;


@end