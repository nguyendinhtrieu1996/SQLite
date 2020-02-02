//
//  ViewController.m
//  Contact_SQLite
//
//  Created by LAP12852 on 2/1/20.
//  Copyright © 2020 LAP12852. All rights reserved.
//

#import "ViewController.h"

#import "CommonMacros.h"


@interface ViewController ()

@property (nonatomic, strong) DBManager *dbManager;

@end // @interface ViewController ()


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dbManager = [[DBManager alloc] initWithDatabaseName:@"Contact.sql"];
}

@end // @implementation ViewController
