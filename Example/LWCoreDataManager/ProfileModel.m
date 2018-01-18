//
//  ProfileModel.m
//  vCare
//
//  Created by wYz on 15/10/27.
//  Copyright © 2015年 wYz. All rights reserved.
//

#import "ProfileModel.h"
#import "NSObject+Converter.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation ProfileModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    
    if (self) {
        for (NSString *key in dictionary.allKeys) {
            id value = dictionary[key];
            
            SEL setter = [self propertySetterByKey:key];
            if (setter) {
                // 这里还可以使用NSInvocation或者method_invoke，不再继续深究了，有兴趣google。
                ((void (*)(id, SEL, id))objc_msgSend)(self, setter, value);
            }
        }
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        [self setValue:[NSString stringWithFormat:@"%@", value] forKey:@"iD"];
    }
    if ([key isEqualToString:@"avatar"]) {
        [self setValue:value forKey:@"avatarUrl"];
    }
}

- (void)setValue:(id)value forKey:(NSString *)key {
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"creator"]) {
        _creator = [NSString stringWithFormat:@"%@", value];
    }
}

@end
