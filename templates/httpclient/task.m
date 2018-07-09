`//
//  ${modulename}.h
//  ${projectname}
// 
//  Created by ${author} on ${(new Date()).toLocaleDateString()}.
//  Copyright © ${(new Date()).getFullYear()} ${copyright}  All rights reserved.
// 

#import "${modulename}.h"
${endpoints.map(e=>`
static NSString *const k${e.method.replace('task','')} = @"${e.path}"; // ${e.des}`).join('')}

@implementation ${modulename}

${endpoints.map(e=>
`+ (WYTask *)${e.method}:(NSDictionary *)params success:(void (^)(${e.model} * _Nullable))success failure:(void (^)(NSError * _Nullable))failure {
    WYTask *task = [[WYTask alloc] initWithURL:k${e.method.replace('task','')}];
    task.needAutomaticLoadingView = NO;
    [task startWithParams:params success:^(NSDictionary *response) {
        success([${e.model} wy_modelWithDictionary:response]);
    } failure:^(NSError *error) {
        failure(error);
    }];
    return task;
}`).join('').trim()}

@end`
