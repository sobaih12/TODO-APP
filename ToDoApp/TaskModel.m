//
//  TaskModel.m
//  ToDoApp
//
//  Created by Mostfa Sobaih on 02/04/2024.
//

#import "TaskModel.h"

@implementation TaskModel

- (void)encodeWithCoder:(NSCoder *)coder{
    [coder encodeObject:_name forKey:@"name"];
    [coder encodeObject:_desc forKey:@"desc"];
    [coder encodeObject:_dateOfCreation forKey:@"dateOfCreation"];
    [coder encodeObject:_priority forKey:@"priority"];
    [coder encodeObject:_taskState forKey:@"taskState"];
}

- (id)initWithCoder:(NSCoder *)coder{
    self = [super init];
    if (self != nil){
        _name  = [coder decodeObjectForKey:@"name"];
        _desc = [coder decodeObjectForKey:@"desc"];
        _dateOfCreation = [coder decodeObjectForKey:@"dateOfCreation"];
        _priority = [coder decodeObjectForKey:@"priority"];
        _taskState = [coder decodeObjectForKey:@"taskState"];
    
    }
    return self;
}

@end
