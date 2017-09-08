//
//  LWCoreDataManager.m
//  CarePatch
//
//  Created by Wayde on 05/09/2017.
//  Copyright © 2017 Hangzhou Proton Technology Co., Ltd. All rights reserved.
//

#import "LWCoreDataManager.h"

//NSString *const _sqlName = @"vCare_Doctor_DB";

@implementation LWCoreDataManager

+ (instancetype)sharedManager {
    static LWCoreDataManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[super allocWithZone:nil] init];
    });
    return manager;
}

- (id)copy {
    return self;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self sharedManager];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "Wayde-C..text" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:_sqlName withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.sqlite", _sqlName]];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    NSDictionary *configuration = @{
                                    NSMigratePersistentStoresAutomaticallyOption : @YES,
                                    NSInferMappingModelAutomaticallyOption : @YES
                                    };
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:configuration error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    __block NSError *error;
    @try {
        [[self persistentStoreCoordinator] performBlockAndWait:^{
            if ([self.managedObjectContext hasChanges] && ![self.managedObjectContext save:&error]) {
                // Replace this implementation with code to handle the error appropriately.
                
                NSException *exception = [NSException exceptionWithName:@"DATABASE_EXCEPTION" reason:[NSString stringWithFormat:@"%@", error] userInfo:[error userInfo]];
                @throw exception;
            }
        }];
    }
    @catch (NSException *exception) {
        NSLog(@"commitDatabase exception %@",exception);
    }
    @finally {
    }
}

- (BOOL)cm_removeAllTables {
    NSURL *fileURL1 = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.sqlite", _sqlName]];
    
    NSError *error = nil;
    if (![[NSFileManager defaultManager] removeItemAtURL:fileURL1 error:&error]) {
        if ([error.userInfo[@"NSUnderlyingError"] domain] == NSPOSIXErrorDomain) {
            return YES;
        }
        
        return NO;
    };
    
    [self.persistentStoreCoordinator removePersistentStore:self.persistentStoreCoordinator.persistentStores[0] error:nil];
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.sqlite", _sqlName] isDirectory:YES];
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    NSDictionary *configuration = @{
                                    NSMigratePersistentStoresAutomaticallyOption : @YES,
                                    NSInferMappingModelAutomaticallyOption : @YES
                                    };
    
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:configuration error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    return YES;
}

@end
