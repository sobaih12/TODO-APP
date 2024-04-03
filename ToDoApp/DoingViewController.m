//
//  DoingViewController.m
//  ToDoApp
//
//  Created by Mostfa Sobaih on 02/04/2024.
//

#import "DoingViewController.h"
#import "TaskModel.h"
#import "Utils.h"
#import "DetailsViewController.h"

@interface DoingViewController (){
    NSMutableArray *allDoingTasksArray;
    TaskModel *taskModel;
    TaskModel *selectedTask;
    NSArray<TaskModel *> *loadedTasks;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@end

@implementation DoingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)segmentedClick:(id)sender {
    NSInteger selectedIndex = _segmentedControl.selectedSegmentIndex;
    switch (selectedIndex) {
        case 0:{
            NSArray<TaskModel *> *filteredTasks = [Utils filterTasksFromArray:loadedTasks withString:@"1"];
            allDoingTasksArray = [filteredTasks mutableCopy];
            [self.tableView reloadData];
        }
            break;
        case 1:{
            NSArray<TaskModel *> *filteredTasks = [Utils filterTasksFromArray:loadedTasks withString:@"1"];
            NSArray<TaskModel *> *lowPriority = [Utils filterByPriority:filteredTasks withString:@"0"];
            allDoingTasksArray = [lowPriority mutableCopy];
            [self.tableView reloadData];
        }
            break;
        case 2:{
            NSArray<TaskModel *> *filteredTasks = [Utils filterTasksFromArray:loadedTasks withString:@"1"];
            NSArray<TaskModel *> *medPriority = [Utils filterByPriority:filteredTasks withString:@"1"];
            allDoingTasksArray = [medPriority mutableCopy];
            [self.tableView reloadData];
        }
            break;
        case 3:{
            NSArray<TaskModel *> *filteredTasks = [Utils filterTasksFromArray:loadedTasks withString:@"1"];
            NSArray<TaskModel *> *highPriority = [Utils filterByPriority:filteredTasks withString:@"2"];
            allDoingTasksArray = [highPriority mutableCopy];
            [self.tableView reloadData];
        }
            break;
        
        default:
            break;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    loadedTasks = [Utils readArrayWithTaskObjFromUserDefaults:@"taskArray"];
    NSArray<TaskModel *> *filteredTasks = [Utils filterTasksFromArray:loadedTasks withString:@"1"];

    allDoingTasksArray = [filteredTasks mutableCopy];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"doingCell" forIndexPath:indexPath];
    taskModel = [allDoingTasksArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [taskModel name];
    UIImage *priorityImage = nil;
    if ([[taskModel priority]  isEqual:@"0"]) {
        priorityImage = [UIImage imageNamed:@"low"];
    } else if ([[taskModel priority]  isEqual:@"1"]) {
        priorityImage = [UIImage imageNamed:@"medium"];
    } else if ([[taskModel priority]  isEqual:@"2"]) {
        priorityImage = [UIImage imageNamed:@"high"];
    }
    
    CGFloat imageSize = 50.0;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imageSize, imageSize)];
    imageView.image = priorityImage;
    cell.accessoryView = imageView;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = 0;
    count = [allDoingTasksArray count];
    return count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    selectedTask = [allDoingTasksArray objectAtIndex:indexPath.row];
    
    DetailsViewController *details = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsViewController"];
    [details setDetailsTaskModel:selectedTask];
    NSMutableArray<TaskModel *> *mutableLoadedTasks = [loadedTasks mutableCopy];
    [details setDetailsArray:mutableLoadedTasks];
    [self.navigationController pushViewController:details animated:YES];
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *title = @"Doing List";
    return title;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Delete" message:@"Are You Sure Want to Delete ?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* yesButton = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            TaskModel *removedTask = [TaskModel new];
            removedTask = [self->allDoingTasksArray objectAtIndex:indexPath.row];
            NSMutableArray<TaskModel *> *originalList = [self->loadedTasks mutableCopy];
            [self->allDoingTasksArray removeObject:removedTask];
            [originalList removeObject:removedTask];
            [Utils removeArrayFromUserDefaults:@"taskArray"];
            [Utils writeArrayWithTaskObjToUserDefaults:@"taskArray" withArray:originalList];
            [tableView reloadData];
        }];
        UIAlertAction* noButton = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:yesButton];
        [alert addAction:noButton];
        [self presentViewController: alert animated:YES completion:nil];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

@end
