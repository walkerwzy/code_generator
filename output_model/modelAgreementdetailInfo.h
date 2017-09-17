//
//  modelAgreementdetailInfo.h
//  Homedoctor
// 
//  Created by walker on 2017-9-18.
//  Copyright © 2017 WeDoctor Group  All rights reserved.
// 

#import <PMRESTLib/PMRESTLib.h>
#import modelAgreementServicePksInfo.h
#import modelAgreementTagInfo.h
#import modelAgreementAttatch.h


@interface modelAgreementdetailInfo : PMLModelBase

/**
 * 签约UUID
 */
@property (nonatomic, copy) NSString *agreementUuid;

/**
 * 签约申请UUID
 */
@property (nonatomic, copy) NSString *agreementApplyUuid;

/**
 * 医生Id
 */
@property (nonatomic, copy) NSString *expertId;

/**
 * 医生用户Id
 */
@property (nonatomic, assign) NSInteger expertUserId;

/**
 * 医生姓名
 */
@property (nonatomic, copy) NSString *expertName;

/**
 * 社区医院ID
 */
@property (nonatomic, copy) NSString *hospitalId;

/**
 * 社区医院名称
 */
@property (nonatomic, copy) NSString *hospitalName;

/**
 * 社区医院省id
 */
@property (nonatomic, assign) NSInteger provinceId;

/**
 * 社区医院省名称
 */
@property (nonatomic, copy) NSString *provinceName;

/**
 * 社区医院市id
 */
@property (nonatomic, assign) NSInteger cityId;

/**
 * 社区医院市名称
 */
@property (nonatomic, copy) NSString *cityName;

/**
 * 社区医院区县id
 */
@property (nonatomic, assign) NSInteger districtId;

/**
 * 患者所属用户id
 */
@property (nonatomic, assign) NSInteger patientUserId;

/**
 * 患者所在市名称
 */
@property (nonatomic, assign) NSInteger patientId;

/**
 * 姓名
 */
@property (nonatomic, copy) NSString *patientName;

/**
 * 身份证号
 */
@property (nonatomic, copy) NSString *patientIdCard;

/**
 * 出生日期 由身份证解析
 */
@property (nonatomic, assign) NSInteger patientAge;

/**
 * 性别 1-男 2-女
 */
@property (nonatomic, assign) NSInteger patientSex;

/**
 * 手机号码
 */
@property (nonatomic, copy) NSString *patientMobile;

/**
 * 患者头像照片地址
 */
@property (nonatomic, copy) NSString *patientImg;

/**
 * 图片服务地址
 */
@property (nonatomic, copy) NSString *kanoServer;

/**
 * 患者医保类型1-省医保2-市医保3-新农合医保4-健康卡5-大学生医保6-少儿医保7-其他医保
 */
@property (nonatomic, assign) NSInteger patientCardType;

/**
 * 患者医保卡号
 */
@property (nonatomic, copy) NSString *patientCardNo;

/**
 * 患者所在省份Id
 */
@property (nonatomic, assign) NSInteger patientProvinceId;

/**
 * 患者所在省份名称
 */
@property (nonatomic, copy) NSString *patientProvinceName;

/**
 * 患者所在市Id
 */
@property (nonatomic, assign) NSInteger patientCityId;

/**
 * 患者所在市名称
 */
@property (nonatomic, copy) NSString *patientCityName;

/**
 * 患者所在区县Id
 */
@property (nonatomic, assign) NSInteger patientDistrictId;

/**
 * 患者所在区县名称
 */
@property (nonatomic, copy) NSString *patientDistrictName;

/**
 * 患者常住地址
 */
@property (nonatomic, copy) NSString *patientAddress;

/**
 * 电子签名
 */
@property (nonatomic, copy) NSString *patientSignature;

/**
 * 服务年限
 */
@property (nonatomic, copy) NSString *serviceYear;

/**
 * 下次签约提前提醒日期
 */
@property (nonatomic, assign) NSInteger nextSignNoticeDays;

/**
 * 订单状态 1-正常生效，2-未来生效，3-已失效，4-已解签
 */
@property (nonatomic, assign) NSInteger status;

/**
 * 婚姻状况标签ID
 */
@property (nonatomic, copy) NSString *maritalStatusTag;

/**
 * 生育状况标签ID
 */
@property (nonatomic, copy) NSString *fertilityStatusTag;

/**
 * 手术或外伤标签ID，多值以逗号分隔
 */
@property (nonatomic, copy) NSString *surgeryStatusTags;

/**
 * 手术或外伤补充
 */
@property (nonatomic, copy) NSString *surgeryStatusAdd;

/**
 * 家族病史标签ID，多值以逗号分隔
 */
@property (nonatomic, copy) NSString *familyDiseaseHisTags;

/**
 * 家族病史补充
 */
@property (nonatomic, copy) NSString *familyDiseaseHisAdd;

/**
 * 药物过敏历史标签ID，多值以逗号分隔
 */
@property (nonatomic, copy) NSString *drugAllergyHisTags;

/**
 * 药物过敏历史补充
 */
@property (nonatomic, copy) NSString *drugAllergyHisAdd;

/**
 * 食物或接触物过敏历史标签ID，多值以逗号分隔
 */
@property (nonatomic, copy) NSString *foodAllergyHisTags;

/**
 * 食物或接触物过敏历史补充
 */
@property (nonatomic, copy) NSString *foodAllergyHisAdd;

/**
 * 个人习惯标签ID，多值以逗号分隔
 */
@property (nonatomic, copy) NSString *personalHabitTags;

/**
 * 个人习惯补充
 */
@property (nonatomic, copy) NSString *personalHabitAdd;

/**
 * 签约时间
 */
@property (nonatomic, copy) NSString *signTime;

/**
 * 来源
 */
@property (nonatomic, copy) NSString *sourceId;

/**
 * 套餐信息
 */
@property (nonatomic, strong) NSArray<modelAgreementServicePksInfo *> *agreementServicePkgs;

/**
 * 居民标签信息
 */
@property (nonatomic, strong) NSArray<modelAgreementTagInfo *> *agreementTags;

/**
 * 证件资料
 */
@property (nonatomic, strong) NSArray<modelAgreementAttatch *> *agreementAttachs;


@end