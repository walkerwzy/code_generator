`//
//  ${modulename}.h
//  ${projectname}
// 
//  Created by ${author} on ${(new Date()).toLocaleDateString()}.
//  Copyright © ${(new Date()).getFullYear()} ${copyright}  All rights reserved.
// 

#import <PMRESTLib/PMRESTLib.h>
${endpoints.map(m=>
`#import "${m.model}.h"
`).join('')}

@interface ${modulename} : PMLRESTBaseHD
${
endpoints.map(e=>`
/**
 * ${e.des}
 */
- (NSURLSessionDataTask *)${e.method}:(NSDictionary *)params completion:(void (^)(${e.model} *response, NSError *error))completion;`).join('')}

@end`