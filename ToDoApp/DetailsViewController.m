//
//  DetailsViewController.m
//  ToDoApp
//
//  Created by Mostfa Sobaih on 02/04/2024.
//

#import "DetailsViewController.h"
#import "Utils.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextField *descField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedController;
@property BOOL isEditable;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *statusSegmented;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _isEditable = NO;
    [self updateEditingState];
    if ([_detailsTaskModel.taskState isEqual:@"2"]) {
        _segmentedController.enabled = NO;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _titleField.text = _detailsTaskModel.name;
    _descField.text = _detailsTaskModel.desc;
    _segmentedController.selectedSegmentIndex = [_detailsTaskModel.priority intValue];
    _statusSegmented.selectedSegmentIndex = [_detailsTaskModel.taskState intValue];
    printf("details Array %lu",(unsigned long)_detailsArray.count);
}
- (IBAction)editButton:(id)sender {
    if (_isEditable == NO) {
        _isEditable =YES;
        [self updateEditingState];
        [_editButton setTitle:@"Save" forState:UIControlStateNormal];
    }else{
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Edit" message:@"Are You Sure Want to Edit ?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* yesButton = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self->_isEditable = NO;
            self->_detailsTaskModel.name = self->_titleField.text;
            self->_detailsTaskModel.desc = self->_descField.text;
            self->_detailsTaskModel.priority = [NSString stringWithFormat:@"%ld", (long)self->_segmentedController.selectedSegmentIndex];
            self->_detailsTaskModel.taskState =[NSString stringWithFormat:@"%ld", (long)self->_statusSegmented.selectedSegmentIndex];
            [Utils writeArrayWithTaskObjToUserDefaults:@"taskArray" withArray:self->_detailsArray];
            [self.navigationController popViewControllerAnimated:true];
            
        }];
        UIAlertAction* noButton = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:yesButton];
        [alert addAction:noButton];
        [self presentViewController: alert animated:YES completion:nil];
        
    }
    
}
- (void)updateEditingState {
    self.titleField.enabled = self.isEditable;
    self.descField.enabled = self.isEditable;
    self.segmentedController.enabled = self.isEditable;
    
    if ([_detailsTaskModel.taskState isEqual:@"2"]) {
        _statusSegmented.enabled = NO;
    }else{
        self.statusSegmented.enabled = self.isEditable;
    }
}

@end
