`//
//  ${model.className}.h
//  ${projectname}
// 
//  Created by ${author} on ${(new Date()).toLocaleDateString()}.
//  Copyright © ${(new Date()).getFullYear()} ${copyright}  All rights reserved.
// 

#import <PMRESTLib/PMRESTLib.h>
${model.props.filter(m=>m.model).map(prop =>
`#import ${prop.model}.h
`).join('')}

@interface ${model.className} : ${model.baseName}
${model.props.map(prop => {
if(prop.type == 'NSInteger') return `
/**
 * ${prop.des}
 */
@property (nonatomic, assign) ${prop.type} ${prop.name};
`;
else if(prop.type == 'NSString *') return `
/**
 * ${prop.des}
 */
@property (nonatomic, copy) ${prop.type}${prop.name};
`;
return `
/**
 * ${prop.des}
 */
@property (nonatomic, strong) ${prop.type}${prop.name};
`;}).join('')}

@end`