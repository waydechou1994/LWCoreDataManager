//
//  ECGReportModel.m
//  vCare
//
//  Created by zhailiangjie on 16/7/9.
//  Copyright © 2016年 ZLJ. All rights reserved.
//

#import "ReportModel.h"

@implementation ReportModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}


- (instancetype)init{
    
    self = [super init];
    if (self) {
//        self.dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

- (NSArray *)lw_ignoredProperties {

    return @[
             @"alertLowTime",
             @"memoDic",
             @"dataArray",
             @"profileModel"
             ];
}

- (NSDictionary *)lw_substitutesForProperties {
    return @{
             @"memoDic": @"memoInfo"
             };
}

@end
