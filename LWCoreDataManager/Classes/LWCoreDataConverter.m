//
//  LWCoreDataConverter.m
//  CarePatch
//
//  Created by Wayde on 05/09/2017.
//  Copyright © 2017 Hangzhou Proton Technology Co., Ltd. All rights reserved.
//

#import "LWCoreDataConverter.h"
#import "LWCoreDataHeader.h"
#import <objc/runtime.h>

@implementation LWCoreDataConverter

+ (NSDictionary *)lw_dictionaryFromObject:(id)objc {
    NSDictionary *dic = nil;
    @autoreleasepool {
        NSArray *uselessPros = @[@"debugDescription",
                                 @"description",
                                 @"superclass",
                                 @"hash"];
        
        NSMutableDictionary *mDic = [NSMutableDictionary dictionary];
        NSDictionary *sustituteKeyPairs = [objc lw_substitutesForProperties];
        NSArray *ignoredPros = [objc lw_ignoredProperties];

        unsigned count;
        objc_property_t *properties = class_copyPropertyList([objc class], &count);
        
        for (int i = 0; i < count; i++) {
            NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
            if ([ignoredPros containsObject:key]
                || [uselessPros containsObject:key]) {
                continue;
            }
            
            const char *propertyAttrs = property_getAttributes(properties[i]);
            int positionOfFisrtComma = 0;
            for (int j = 0; j < strlen(propertyAttrs); j++) {
                if (propertyAttrs[j] == ',') {
                    positionOfFisrtComma = j;
                    break;
                }
            }
            
            id value = [objc lw_valueForKey:key];
            if (value == nil) {
                continue;
            }
            
            if ([sustituteKeyPairs.allKeys containsObject:key]) {
                key = sustituteKeyPairs[key];
            }
            
            [mDic setObject:value forKey:key];
        }
        
        free(properties);
        
        dic = mDic.copy;
    }
    
    return dic;
}

+ (id)lw_objectFromDictionary:(NSDictionary *)dic withClass:(Class)className {
    id objc = [[className alloc] init];
    NSDictionary<NSString *, NSString *> *sustituteKeyPairs = nil;
    if ([objc respondsToSelector:@selector(lw_substitutesForProperties)]) {
        sustituteKeyPairs = [objc lw_substitutesForProperties];
    }
    
    NSDictionary *tempDic = dic;
    if (sustituteKeyPairs != nil) {
        NSArray *keys = dic.allKeys;
        NSMutableDictionary *mDic = dic.mutableCopy;
        [sustituteKeyPairs enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull substitute, BOOL * _Nonnull stop) {
            if ([keys containsObject:substitute]) {
                [mDic setValue:dic[substitute] forKey:key];
                [mDic removeObjectForKey:substitute];
            }
        }];
        tempDic = mDic.copy;
    }
    
    [tempDic enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull value, BOOL * _Nonnull stop) {
        [objc lw_setValue:value forKey:key];
    }];
    
    return objc;
}

@end
