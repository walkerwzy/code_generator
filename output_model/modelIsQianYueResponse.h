//
//  modelIsQianYueResponse.h
//  Homedoctor
// 
//  Created by walker on 2017-9-18.
//  Copyright © 2017 WeDoctor Group  All rights reserved.
// 

#import <PMRESTLib/PMRESTLib.h>


@interface modelIsQianYueResponse : PMLResponseModelBaseHD

/**
 * 是否存在标识 如存在返回true，不存在为false
 */
@property (nonatomic, copy) NSString *data;


@end