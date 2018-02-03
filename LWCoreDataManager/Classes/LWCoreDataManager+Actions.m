//
//  LWCoreDataManager+Actions.m
//  CarePatch
//
//  Created by Wayde on 05/09/2017.
//  Copyright © 2017 Hangzhou Proton Technology Co., Ltd. All rights reserved.
//

#import "LWCoreDataManager+Actions.h"
#import "LWCoreDataConverter.h"

@implementation LWCoreDataManager (Actions)

#pragma mark - ADD

- (void)cm_insertModels:(NSArray *)models
             entityName:(NSString *)entityName
                 format:(NSString *)format
           argumentKeys:(NSArray<NSString *> *)argKeys
    updateExsitingModel:(BOOL)update
             usingBlock:(LWCoreDataBlock _Nullable)block {
    for (id model in models) {
        NSPredicate* predicate = [NSPredicate vc_predicateWithFormat:format
                                                                keys:argKeys
                                                              object:model];
        [self cm_insertModel:model
                  entityName:entityName
         updateExsitingModel:update
                   predicate:predicate
                  usingBlock:block];
    }
}

- (void)cm_insertModel:(id)model
            entityName:(NSString * _Nonnull)entityName
   updateExsitingModel:(BOOL)update
             predicate:(NSPredicate * _Nonnull)predicate
            usingBlock:(LWCoreDataBlock _Nullable)block {
    
    BOOL exists = [self cm_itemExists:predicate inEntity:entityName];
    if (!exists) {
        id managedObject = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:self.managedObjectContext];
        
        NSDictionary *dic = [LWCoreDataConverter lw_dictionaryFromObject:model];
        [managedObject setValuesForKeysWithDictionary:dic];
        
        if (block) {
            block(model, managedObject, NO);
        }
        
        [self saveContext];
        
    } else if (update) {
        
        [self cm_updateModel:model
                    inEntity:entityName
                   predicate:predicate
                       error:nil
                  usingBlock:block];
    }
}

#pragma mark - Update

- (void)cm_updateModel:(id _Nonnull)model
              inEntity:(NSString *)entityName
             predicate:(NSPredicate *)predicate
                 error:(NSError *__autoreleasing  _Nullable *)error
            usingBlock:(LWCoreDataBlock _Nullable)block {
    @autoreleasepool {
        NSArray *fetchResult = [self cm_iterateManagedObjectsIn:entityName
                                                      predicate:predicate
                                                         sortBy:nil
                                                          error:error];
        
        if ((error && *error) || !fetchResult.count) return;
        
        id managedObject = fetchResult.firstObject;
        if (managedObject) {
            NSDictionary *dic = [LWCoreDataConverter lw_dictionaryFromObject:model];
            [managedObject setValuesForKeysWithDictionary:dic];
            
            if (block) {
                block(model, managedObject, YES);
            }
            
            [self saveContext];
        } else {
            if (block) {
                block(model, nil, NO);
            }
        }
    }
}

#pragma mark - Delete

- (void)cm_deleteModelIn:(NSString *)entity
               predicate:(NSPredicate *)predicate
                   error:(NSError *__autoreleasing  _Nullable *)error
              usingBlock:(LWCoreMnagedObjectBlock _Nullable)block {
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:entity
                                        inManagedObjectContext:self.managedObjectContext]];
    [fetchRequest setPredicate:predicate];
    
    NSArray* results = [self.managedObjectContext executeFetchRequest:fetchRequest error:error];
    
    for (NSManagedObject *deletedObject in results) {
        [self.managedObjectContext deleteObject:deletedObject];
        [self saveContext];
        
        if (block) {
            block(deletedObject);
        }
    }
}

#pragma mark - Iterate

- (NSArray *)cm_iterateManagedObjectsIn:(NSString *)entityName
                              predicate:(NSPredicate *)predicate
                                 sortBy:(NSSortDescriptor *)sortDescriptor
                                  error:(NSError * _Nullable *)error {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    
    if (predicate) {
        [request setPredicate:predicate];
    }
    
    if (sortDescriptor) {
        [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    }
    
    return [self.managedObjectContext executeFetchRequest:request error:error];
}

- (NSArray *)cm_iterateIn:(NSString *)entityName
                 expected:(Class)className
                predicate:(NSPredicate *)predicate
                   sortBy:(NSSortDescriptor *)sortDescriptor
                    error:(NSError *__autoreleasing  _Nullable *)error
               usingBlock:(void (^ _Nullable)(id _Nonnull))block {
    return [self cm_iterateFor:0
                      inEntity:entityName
                      expected:className
                     predicate:predicate
                        sortBy:sortDescriptor
                         error:error
                    usingBlock:block];
}

- (NSArray *)cm_iterateFor:(NSUInteger)numberOfItems
                  inEntity:(NSString *)entityName
                  expected:(Class)className
                 predicate:(NSPredicate *)predicate
                    sortBy:(NSSortDescriptor *)sortDescriptor
                     error:(NSError *__autoreleasing  _Nullable *)error
                usingBlock:(void (^)(id _Nonnull))block {
    return [self cm_iterateFor:numberOfItems
                   fetchOffset:0
                      inEntity:entityName
                      expected:className
                     predicate:predicate
                        sortBy:sortDescriptor
                         error:error
                    usingBlock:block];
}

- (NSArray *)cm_iterateFor:(NSUInteger)numberOfItems
               fetchOffset:(NSUInteger)offset
                  inEntity:(NSString *)entityName
                  expected:(Class)className
                 predicate:(NSPredicate *)predicate
                    sortBy:(NSSortDescriptor *)sortDescriptor
                     error:(NSError *__autoreleasing  _Nullable *)error
                usingBlock:(void (^)(id _Nonnull))block {
    
    NSMutableArray *reportArray = nil;
    
    @autoreleasepool {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
        
        if (predicate) {
            [request setPredicate:predicate];
        }
        
        if (sortDescriptor) {
            [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
        }
        
        if (numberOfItems > 0) {
            [request setFetchLimit:numberOfItems];
        }
        
        if (offset > 0) {
            [request setFetchOffset:offset];
        }
        
        NSError *error = nil;
        NSArray *result = [[self.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
        
        if (error) {
            return nil;
        }
        
        if (result.count == 0) {
            return nil;
        }
        
        reportArray = @[].mutableCopy;
        for (id managedObject in result) {
            NSDictionary *dic = [LWCoreDataConverter lw_dictionaryFromObject:managedObject];
            id expectedObject = [LWCoreDataConverter lw_objectFromDictionary:dic
                                                                   withClass:className];
            if (block) {
                block(expectedObject);
            }
            
            [reportArray addObject:expectedObject];
        }
    }
    
    return reportArray.copy;
}

#pragma mark - Others

- (BOOL)cm_itemExists:(NSPredicate *)predicate inEntity:(NSString *)entityName {
    NSError* error = nil;
    return [self cm_iterateManagedObjectsIn:entityName
                                  predicate:predicate
                                     sortBy:nil
                                      error:&error].count > 0;
}

@end
