//
//  ProfileModel.h
//  vCare
//
//  Created by wYz on 15/10/27.
//  Copyright © 2015年 wYz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProfileModel : NSObject

//档案详情的模型
@property (nonatomic, strong) NSString *iD; ///< 档案的id
@property (nonatomic, strong) NSString *creator; ///< 创建者ID（需确认是不是账户ID）
@property (nonatomic, strong) NSString *title; ///< 档案名
@property (nonatomic, strong) NSString *realname;
@property (nonatomic, strong) NSString *avatar; ///< 头像
@property (nonatomic, strong) NSNumber *gender; ///< 性别 1男 2女
@property (nonatomic, strong) NSString *birthday; ///< 出生年月，这个版本作为年龄来存储
@property (nonatomic, strong, readwrite) NSString *code;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
