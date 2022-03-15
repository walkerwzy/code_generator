`//
//  ${modulename}.h
//  ${projectname}
// 
//  Created by ${author} on ${(new Date()).toLocaleDateString()}.
//  Copyright © ${(new Date()).getFullYear()} ${copyright}  All rights reserved.
// 

#import "${modulename}.h"
${endpoints.map(e=>`
static NSString *const k${e.method} = @"${e.path}"; // ${e.des}`).join('')}

@implementation ${modulename}

${endpoints.map(e=>
`+ (void)${e.method}:(NSDictionary *)params success:(void (^)(${e.model.param} result))success failure:(void (^ _Nullable)(NSError *  _Nullable error))failure {
    [LAToast showProgressStatus];
    LCAfterRequest *request = [LCAfterRequest ${e.req_method.toLowerCase()}RequestWithApiPath:k${e.method} params:params];
    [request startRequestWithSuccess:^(id _Nonnull jsonObject) {
        [LAToast hideProgressStatus];${[1].map(_=> {
if(e.isPrimary) return `
        SafeBlockRun(success, jsonObject);`;
if(e.isArray) return `
        NSMutableArray *array = [NSMutableArray array];
       [array addObjectsFromSafeArray:[${e.model.type} mj_objectArrayWithKeyValuesArray:jsonObject]];
       SafeBlockRun(success, array);`;
return `
        SafeBlockRun(success, [${e.model} mj_objectWithKeyValues:jsonObject]);`
}).join('')}
    } failure:^(NSError * _Nonnull error) {
        [LAToast hideProgressStatus];
        SafeBlockRun(failure,error);
    }];
}`).join('').trim()}

@end`
