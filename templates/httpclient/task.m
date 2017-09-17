`//
//  ${modulename}.h
//  ${projectname}
// 
//  Created by ${author} on ${(new Date()).toLocaleDateString()}.
//  Copyright © ${(new Date()).getFullYear()} ${copyright}  All rights reserved.
// 

#import "${modulename}.h"
${endpoints.map(e=>`
#define kEndpoint${e.method}			@"${e.path}"		// ${e.des}`).join('')}

@implementation ${modulename}

PMTASK_INIT_SINGLETON

+ (NSDictionary<NSString *,id> *)modelClassesByResourcePath {
    return @{${endpoints.map(e=>`
				kEndpoint${e.method}:		[${e.model} class],`).join('').slice(0,-1)}
             };
}

${endpoints.map(e=>`
PMTASK_EXPORT_IMP(${e.method}, ${e.model})`).join('')}

@end`
