//  LARepairSettleViewModel.h
//  AfterSales
// 
//  Created by walker on 2022/3/15.
//  Copyright © 2022 Lotus Technology  All rights reserved.
// 

#import <Foundation/Foundation.h>
#import <WYTask/WYTask.h>
#import "LARSMaintenanceSettleListModel.h"
#import "LARSMaintenanceSettleExportModel.h"
#import "LACreateMaintenanceSettleModel.h"
#import "LAMaintenanceSettleDetailModel.h"


@interface LARepairSettleViewModel : NSObject

/**
 * 工单结算列表
 * @param maintenanceNo 否  工单号
 * @param maintenanceSettleNo 否  结算单号
 * @param plateNoOrVin 否  车牌或VIN码
 * @param orderStatus 否  工单状态
 * @param dateType 否  日期类型（CREATE_DATE-工单创建日期，SETTLE_DATE-结算日期,FULL_PAYMENT-结清日期）
 * @param startDate 否  开始日期
 * @param saId 否  服务顾问ID
 * @param maintenanceTypeCode 否  维修类型
 * @param carOwner 否  车主姓名
 * @param carSeriesId 否  车系
 * @param carModelId 否  车型
 * @param carStyleId 否  车款
 * @param settleAmount 否  结算金额大于
 * @param eliveryStatus 否  是否交车（0-未交车,1-已交车）
 * @param fullPaymentStatus 否  是否结清（0-未结清,1-已结清）
 * @param hasClaim 否  是否含索赔（0-不含索赔，1-含有索赔）
 * @param pageSize 是  每页大小
 * @param pageNum 是  页码
 * @param endDate 否  结束日期
 */
+ (void)requestMaintenanceSettleList:(NSDictionary *_Nullable)params success:(void (^ _Nonnull)(LARSMaintenanceSettleListModel *  _Nonnull result))success failure:(void (^ _Nonull)(NSError * _Nonull error))failure;

/**
 * 工单结算列表导出
 * @param maintenanceNo string 非必须  工单号 
 * @param maintenanceSettleNo string 非必须  结算单号 
 * @param plateNoOrVin string 非必须  车牌号或VIN码 
 * @param orderStatus string 非必须  工单状态 
 * @param dateType string 非必须  日期类型（CREATE_DATE-工单创建日期，SETTLE_DATE-结算日期,FULL_PAYMENT-结清日期） 
 * @param startDate string 非必须  开始日期 
 * @param endDate string 非必须  结束日期 
 * @param saId string 非必须  服务顾问ID 
 * @param maintenanceTypeCode string 非必须  维修类型编码 
 * @param carOwner string 非必须  车主姓名 
 * @param carSeriesId number 非必须  车系id 
 * @param carModelId number 非必须  车型id 
 * @param carStyleId number 非必须  车款id 
 * @param settleAmount number 非必须  结算金额大于 
 * @param eliveryStatus string 非必须  是否交车（0-未交车,1-已交车） 
 * @param fullPaymentStatus string 非必须  是否结清（0-未结清,1-已结清） 
 * @param hasClaim string 非必须  是否含索赔（0-不含索赔，1-含有索赔） 
 */
+ (void)requestMaintenanceSettleExport:(NSDictionary *_Nullable)params success:(void (^ _Nonnull)(LARSMaintenanceSettleExportModel *  _Nonnull result))success failure:(void (^ _Nonull)(NSError * _Nonull error))failure;

/**
 * 创建预结算单
 * @param maintenanceOrderId number 必须  工单id 
 */
+ (void)requestCreateMaintenanceSettle:(NSDictionary *_Nullable)params success:(void (^ _Nonnull)(LACreateMaintenanceSettleModel *  _Nonnull result))success failure:(void (^ _Nonull)(NSError * _Nonull error))failure;

/**
 * 结算单详情
 * @param maintenanceOrderId 是  工单id
 */
+ (void)requestMaintenanceSettleDetail:(NSDictionary *_Nullable)params success:(void (^ _Nonnull)(LAMaintenanceSettleDetailModel *  _Nonnull result))success failure:(void (^ _Nonull)(NSError * _Nonull error))failure;

/**
 * 调整折扣率
 * @param maintenanceSettleId number 必须  结算单id 
 * @param ids string 必须  维修结算项目id 
 * @param countRate number 必须  折扣率 
 * @param countRateType string 必须  调整类别PROJECT-项目调整折扣率,PARTS-配件调整折扣率 
 * @param maintenanceOrderId string 必须  工单id 
 */
+ (void)requestUpdateCountRate:(NSDictionary *_Nullable)params success:(void (^ _Nonnull)(id result))success failure:(void (^ _Nonull)(NSError * _Nonull error))failure;

/**
 * 调整金额
 * @param maintenanceSettleId number 必须  结算单id 
 * @param ids string 必须  收费对象id 
 * @param adjust number 必须  调整金额 
 */
+ (void)requestUpdateAdjustAmount:(NSDictionary *_Nullable)params success:(void (^ _Nonnull)(id result))success failure:(void (^ _Nonull)(NSError * _Nonull error))failure;

/**
 * 整单拆分
 * @param id number 非必须  收费对象id（被拆分的收费对象） 
 * @param redeipts number 非必须  收费对象金额（被拆分对象的拆分前实收金额） 
 * @param addChargingObjectList object[] 非必须  新增的收费对象 item类型:object
 * @param maintenanceSettleId number 非必须  结算单id 
 */
+ (void)requestSplitChargingObject:(NSDictionary *_Nullable)params success:(void (^ _Nonnull)(id result))success failure:(void (^ _Nonull)(NSError * _Nonull error))failure;

/**
 * 变更维修结算单的优惠模式
 * @param maintenanceSettleId number 必须  结算单id 
 * @param preferentialId number 必须  优惠模式id 
 */
+ (void)requestUpdateSettlePreferential:(NSDictionary *_Nullable)params success:(void (^ _Nonnull)(id result))success failure:(void (^ _Nonull)(NSError * _Nonull error))failure;

/**
 * 删除收费对象
 * @param id number 非必须  收费对象id（被拆分的收费对象） 
 * @param maintenanceSettleId number 非必须  结算单id 
 */
+ (void)requestDeleteChargingObject:(NSDictionary *_Nullable)params success:(void (^ _Nonnull)(id result))success failure:(void (^ _Nonull)(NSError * _Nonull error))failure;

/**
 * 维修结算
 * @param maintenanceOrderId number 非必须  工单id 
 * @param maintenanceSettleId number 非必须  结算单id 
 * @param outMileage number 非必须  出差里程 
 * @param preNextRepairDate string 非必须  预计下次保养日期 
 * @param preNextRepairMiles number 非必须  预计下次保养里程 
 * @param hopedContactType string 非必须  希望联系方式 
 * @param thirdConactMobTime string 非必须  三日回访日期 
 * @param mark string 非必须  结算备注 
 * @param paymentType string 非必须  付款方式 
 */
+ (void)requestConfirmMaintenanceSettle:(NSDictionary *_Nullable)params success:(void (^ _Nonnull)(id result))success failure:(void (^ _Nonull)(NSError * _Nonull error))failure;

@end