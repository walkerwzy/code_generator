//
//  modelAgreementdetailInfo.m
//  Homedoctor
//
//  Created by walker on 2017-9-18.
//  Copyright © 2017 WeDoctor Group  All rights reserved.
//

#import modelAgreementdetailInfo.h

@implementation modelAgreementdetailInfo

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return [NSDictionary mtl_identityPropertyMapWithModel:[self class]];
}


+ (NSValueTransformer *)agreementServicePkgsJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[modelAgreementServicePksInfo class]];
}
+ (NSValueTransformer *)agreementTagsJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[modelAgreementTagInfo class]];
}
+ (NSValueTransformer *)agreementAttachsJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[modelAgreementAttatch class]];
}

@end