//
//  TaskModel.h
//  ToDoApp
//
//  Created by Mostfa Sobaih on 02/04/2024.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TaskModel : NSObject

@property NSString *name;
@property NSString *desc;
@property NSString *dateOfCreation;
@property NSString *priority;
@property NSString *taskState;


@end

NS_ASSUME_NONNULL_END
