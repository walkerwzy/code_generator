//
//  modelServicePkgDetailContent.h
//  Homedoctor
// 
//  Created by walker on 2017-9-18.
//  Copyright © 2017 WeDoctor Group  All rights reserved.
// 

#import <PMRESTLib/PMRESTLib.h>


@interface modelServicePkgDetailContent : PMLModelBase

/**
 * 总次数
 */
@property (nonatomic, assign) NSInteger count;

/**
 * 已使用次数
 */
@property (nonatomic, assign) NSInteger useCount;

/**
 * 标签
 */
@property (nonatomic, copy) NSString *tags;

/**
 * 项目类别
 */
@property (nonatomic, copy) NSString *projectCategory;

/**
 * 项目名称
 */
@property (nonatomic, copy) NSString *projectName;


@end