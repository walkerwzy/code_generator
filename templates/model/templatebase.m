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
    NSDictionary *dict = [NSDictionary mtl_identityPropertyMapWithModel:[self class]];
    return [super mergeDict:dict withDict:[super JSONKeyPathsByPropertyKey]];
}

${model.props.map(prop => {
if(prop.type=='NSInteger') return `
+ (NSValueTransformer *)${prop.name}JSONTransformer {
	return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
	    NSString *str = [NSString stringWithFormat:@"%@", value];
	    NSInteger i = [str integerValue];
	    return @(i);
	}];
}`;
if(!prop.model) return '';
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