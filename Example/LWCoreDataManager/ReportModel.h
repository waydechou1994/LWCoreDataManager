//
//  ECGReportModel.h
//  vCare
//
//  Created by zhailiangjie on 16/7/9.
//  Copyright © 2016年 ZLJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProfileModel.h"

@interface ReportModel : NSObject
/*
 creator = 255;
 data =         {
 "conception_rate" = 35;
 "heart_rate_avg" = "37.5";
 "temp_bbt" = 0;
 "temp_max" = "28.54";
 time = 833;
 };
 deviceid = 2185;
 devicetype = "<null>";
 doctorAvatar = "<null>";
 doctorName = "<null>";
 doctorTitle = "<null>";
 endtime = 1506235749000;
 filepath = "http://rawtemp.oss-cn-hangzhou.aliyuncs.com/release/ios/2017/09/24/15062349160.json";
 healthtip = "Treatments vary depending on the cause of the fever. For example, antibiotics would be used for a bacterial infection such as strep throat.";
 healthtipid = 4;
 id = 55621;
 paystatus = 0;
 profileavatar = "http://buyue.oss-cn-hangzhou.aliyuncs.com/2017/09/vu15046652361875.jpg";
 profileid = 822;
 profilename = Fuck;
 protonAdvice = "<null>";
 protonType = 0;
 starttime = 1506234915000;
 timestr = "<null>";
 type = 1;
 vcareadvice = "";
 vcareresult = "";*/
@property (nonatomic, strong) NSString *reportID; ///< 报告ID

@property (nonatomic, strong) NSString *profileID; ///< 档案ID
@property (nonatomic, strong) NSString *equipmentID; ///< 设备ID

@property (nonatomic, strong) NSString *startDate; ///< 开始时间 // 2016-07-13
@property (nonatomic, strong) NSString *endDate; ///< 结束时间
@property (nonatomic, strong) NSString *topValue; ///< 最高温度
@property (nonatomic, strong) NSString *lowValue; ///< 最低心率
@property (nonatomic, strong) NSString *measureTime; ///< 测量时间
@property (nonatomic, strong) NSString *localDataUrl; ///< 本地数据路径
@property (nonatomic, strong) NSString *netDataUrl; ///< 阿里云数据路径
@property (nonatomic, strong) NSString *alertTime; ///< 超过报警的时间（主要是温度）
@property (nonatomic, strong) NSString *alertLowTime; ///< 超过报警的时间（主要是温度）
@property (nonatomic, strong) NSString *alertTemp; ///< 预警温度
@property (nonatomic, strong) NSString *alertLowTemp; ///< 预警温度
@property (nonatomic, strong) NSMutableDictionary *memoDic;
@property (nonatomic, strong) NSMutableArray *dataArray; ///< 存放数据的数组

@property (nonatomic, assign) NSInteger reportType; ///< 1是温度，2是心电
@property (nonatomic, strong) ProfileModel  *profileModel; /// <获取对应的档案信息
@property (nonatomic, assign, readwrite) NSInteger collect;

@property (nonatomic, strong, readwrite) NSString *firmwareVersion;
@property (nonatomic, strong, readwrite) NSString *bluetoothAddress;
@property (nonatomic, strong, readwrite) NSString *serialNumber;
@property (nonatomic, strong, readwrite) NSString *peripheralName;
@property (nonatomic, assign, readwrite) BOOL dataCompleted;
@property (nonatomic, assign, readwrite) BOOL uploaded;

@end
