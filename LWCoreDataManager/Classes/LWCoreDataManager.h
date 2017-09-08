//
//  LWCoreDataManager.h
//  CarePatch
//
//  Created by Wayde on 05/09/2017.
//  Copyright © 2017 Hangzhou Proton Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

typedef void(^LWCoreDataBlock)(id _Nonnull object, NSManagedObject * _Nullable managedObject, BOOL exsits);
typedef void(^LWCoreMnagedObjectBlock)(NSManagedObject * _Nonnull managedObject);

@interface LWCoreDataManager : NSObject

@property (nonatomic, copy, readwrite) NSString * _Nonnull sqlName;
@property (readonly, strong, nonatomic) NSManagedObjectContext * _Nonnull managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel * _Nonnull managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator * _Nonnull persistentStoreCoordinator;

- (void)saveContext;
- (NSURL * _Nonnull)applicationDocumentsDirectory;

+ (instancetype _Nonnull)sharedManager;

/** 删除所有的数据表 */
- (BOOL)cm_removeAllTables;

@end

//extern NSString * _Nonnull const LWSqliteName;
