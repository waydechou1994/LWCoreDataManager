//
//  NSObject+Converter.m
//  LWCoreDataManager
//
//  Created by Wayde on 09/11/2017.
//

#import "NSObject+Converter.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation NSObject (Converter)


- (NSDictionary *)covertToDictionary {
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    if (count != 0) {
        NSMutableDictionary *resultDict = [NSMutableDictionary dictionary];
        
        for (NSUInteger i = 0; i < count; i ++) {
            const void *propertyName = property_getName(properties[i]);
            NSString *name = [NSString stringWithUTF8String:propertyName];
            
            SEL getter = [self propertyGetterByKey:name];
            if (getter) {
                id value = ((id (*)(id, SEL))objc_msgSend)(self, getter);
                if (value) {
                    resultDict[name] = value;
                } else {
                    NSLog(@"%@的value为nil哦！", name);
                }
            }
        }
        free(properties);
        
        return resultDict;
    }
    
    free(properties);
    
    return nil;
}
#pragma mark - private methods

// 生成setter方法
- (SEL)propertySetterByKey:(NSString *)key {
    // 首字母大写，你懂得
    key = [key stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[key substringToIndex:1].capitalizedString];
    NSString *propertySetterName = [NSString stringWithFormat:@"set%@:", key];
    SEL setter = NSSelectorFromString(propertySetterName);
    if ([self respondsToSelector:setter]) {
        return setter;
    }
    return nil;
}

// 生成getter方法
- (SEL)propertyGetterByKey:(NSString *)key {
    SEL getter = NSSelectorFromString(key);
    if ([self respondsToSelector:getter]) {
        return getter;
    }
    return nil;
}

@end
