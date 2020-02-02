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
@property (nonatomic, strong) NSArray           *peopleInfos;

@end // @interface ViewController ()


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseName:@"Contact.sql"];
    self.peopleInfos = [NSMutableArray array];
    [self _setupTableView];
    [self _loadDataFromDB];
}

- (void)_setupTableView {
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
}

- (void)_loadDataFromDB {
    NSString *query = @"SELECT * FROM peopleInfo";
    self.peopleInfos = [NSArray arrayWithArray:[self.dbManager loadDataFromDB:query]];
    [self.tableView reloadData];
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
    
    NSInteger indexOfFirstname = [self.dbManager.arrColumnNames indexOfObject:@"firstname"];
    NSInteger indexOfLastname = [self.dbManager.arrColumnNames indexOfObject:@"lastname"];
    NSInteger indexOfAge = [self.dbManager.arrColumnNames indexOfObject:@"age"];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", [[self.peopleInfos objectAtIndex:indexPath.row] objectAtIndex:indexOfFirstname], [[self.peopleInfos objectAtIndex:indexPath.row] objectAtIndex:indexOfLastname]];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Age: %@", [[self.peopleInfos objectAtIndex:indexPath.row] objectAtIndex:indexOfAge]];
    
    return cell;
}

@end // @implementation ViewController
