`//
//  ${model.className}.m
//  ${projectname}
//
//  Created by ${author} on ${(new Date()).toLocaleDateString()}.
//  Copyright © ${(new Date()).getFullYear()} ${copyright}  All rights reserved.
//

#import "${model.className}.h"

@implementation ${model.className}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	${model.hasIdKey ? `NSMutableDictionary *dict = [[NSDictionary  mtl_identityPropertyMapWithModel:[self class]] mutableCopy];
    [dict setObject:@"id" forKey:@"recordId"];
    return dict;` : 'return [NSDictionary  mtl_identityPropertyMapWithModel:[self class]];'};
}

${model.props.filter(m=>m.model).map(prop => {
if(prop.isArray) return `
+ (NSValueTransformer *)${prop.name}JSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[${prop.model} class]];
}`;
return`
+ (NSValueTransformer *)${prop.name}JSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[${prop.model} class]];
}`;
}).join('')}

@end`