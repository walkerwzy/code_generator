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
`+ (void)${e.method}:(NSDictionary *)params success:(void (^)(${e.model} * _Nonull result))success failure:(void (^_Nonnull)(NSError * _Nonnull error))failure {
    [LAToast showProgressStatus];
    LCAfterRequest *request = [LCAfterRequest ${e.req_method.toLowerCase()}RequestWithApiPath:k${e.method} params:params];
    
    [request startRequestWithSuccess:^(id _Nonnull jsonObject) {
        [LAToast hideProgressStatus];${[1].map(_=>{if(e.model.indexOf("NSArray") >= 0) return `
    NSMutableArray *array = [NSMutableArray array];
   [array addObjectsFromSafeArray:[${e.model} mj_objectArrayWithKeyValuesArray:jsonObject]];
   SafeBlockRun(success, array);`;
    else return `
        SafeBlockRun(success, [${e.model} mj_objectWithKeyValues:jsonObject]);`
;}).join('')}
    } failure:^(NSError * _Nonnull error) {
        [LAToast hideProgressStatus];
        SafeBlockRun(failure,error);
    }];
}`).join('').trim()}

@end`
