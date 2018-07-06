`//
// __        __      ____
// \\ \\      / /__   / ___|_ __ ___  _   _ _ __
//  \\ \\ /\\ / / _ \\ | |  _| '__/ _ \\| | | | '_ \\
//   \\ V  V /  __/ | |_| | | | (_) | |_| | |_) |
//    \\_/\\_/ \\___|  \\____|_|  \\___/ \\__,_| .__/ 
//                                       |_|
//
//  ${model.className}.h
//  ${projectname}
//
//  Created by ${author} on ${(new Date()).toLocaleDateString()}.
//  Copyright © ${(new Date()).getFullYear()} ${copyright}  All rights reserved.
// 


#import <Foundation/Foundation.h>
${model.props.filter(m=>m.model).map(prop =>
`#import "${prop.model}.h"
`).join('')}

@interface ${model.className} : ${model.baseName}
${model.props.map(prop => {
if(prop.type == 'NSInteger') return `
/**
 * ${prop.des}
 */
@property (nonatomic, assign) ${prop.type} ${prop.name};
`;
else if(prop.type == 'CGFloat') return `
/**
 * ${prop.des}
 */
@property (nonatomic, assign) ${prop.type} ${prop.name};
`;
else if(prop.type == 'NSString *') return `
/**
 * ${prop.des}
 */
@property (nonatomic, copy) ${prop.type} ${prop.name};
`;
else if(prop.type == 'BOOL') return `
/**
 * ${prop.des}
 */
@property (nonatomic, assign) ${prop.type} ${prop.name};
`;
return `
/**
 * ${prop.des}
 */
@property (nonatomic, strong) ${prop.type}${prop.name};
`;}).join('').trim()}

@end`