//
//  LWViewController.m
//  LWCoreDataManager
//
//  Created by waydechou1994 on 09/08/2017.
//  Copyright (c) 2017 waydechou1994. All rights reserved.
//

#import "LWViewController.h"
#import "ReportModel.h"
#import "ProfileModel.h"
#import "NSObject+Converter.h"

@interface LWViewController ()

@end

@implementation LWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ReportModel *report = [[ReportModel alloc] init];
    report.reportID = @"200";
    report.peripheralName = @"dfadf";
    
    NSDictionary *dic = [report covertToDictionary];
    NSLog(@"_ dic %@", dic);
    
    NSDictionary *profileDic = @{
                          @"id": @"20",
                          @"creator": @"creator",
                          @"title": @"title",
                          @"realname": @"realname"
                          };
    ProfileModel *profile = [[ProfileModel alloc] initWithDictionary:profileDic];
    NSLog(@"_ profile %@", profile);

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
