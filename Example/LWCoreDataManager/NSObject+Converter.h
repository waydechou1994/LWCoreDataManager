//
//  NSObject+Converter.h
//  LWCoreDataManager
//
//  Created by Wayde on 09/11/2017.
//

#import <Foundation/Foundation.h>

@interface NSObject (Converter)

- (NSDictionary *)covertToDictionary;
- (SEL)propertySetterByKey:(NSString *)key;

@end
