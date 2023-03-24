`//  ${model.className}.m
//  ${projectname}
// 
//  Created by ${author} on ${(new Date()).toLocaleDateString()}.
//  Copyright © ${(new Date()).getFullYear()} ${copyright}  All rights reserved.
// 

#import "${model.className}.h"

@implementation ${model.className}

${[0].map(_ => { if(model.hasIdKey) return `
+(NSDictionary*)mj_replacedKeyFromPropertyName{
    return @{@"theId": @"id"};
}`;
}).join('')}

+(NSDictionary *)mj_objectClassInArray{
    return @{${model.props.map(prop => { if(prop.isObject) return `
		@"${prop.name}": @"${prop.innerType}",`; else return '';
}).join('')}
    };
}

@end`