//
//  DBManager.m
//  Contact_SQLite
//
//  Created by LAP12852 on 2/1/20.
//  Copyright © 2020 LAP12852. All rights reserved.
//

#import "DBManager.h"

#import <sqlite3.h>

#import "CommonMacros.h"

@interface DBManager()

@property (nonatomic, strong) NSString *documentsDirectory;
@property (nonatomic, strong) NSString *databaseFileName;
@property (nonatomic, strong) NSMutableArray *arrResults;

@end // @interface DBManager()


@implementation DBManager

#pragma mark - Life Cycles

- (instancetype)initWithDatabaseName:(NSString *)dbFileName {
    AssertNonNull(dbFileName);
    
    self = [super init];
    
    if (self) {
        NSArray<NSString *> *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        if (path.count > 0) {
            _documentsDirectory = [path objectAtIndex:0];
        }
        _databaseFileName = dbFileName;
        [self _copyDatabaseIntoDocumentsDirectory];
    }
    return self;
}

+ (instancetype)databaseWithFileName:(NSString *)dbFileName {
    DBManager *dbManager = [[DBManager alloc] initWithDatabaseName:dbFileName];
    return dbManager;
}

- (void)_copyDatabaseIntoDocumentsDirectory {
    AssertNonNull(self.databaseFileName);
    
    NSString *destinationPath = [self.documentsDirectory stringByAppendingPathComponent:self.databaseFileName];
    
    if (destinationPath && NO == [[NSFileManager defaultManager] fileExistsAtPath:destinationPath]) {
        NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:self.databaseFileName];
        AssertNonNull(sourcePath);
        
        NSError *error;
        [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:destinationPath error:&error];
        if (error != nil) {
            DEBUG_LOG(@"TRIEUND 2 >> Copy Database error %@", [error localizedDescription]);
        }
    }
}

#pragma mark - Interface methods

- (NSArray *)loadDataFromDB:(NSString *)query {
    AssertNonNull(query);
    [self runQuery:[query UTF8String] isQueryExecutable:NO];
    return (NSArray *)self.arrResults;
}

- (void)executeQuery:(NSString *)query {
    [self runQuery:[query UTF8String] isQueryExecutable:YES];
}

#pragma mark - Query DB

- (void)runQuery:(const char *)query isQueryExecutable:(BOOL)queryExecutable {
    AssertNonNull(self.documentsDirectory);
    AssertNonNull(self.databaseFileName);
    
    if (self.arrResults != nil) {
        [self.arrResults removeAllObjects];
        self.arrResults = nil;
    }
    self.arrResults = [[NSMutableArray alloc] init];
    
    if (self.arrColumnNames != nil) {
        [self.arrColumnNames removeAllObjects];
    }
    self.arrColumnNames = [[NSMutableArray alloc] init];
    
    sqlite3 *sqlite3Database;
    NSString *databasePath = [self.documentsDirectory stringByAppendingString:self.databaseFileName];
    int openDatabaseResult = sqlite3_open([databasePath UTF8String], &sqlite3Database);
    
    if (openDatabaseResult == SQLITE_OK) {
        sqlite3_stmt *compiledStatement;
        int prepareStatementResult = sqlite3_prepare_v2(sqlite3Database, query, -1, &compiledStatement, NULL);
        
        if (prepareStatementResult == SQLITE_OK) {
            if (NO == queryExecutable) {
                [self _executeStatement:compiledStatement];
            } else {
                int executableResults = sqlite3_step(compiledStatement);
                if (executableResults == SQLITE_DONE) {
                    self.affectedRows = sqlite3_changes(sqlite3Database);
                    self.lastInsertedRowID = sqlite3_last_insert_rowid(sqlite3Database);
                } else {
                    DEBUG_LOG(@"DB error: %s", sqlite3_errmsg(sqlite3Database));
                }
            }
        } else {
            DEBUG_LOG(@"DB error: %s", sqlite3_errmsg(sqlite3Database));
        }
        
        sqlite3_finalize(compiledStatement);
    }
    
    sqlite3_close(sqlite3Database);
}

- (void)_executeStatement:(sqlite3_stmt *)compiledStatement {
    NSMutableArray *arrDataRow;
    
    while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
        arrDataRow = [[NSMutableArray alloc] init];
        
        int totalColumns = sqlite3_column_count(compiledStatement);
        
        for (int i = 0; i < totalColumns; i++) {
            char *dbdataAsChars = (char *)sqlite3_column_text(compiledStatement, i);
            
            if (dbdataAsChars != NULL) {
                [arrDataRow addObject:[NSString stringWithUTF8String:dbdataAsChars]];
            }
            
            if (self.arrColumnNames.count != totalColumns) {
                dbdataAsChars = (char *)sqlite3_column_name(compiledStatement, i);
                [self.arrColumnNames addObject:[NSString stringWithUTF8String:dbdataAsChars]];
            }
        }
    }
    
    if (arrDataRow.copy > 0) {
        [self.arrResults addObject:arrDataRow];
    }
}

@end // @implementation DBManager
