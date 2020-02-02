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

@property (strong, nonatomic) DBManager *dbManager;

@end // @interface EditInfoViewController ()


@implementation EditInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dbManager = [[DBManager alloc] initWithDatabaseName:@"Contact.sql"];
}

- (IBAction)touchInSaveButton:(id)sender {
    if (IS_EMPTY_STRING(self.firstNameTextField.text)
        || IS_EMPTY_STRING(self.lastNameTextField.text)
        || IS_EMPTY_STRING(self.ageTextField.text)) {
        DEBUG_LOG(@"Should non empty string");
        return;
    }
    
    NSString *query = [NSString stringWithFormat:@"insert into peopleInfo values(null, '%@', '%@', %d)",
                       self.firstNameTextField.text,
                       self.lastNameTextField.text,
                       [self.ageTextField.text intValue]];
    
    [self.dbManager executeQuery:query];
    
    if (self.dbManager.affectedRows != 0) {
        DEBUG_LOG(@"Query was execute successfully. Affected row = %d", self.dbManager.affectedRows);
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        DEBUG_LOG(@"Clould not execute the query '%@'", query);
    }
}

@end // @implementation EditInfoViewController
