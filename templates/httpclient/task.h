`//  ${modulename}.h
//  ${projectname}
// 
//  Created by ${author} on ${(new Date()).toLocaleDateString()}.
//  Copyright © ${(new Date()).getFullYear()} ${copyright}  All rights reserved.
// 

#import <Foundation/Foundation.h>
#import <WYTask/WYTask.h>
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
+ (void)${e.method}:(NSDictionary *_Nullable)params success:(void (^ _Nonnull)(${e.model} * _Nonnull result))success failure:(void (^ _Nonull)(NSError * _Nonull error))failure;`).join('').trim()}

@end`