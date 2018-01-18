//
//  LWCoreDataManager+Actions.h
//  CarePatch
//
//  Created by Wayde on 05/09/2017.
//  Copyright © 2017 Hangzhou Proton Technology Co., Ltd. All rights reserved.
//

#import "LWCoreDataManager.h"
#import "NSPredicate+CoreData.h"

@interface LWCoreDataManager (Actions)

#pragma mark - Add
/** 保存models 到 表`entityName`
 * @param models 需要保存的model数组
 * @param entityName 表的名字
 * @param format format
 * e.g. [NSPredicate predicateWithFormat:@"%@==%@", predicateKey, [model valueForKey:property]]
 * @param argKeys argumentKeys
 * @param update format
 * @param block 每updateExsitingModel保存一个model会调用，可根据需求是否使用
 */
- (void)cm_insertModels:(NSArray * _Nonnull)models
             entityName:(NSString * _Nonnull)entityName
                 format:(NSString * _Nonnull)format
           argumentKeys:(NSArray <NSString *>*_Nonnull)argKeys
    updateExsitingModel:(BOOL)update
             usingBlock:(LWCoreDataBlock _Nullable)block;

- (void)cm_insertModel:(id _Nonnull)model
            entityName:(NSString * _Nonnull)entityName
   updateExsitingModel:(BOOL)update
             predicate:(NSPredicate *_Nonnull)predicate
            usingBlock:(LWCoreDataBlock _Nullable)block;

#pragma mark - Delete

- (void)cm_deleteModelIn:(NSString *_Nonnull)entity
               predicate:(NSPredicate *_Nonnull)predicate
                   error:(NSError * _Nullable * _Nullable)error
              usingBlock:(LWCoreMnagedObjectBlock _Nullable)block;

#pragma mark - Update

- (void)cm_updateModel:(id _Nonnull)model
              inEntity:(NSString *_Nonnull)entityName
             predicate:(NSPredicate *_Nonnull)predicate
                 error:(NSError * _Nullable *_Nullable)error
            usingBlock:(LWCoreDataBlock _Nullable)block;


#pragma mark - Iterate

- (nullable NSArray *)cm_iterateIn:(NSString * _Nonnull)entityName
                          expected:(Class _Nonnull)className
                         predicate:(NSPredicate * _Nullable)predicate
                            sortBy:(NSSortDescriptor * _Nullable)sortDescriptor
                             error:(NSError * _Nullable * _Nullable)error
                        usingBlock:(void (^ _Nullable)(id _Nonnull object))block;

- (nullable NSArray *)cm_iterateFor:(NSUInteger)numberOfItems
                           inEntity:(NSString * _Nonnull)entityName
                           expected:(Class _Nonnull)className
                          predicate:(NSPredicate * _Nullable)predicate
                             sortBy:(NSSortDescriptor * _Nullable)sortDescriptor
                              error:(NSError * _Nullable * _Nullable)error
                         usingBlock:(void (^ _Nullable)(id _Nonnull object))block;

/** 遍历表`entityName`中满足predicate的所有model */
- (nullable NSArray *)cm_iterateManagedObjectsIn:(NSString * _Nonnull)entityName
                                       predicate:(NSPredicate * _Nonnull)predicate
                                          sortBy:(NSSortDescriptor * _Nullable)sortDescriptor
                                           error:(NSError * _Nullable * _Nullable)error;

@end
