//
//  modelBindGroupRole.m
//  Homedoctor
//
//  Created by walker on 2017-9-18.
//  Copyright © 2017 WeDoctor Group  All rights reserved.
//

#import modelBindGroupRole.h

@implementation modelBindGroupRole

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return [NSDictionary mtl_identityPropertyMapWithModel:[self class]];
}


+ (NSValueTransformer *)expertListJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[modelBindGroupDoctor class]];
}

@end