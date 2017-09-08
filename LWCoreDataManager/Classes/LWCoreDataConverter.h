//
//  LWCoreDataConverter.h
//  CarePatch
//
//  Created by Wayde on 05/09/2017.
//  Copyright © 2017 Hangzhou Proton Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LWCoreDataConverter : NSObject

+ (NSDictionary *)lw_dictionaryFromObject:(id)objc;

+ (id)lw_objectFromDictionary:(NSDictionary *)dic withClass:(Class)className;

@end
