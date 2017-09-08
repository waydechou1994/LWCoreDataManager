//
//  NSObject+LWConverter.m
//  CarePatch
//
//  Created by Wayde on 05/09/2017.
//  Copyright © 2017 Hangzhou Proton Technology Co., Ltd. All rights reserved.
//

#import "NSObject+LWConverter.h"

@implementation NSObject (LWConverter)

- (NSArray *)lw_ignoredProperties {
    return nil;
}

- (NSDictionary *)lw_substitutesForProperties {
    return nil;
}

- (void)lw_setValue:(id)aValue forKey:(NSString *)aKey {
    [self setValue:aValue forKey:aKey];
}

- (id)lw_valueForKey:(NSString *)key {
    return [self valueForKey:key];
}

@end
