//
//  NSObject+LWConverter.h
//  CarePatch
//
//  Created by Wayde on 05/09/2017.
//  Copyright © 2017 Hangzhou Proton Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (LWConverter)

- (NSDictionary *)lw_substitutesForProperties;
- (NSArray *)lw_ignoredProperties;

- (void)lw_setValue:(id)aValue forKey:(NSString *)aKey;
- (id)lw_valueForKey:(NSString *)key;

@end
