//
//  modelServicePkgsListResponse.h
//  Homedoctor
// 
//  Created by walker on 2017-9-18.
//  Copyright © 2017 WeDoctor Group  All rights reserved.
// 

#import <PMRESTLib/PMRESTLib.h>
#import modelServicePkgsListItem.h


@interface modelServicePkgsListResponse : PMLResponseModelBaseHD

/**
 *  
 */
@property (nonatomic, strong) NSArray<modelServicePkgsListItem *> *data;


@end