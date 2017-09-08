//
//  NSPredicate+CoreData.h
//  vCare_BT
//
//  Created by Wayde on 06/09/2017.
//  Copyright © 2017 Wayde C. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSPredicate (CoreData)

+ (NSPredicate *_Nonnull)vc_predicateWithFormat:(NSString *_Nonnull)format
                                           keys:(NSArray <NSString *>*_Nonnull)keys
                                         object:(id _Nonnull )objc;

+ (NSPredicate *_Nonnull)vc_predicateWithKey:(NSString *_Nonnull)key
                                    operator:(NSString *_Nonnull)operators
                                      object:(id _Nonnull )objc
                                     objcKey:(NSString *_Nonnull)objcKey;

@end
