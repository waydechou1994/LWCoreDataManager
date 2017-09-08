//
//  NSPredicate+CoreData.m
//  vCare_BT
//
//  Created by Wayde on 06/09/2017.
//  Copyright © 2017 Wayde C. All rights reserved.
//

#import "NSPredicate+CoreData.h"

@implementation NSPredicate (CoreData)

+ (NSPredicate *)vc_predicateWithFormat:(NSString *)format
                                   keys:(NSArray<NSString *> *)keys
                                 object:(id)objc {
    
    NSMutableArray *args = [NSMutableArray array];
    [keys enumerateObjectsUsingBlock:^(NSString * _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
        id value = [objc valueForKey:key];
        if (!value) {
            value = [NSNull null];
        }
        [args addObject:value];
    }];
    
    return [NSPredicate predicateWithFormat:format argumentArray:args.copy];
}

+ (NSPredicate *)vc_predicateWithKey:(NSString *)key operator:(NSString * _Nonnull)operators object:(id _Nonnull)objc objcKey:(NSString * _Nonnull)objcKey {
    NSString *format = [NSString stringWithFormat:@"%@%@%@", key, operators, [objc valueForKey:objcKey]];
    
    return [NSPredicate predicateWithFormat:format];
}

@end
