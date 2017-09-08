#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "LWCoreDataConverter.h"
#import "LWCoreDataHeader.h"
#import "LWCoreDataManager+Actions.h"
#import "LWCoreDataManager.h"
#import "NSObject+LWConverter.h"
#import "NSPredicate+CoreData.h"

FOUNDATION_EXPORT double LWCoreDataManagerVersionNumber;
FOUNDATION_EXPORT const unsigned char LWCoreDataManagerVersionString[];

