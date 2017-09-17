//
//  modelGroupBindInfo.m
//  Homedoctor
//
//  Created by walker on 2017-9-18.
//  Copyright © 2017 WeDoctor Group  All rights reserved.
//

#import modelGroupBindInfo.h

@implementation modelGroupBindInfo

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return [NSDictionary mtl_identityPropertyMapWithModel:[self class]];
}


+ (NSValueTransformer *)groupRoleListJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[modelBindGroupRole class]];
}

@end