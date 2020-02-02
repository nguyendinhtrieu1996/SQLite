//
//  EditInfoViewController.m
//  Contact_SQLite
//
//  Created by LAP12852 on 2/2/20.
//  Copyright © 2020 LAP12852. All rights reserved.
//

#import "EditInfoViewController.h"

#import "CommonMacros.h"

#import "DBManager.h"


@interface EditInfoViewController ()

@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;

@end // @interface EditInfoViewController ()


@implementation EditInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)touchInSaveButton:(id)sender {
    if (IS_EMPTY_STRING(self.firstNameTextField.text)
        || IS_EMPTY_STRING(self.lastNameTextField.text)
        || IS_EMPTY_STRING(self.ageTextField.text)) {
        DEBUG_LOG(@"Should non empty string");
        return;
    }
    
    
}

@end // @implementation EditInfoViewController
