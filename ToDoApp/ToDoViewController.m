//
//  ToDoViewController.m
//  ToDoApp
//
//  Created by Mostfa Sobaih on 02/04/2024.
//

#import "ToDoViewController.h"
#import "NewTaskViewController.h"
#import "TaskModel.h"
#import "DetailsViewController.h"
#import "Utils.h"

@interface ToDoViewController (){
    NSMutableArray *allTasksArray;
    TaskModel *taskModel;
    TaskModel *selectedTask;
    NSArray<TaskModel *> *loadedTasks;
    NSArray<TaskModel *> *filteredTasks;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedController;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) NSMutableArray<TaskModel *> *filteredDataArray;

@end

@implementation ToDoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _searchBar.delegate = self;
    // Do any additional setup after loading the view.
}
- (IBAction)segmentedAction:(id)sender {
        NSInteger selectedIndex = _segmentedController.selectedSegmentIndex;
        switch (selectedIndex) {
            case 0:{
                filteredTasks = [Utils filterTasksFromArray:loadedTasks withString:@"0"];
                allTasksArray = [filteredTasks mutableCopy];
                [self.tableView reloadData];
            }
                break;
            case 1:{
                filteredTasks = [Utils filterTasksFromArray:loadedTasks withString:@"0"];
                NSArray<TaskModel *> *lowPriority = [Utils filterByPriority:filteredTasks withString:@"0"];
                allTasksArray = [lowPriority mutableCopy];
                [self.tableView reloadData];
            }
                break;
            case 2:{
                filteredTasks = [Utils filterTasksFromArray:loadedTasks withString:@"0"];
                NSArray<TaskModel *> *medPriority = [Utils filterByPriority:filteredTasks withString:@"1"];
                allTasksArray = [medPriority mutableCopy];
                [self.tableView reloadData];
            }
                break;
            case 3:{
                filteredTasks = [Utils filterTasksFromArray:loadedTasks withString:@"0"];
                NSArray<TaskModel *> *highPriority = [Utils filterByPriority:filteredTasks withString:@"2"];
                allTasksArray = [highPriority mutableCopy];
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
    filteredTasks = [Utils filterTasksFromArray:loadedTasks withString:@"0"];
    
    allTasksArray = [filteredTasks mutableCopy];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath { 
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"todoCell" forIndexPath:indexPath];
    taskModel = [allTasksArray objectAtIndex:indexPath.row];
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
    count = [allTasksArray count];
    return count;
}
- (IBAction)addNewTask:(id)sender {
    NewTaskViewController *addingVC = [self.storyboard instantiateViewControllerWithIdentifier:@"NewTaskViewController"];
    
    [self.navigationController pushViewController:addingVC animated:YES];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    selectedTask = [allTasksArray objectAtIndex:indexPath.row];
    DetailsViewController *details = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsViewController"];
    [details setDetailsTaskModel:selectedTask];
    NSMutableArray<TaskModel *> *mutableLoadedTasks = [loadedTasks mutableCopy];
    [details setDetailsArray:mutableLoadedTasks];
    [self.navigationController pushViewController:details animated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *title = @"TODO List";
    return title;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Delete" message:@"Are You Sure Want to Delete ?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* yesButton = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            TaskModel *removedTask = [TaskModel new];
            removedTask = [self->allTasksArray objectAtIndex:indexPath.row];
            NSMutableArray<TaskModel *> *originalList = [self->loadedTasks mutableCopy];
            [self->allTasksArray removeObject:removedTask];
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


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length == 0) {
        
        allTasksArray = [filteredTasks mutableCopy];
    } else {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@", searchText];
        allTasksArray = [allTasksArray filteredArrayUsingPredicate:predicate];
    }
    [self.tableView reloadData];
}


@end
