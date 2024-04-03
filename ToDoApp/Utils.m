//
//  Utils.m
//  ToDoApp
//
//  Created by Mostfa Sobaih on 03/04/2024.
//

#import "Utils.h"
#import "TaskModel.h"

@implementation Utils

+ (NSArray<TaskModel *> *)filterTasksFromArray:(NSArray<TaskModel *> *)tasks withString:(NSString*)filteredKey{
    NSMutableArray<TaskModel *> *filteredArray = [NSMutableArray array];
    NSArray<TaskModel *> *loadedTasks = tasks;
    for (TaskModel *task in loadedTasks) {
        NSString *statesString = task.taskState;
        if ([statesString isEqualToString:filteredKey]) {
            [filteredArray addObject:task];
        }
    }
    
    return filteredArray;
}

+ (NSArray<TaskModel *> *)filterByPriority:(NSArray<TaskModel *> *)tasks withString:(NSString*)filteredKey{
    NSMutableArray<TaskModel *> *filteredArray = [NSMutableArray array];
    NSArray<TaskModel *> *loadedTasks = tasks;
    for (TaskModel *task in loadedTasks) {
        NSString *priorityString = task.priority;
        if ([priorityString isEqualToString:filteredKey]) {
            [filteredArray addObject:task];
        }
    }
    
    return filteredArray;
}
+(void)writeArrayWithTaskObjToUserDefaults:(NSString *)keyName withArray:(NSMutableArray *)myArray{

    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:myArray];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:keyName];
}


+(NSMutableArray *)readArrayWithTaskObjFromUserDefaults:(NSString*)keyName{
    NSMutableArray *myArray;
    NSData *data =  [[NSUserDefaults standardUserDefaults] objectForKey:keyName];
    myArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (myArray == nil) {
        myArray = [NSMutableArray new];
    }
    return myArray;
}
+(void)removeArrayFromUserDefaults:(NSString *)keyName{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:keyName];
}
@end
