//
//  Utils.h
//  ToDoApp
//
//  Created by Mostfa Sobaih on 03/04/2024.
//

#import <Foundation/Foundation.h>
#import "TaskModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface Utils : NSObject
+ (NSArray<TaskModel *> *)filterTasksFromArray:(NSArray<TaskModel *> *)tasks withString:(NSString*)filteredKey;
+ (NSArray<TaskModel *> *)filterByPriority:(NSArray<TaskModel *> *)tasks withString:(NSString*)filteredKey;
+(void)writeArrayWithTaskObjToUserDefaults:(NSString *)keyName withArray:(NSMutableArray *)myArray;
+(NSMutableArray *)readArrayWithTaskObjFromUserDefaults:(NSString*)keyName;
+(void)removeArrayFromUserDefaults:(NSString *)keyName;
@end

NS_ASSUME_NONNULL_END
