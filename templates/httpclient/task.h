`//  ${modulename}.h
//  ${projectname}
// 
//  Created by ${author} on ${(new Date()).toLocaleDateString()}.
//  Copyright © ${(new Date()).getFullYear()} ${copyright}  All rights reserved.
// 

#import <Foundation/Foundation.h>
${endpoints.filter(m=>m.model.type!="id").map(m=>
`#import "${m.model.type}.h"
`).join('')}
NS_ASSUME_NONNULL_BEGIN

@interface ${modulename} : ${httpclient}

${
endpoints.map(e=>`/// ${e.des}${e.args.map(p=>`
/// @param ${p}`).join('')}
- (void)${e.method}:(NSDictionary *_Nullable)params success:(void (^ _Nullable)(${e.model.param} result))success failure:(void (^ _Nullable)(NSError * _Nullable error))failure;`).join('').trim()}

@end

NS_ASSUME_NONNULL_END`