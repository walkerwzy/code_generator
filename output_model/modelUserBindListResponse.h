//
//  modelUserBindListResponse.h
//  Homedoctor
// 
//  Created by walker on 2017-9-18.
//  Copyright © 2017 WeDoctor Group  All rights reserved.
// 

#import <PMRESTLib/PMRESTLib.h>
#import modelUBAgreementInfo.h


@interface modelUserBindListResponse : PMLResponseModelBaseHD

/**
 * 当前页数 从 0开始，0代表第一页
 */
@property (nonatomic, assign) NSInteger pageIndex;

/**
 * 一页大小
 */
@property (nonatomic, assign) NSInteger pageSize;

/**
 * 总数
 */
@property (nonatomic, assign) NSInteger total;

/**
 *  
 */
@property (nonatomic, strong) NSArray<modelUBAgreementInfo *> *data;


@end