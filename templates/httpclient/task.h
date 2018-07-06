`//
// __        __      ____
// \\ \\      / /__   / ___|_ __ ___  _   _ _ __
//  \\ \\ /\\ / / _ \\ | |  _| '__/ _ \\| | | | '_ \\
//   \\ V  V /  __/ | |_| | | | (_) | |_| | |_) |
//    \\_/\\_/ \\___|  \\____|_|  \\___/ \\__,_| .__/ 
//                                       |_|
//
//  ${modulename}.h
//  ${projectname}
// 
//  Created by ${author} on ${(new Date()).toLocaleDateString()}.
//  Copyright © ${(new Date()).getFullYear()} ${copyright}  All rights reserved.
// 

#import <Foundation/Foundation.h>
${endpoints.map(m=>
`#import "${m.model}.h"
`).join('')}

@interface ${modulename} : ${httpclient}

${
endpoints.map(e=>`
/**
 * ${e.des}
 
${e.args.map(p=>
` * @param ${p}
`).join('')} */
+ (void)${e.method}:(NSDictionary *_Nullable)params success:(void (^ _Nonnull)(${e.model} * _Nullable response))success failure:(void (^ _Nullable)(NSError * _Nullable error))failure;`).join('').trim()}

@end`