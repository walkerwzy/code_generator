`//
//  ${model.className}.m
//  ${projectname}
//
//  Created by ${author} on ${(new Date()).toLocaleDateString()}.
//  Copyright © ${(new Date()).getFullYear()} ${copyright}  All rights reserved.
//

#import ${model.className}.h

@implementation ${model.className}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return [NSDictionary mtl_identityPropertyMapWithModel:[self class]];
}

${model.props.filter(m=>m.model&&m.isArray).map(prop => 
`+ (NSValueTransformer *)${prop.name}JSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[${prop.model} class]];
}`).join()}

${model.props.filter(m=>m.model&&!m.isArray).map(prop => 
`+ (NSValueTransformer *)${prop.name}JSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[${prop.model} class]];
}`).join()}

@end`