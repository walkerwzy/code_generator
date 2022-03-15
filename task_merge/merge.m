//
//  LARepairSettleViewModel.h
//  AfterSales
// 
//  Created by walker on 2022/3/15.
//  Copyright © 2022 Lotus Technology  All rights reserved.
// 

#import "LARepairSettleViewModel.h"
#import "LAToast.h"

static NSString *const krequestMaintenanceSettleList = @"/web/aftersale/maintenanceSettle/maintenanceSettleList"; // 工单结算列表
static NSString *const krequestMaintenanceSettleExport = @"/web/aftersale/maintenanceSettle/maintenanceSettleExport"; // 工单结算列表导出
static NSString *const krequestCreateMaintenanceSettle = @"/web/aftersale//maintenanceSettle/createMaintenanceSettle"; // 创建预结算单
static NSString *const krequestMaintenanceSettleDetail = @"/web/aftersale//maintenanceSettle/maintenanceSettleDetail"; // 结算单详情
static NSString *const krequestUpdateCountRate = @"/web/aftersale/maintenanceSettle/updateCountRate"; // 调整折扣率
static NSString *const krequestUpdateAdjustAmount = @"/web/aftersale/maintenanceSettle/updateAdjustAmount"; // 调整金额
static NSString *const krequestSplitChargingObject = @"/web/aftersale/maintenanceSettle/splitChargingObject"; // 整单拆分
static NSString *const krequestUpdateSettlePreferential = @"/web/aftersale/maintenanceSettle/updateSettlePreferential"; // 变更维修结算单的优惠模式
static NSString *const krequestDeleteChargingObject = @"/web/aftersale/maintenanceSettle/deleteChargingObject"; // 删除收费对象
static NSString *const krequestConfirmMaintenanceSettle = @"/web/aftersale/maintenanceSettle/confirmMaintenanceSettle"; // 维修结算

@implementation LARepairSettleViewModel

+ (void)requestMaintenanceSettleList:(NSDictionary *)params success:(void (^)(LARSMaintenanceSettleListModel *  _Nonnull result))success failure:(void (^_Nonnull)(NSError * _Nonnull error))failure {
    [LAToast showProgressStatus];
    LCAfterRequest *request = [LCAfterRequest getRequestWithApiPath:krequestMaintenanceSettleList params:params];
    [request startRequestWithSuccess:^(id _Nonnull jsonObject) {
        [LAToast hideProgressStatus];
        NSMutableArray *array = [NSMutableArray array];
       [array addObjectsFromSafeArray:[LARSMaintenanceSettleListModel mj_objectArrayWithKeyValuesArray:jsonObject]];
       SafeBlockRun(success, array);
    } failure:^(NSError * _Nonnull error) {
        [LAToast hideProgressStatus];
        SafeBlockRun(failure,error);
    }];
}

+ (void)requestMaintenanceSettleExport:(NSDictionary *)params success:(void (^)(LARSMaintenanceSettleExportModel *  _Nonnull result))success failure:(void (^_Nonnull)(NSError * _Nonnull error))failure {
    [LAToast showProgressStatus];
    LCAfterRequest *request = [LCAfterRequest postRequestWithApiPath:krequestMaintenanceSettleExport params:params];
    [request startRequestWithSuccess:^(id _Nonnull jsonObject) {
        [LAToast hideProgressStatus];
        NSMutableArray *array = [NSMutableArray array];
       [array addObjectsFromSafeArray:[LARSMaintenanceSettleExportModel mj_objectArrayWithKeyValuesArray:jsonObject]];
       SafeBlockRun(success, array);
    } failure:^(NSError * _Nonnull error) {
        [LAToast hideProgressStatus];
        SafeBlockRun(failure,error);
    }];
}

+ (void)requestCreateMaintenanceSettle:(NSDictionary *)params success:(void (^)(LACreateMaintenanceSettleModel *  _Nonnull result))success failure:(void (^_Nonnull)(NSError * _Nonnull error))failure {
    [LAToast showProgressStatus];
    LCAfterRequest *request = [LCAfterRequest postRequestWithApiPath:krequestCreateMaintenanceSettle params:params];
    [request startRequestWithSuccess:^(id _Nonnull jsonObject) {
        [LAToast hideProgressStatus];
        NSMutableArray *array = [NSMutableArray array];
       [array addObjectsFromSafeArray:[LACreateMaintenanceSettleModel mj_objectArrayWithKeyValuesArray:jsonObject]];
       SafeBlockRun(success, array);
    } failure:^(NSError * _Nonnull error) {
        [LAToast hideProgressStatus];
        SafeBlockRun(failure,error);
    }];
}

+ (void)requestMaintenanceSettleDetail:(NSDictionary *)params success:(void (^)(LAMaintenanceSettleDetailModel *  _Nonnull result))success failure:(void (^_Nonnull)(NSError * _Nonnull error))failure {
    [LAToast showProgressStatus];
    LCAfterRequest *request = [LCAfterRequest getRequestWithApiPath:krequestMaintenanceSettleDetail params:params];
    [request startRequestWithSuccess:^(id _Nonnull jsonObject) {
        [LAToast hideProgressStatus];
        NSMutableArray *array = [NSMutableArray array];
       [array addObjectsFromSafeArray:[LAMaintenanceSettleDetailModel mj_objectArrayWithKeyValuesArray:jsonObject]];
       SafeBlockRun(success, array);
    } failure:^(NSError * _Nonnull error) {
        [LAToast hideProgressStatus];
        SafeBlockRun(failure,error);
    }];
}

+ (void)requestUpdateCountRate:(NSDictionary *)params success:(void (^)(id result))success failure:(void (^_Nonnull)(NSError * _Nonnull error))failure {
    [LAToast showProgressStatus];
    LCAfterRequest *request = [LCAfterRequest postRequestWithApiPath:krequestUpdateCountRate params:params];
    [request startRequestWithSuccess:^(id _Nonnull jsonObject) {
        [LAToast hideProgressStatus];
        SafeBlockRun(success, jsonObject);
    } failure:^(NSError * _Nonnull error) {
        [LAToast hideProgressStatus];
        SafeBlockRun(failure,error);
    }];
}

+ (void)requestUpdateAdjustAmount:(NSDictionary *)params success:(void (^)(id result))success failure:(void (^_Nonnull)(NSError * _Nonnull error))failure {
    [LAToast showProgressStatus];
    LCAfterRequest *request = [LCAfterRequest postRequestWithApiPath:krequestUpdateAdjustAmount params:params];
    [request startRequestWithSuccess:^(id _Nonnull jsonObject) {
        [LAToast hideProgressStatus];
        SafeBlockRun(success, jsonObject);
    } failure:^(NSError * _Nonnull error) {
        [LAToast hideProgressStatus];
        SafeBlockRun(failure,error);
    }];
}

+ (void)requestSplitChargingObject:(NSDictionary *)params success:(void (^)(id result))success failure:(void (^_Nonnull)(NSError * _Nonnull error))failure {
    [LAToast showProgressStatus];
    LCAfterRequest *request = [LCAfterRequest postRequestWithApiPath:krequestSplitChargingObject params:params];
    [request startRequestWithSuccess:^(id _Nonnull jsonObject) {
        [LAToast hideProgressStatus];
        SafeBlockRun(success, jsonObject);
    } failure:^(NSError * _Nonnull error) {
        [LAToast hideProgressStatus];
        SafeBlockRun(failure,error);
    }];
}

+ (void)requestUpdateSettlePreferential:(NSDictionary *)params success:(void (^)(id result))success failure:(void (^_Nonnull)(NSError * _Nonnull error))failure {
    [LAToast showProgressStatus];
    LCAfterRequest *request = [LCAfterRequest postRequestWithApiPath:krequestUpdateSettlePreferential params:params];
    [request startRequestWithSuccess:^(id _Nonnull jsonObject) {
        [LAToast hideProgressStatus];
        SafeBlockRun(success, jsonObject);
    } failure:^(NSError * _Nonnull error) {
        [LAToast hideProgressStatus];
        SafeBlockRun(failure,error);
    }];
}

+ (void)requestDeleteChargingObject:(NSDictionary *)params success:(void (^)(id result))success failure:(void (^_Nonnull)(NSError * _Nonnull error))failure {
    [LAToast showProgressStatus];
    LCAfterRequest *request = [LCAfterRequest postRequestWithApiPath:krequestDeleteChargingObject params:params];
    [request startRequestWithSuccess:^(id _Nonnull jsonObject) {
        [LAToast hideProgressStatus];
        SafeBlockRun(success, jsonObject);
    } failure:^(NSError * _Nonnull error) {
        [LAToast hideProgressStatus];
        SafeBlockRun(failure,error);
    }];
}

+ (void)requestConfirmMaintenanceSettle:(NSDictionary *)params success:(void (^)(id result))success failure:(void (^_Nonnull)(NSError * _Nonnull error))failure {
    [LAToast showProgressStatus];
    LCAfterRequest *request = [LCAfterRequest postRequestWithApiPath:krequestConfirmMaintenanceSettle params:params];
    [request startRequestWithSuccess:^(id _Nonnull jsonObject) {
        [LAToast hideProgressStatus];
        SafeBlockRun(success, jsonObject);
    } failure:^(NSError * _Nonnull error) {
        [LAToast hideProgressStatus];
        SafeBlockRun(failure,error);
    }];
}


@end