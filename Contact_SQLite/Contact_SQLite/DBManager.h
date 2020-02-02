//
//  DBManager.h
//  Contact_SQLite
//
//  Created by LAP12852 on 2/1/20.
//  Copyright © 2020 LAP12852. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DBManager : NSObject

@property (nonatomic, strong) NSMutableArray    *arrColumnNames;
@property (nonatomic) int                       affectedRows;
@property (nonatomic) long long                 lastInsertedRowID;

- (instancetype)initWithDatabaseName:(NSString *)dbFileName;

+ (instancetype)databaseWithFileName:(NSString *)dbFileName;

- (NSArray *)loadDataFromDB:(NSString *)query;

- (void)executeQuery:(NSString *)query;

@end // @interface DBManager

NS_ASSUME_NONNULL_END
