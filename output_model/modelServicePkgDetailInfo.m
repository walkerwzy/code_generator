//
//  modelServicePkgDetailInfo.m
//  Homedoctor
//
//  Created by walker on 2017-9-18.
//  Copyright © 2017 WeDoctor Group  All rights reserved.
//

#import modelServicePkgDetailInfo.h

@implementation modelServicePkgDetailInfo

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return [NSDictionary mtl_identityPropertyMapWithModel:[self class]];
}


+ (NSValueTransformer *)detailDOListJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[modelServicePkgDetailContent class]];
}

@end