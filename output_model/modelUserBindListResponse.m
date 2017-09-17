//
//  modelUserBindListResponse.m
//  Homedoctor
//
//  Created by walker on 2017-9-18.
//  Copyright © 2017 WeDoctor Group  All rights reserved.
//

#import modelUserBindListResponse.h

@implementation modelUserBindListResponse

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSDictionary *dict = [NSDictionary mtl_identityPropertyMapWithModel:[self class]];
    return [super mergeDict:dict withDict:[super JSONKeyPathsByPropertyKey]];
}


+ (NSValueTransformer *)dataJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[modelUBAgreementInfo class]];
}

@end