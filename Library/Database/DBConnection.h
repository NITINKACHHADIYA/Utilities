
#import <Foundation/Foundation.h>
#import <sqlite3.h>

// database name demo.sqlite

#define DB_NAME @"demo.sqlite"//@"Conferencedata////NSLog"

@interface DBConnection : NSObject 
{
    @private sqlite3 *g_database;
}

@property (nonatomic,assign,readwrite) sqlite3 *database;

+ (DBConnection *) sharedConnection;
+ (BOOL) executeQuery:(NSString *)query;
+ (NSMutableArray *) fetchResults:(NSString *)query;
+ (int) rowCountForTable:(NSString *)table where:(NSString *)where;
+ (void) errorMessage:(NSString *)msg;
+ (void) closeConnection;

- (id)initConnection;
- (void)close;

@end


// query

// 1) CREATE TABLE IF NOT EXISTS NTN (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,name TEXT)
// 2) INSERT INTO NTN (name) VALUES ('nitin')
// 3) DROP TABLE NTN
// 4) DELETE FROM NTN
// 5) DELETE FROM SQLITE_SEQUENCE WHERE name='NTN'
// 6) SELECT * FROM NTN
// 7) SELECT * FROM NTN ORDER BY id DESC
// 8) SELECT * FROM NTN GROUP BY name
// 9) SELECT * FROM NTN ORDER BY name DESC