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

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) DBManager         *dbManager;
@property (nonatomic, strong) NSMutableArray    *peopleInfos;

@end // @interface ViewController ()


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseName:@"Contact.sql"];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - UITableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.peopleInfos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    AssertNonNull(cell);
    return cell;
}

@end // @implementation ViewController
