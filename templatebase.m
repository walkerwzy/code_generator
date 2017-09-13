`//
//  ${model.className}.m
//  ${projectname}
//
//  Created by ${author} on ${date}.
//  Copyright © 2017 ${copyright}  All rights reserved.
//

#import ${model.className}.h

@implementation ${model.className}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSDictionary *dict = [NSDictionary mtl_identityPropertyMapWithModel:[self class]];
    return [super mergeDict:dict withDict:[super JSONKeyPathsByPropertyKey]];
}

${model.props.filter(m=>m.model).map(prop => 
`+ (NSValueTransformer *)${prop.name}JSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[${prop.model} class]];
}`).join()}

@end`