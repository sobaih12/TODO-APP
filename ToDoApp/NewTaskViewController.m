//
//  NewTaskViewController.m
//  ToDoApp
//
//  Created by Mostfa Sobaih on 02/04/2024.
//

#import "NewTaskViewController.h"
#import "TaskModel.h"
#import "Utils.h"

@interface NewTaskViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *descTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *perioritySegmentedControl;
@property BOOL isEditable;
@property (weak, nonatomic) IBOutlet UIButton *editButton;

@end

@implementation NewTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}


- (IBAction)addingNewTask:(id)sender {
    NSMutableArray<TaskModel *> *taskArray = [[NSMutableArray alloc] initWithArray:[Utils readArrayWithTaskObjFromUserDefaults:@"taskArray"] ?: @[]];
    TaskModel *newTaskModel = [[TaskModel alloc] init];
    newTaskModel.name = _titleTextField.text;
    newTaskModel.desc = _descTextField.text;
    newTaskModel.taskState = @"0";
//    [@(_perioritySegmentedControl.selectedSegmentIndex) stringValue];
    newTaskModel.priority = [NSString stringWithFormat:@"%ld", (long)_perioritySegmentedControl.selectedSegmentIndex];
    [taskArray addObject:newTaskModel];
    [Utils writeArrayWithTaskObjToUserDefaults:@"taskArray" withArray:taskArray];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
