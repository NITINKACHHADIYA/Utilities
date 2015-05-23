

#import <Foundation/Foundation.h>

@interface NSMutableArray (shorting)

-(NSMutableArray *)sortByStringKey:(NSString *)key ascending:(BOOL)asc;
-(NSMutableArray *)sortByIntKey:(NSString *)key;

-(NSMutableArray *)sortByDateKey:(NSString *)key ascending:(BOOL)asc;
-(NSMutableArray *)sortByDateStringKey:(NSString *)key dateFormat:(NSString *)format ascending:(BOOL)asc;
-(NSMutableArray *)sortByDateStringKey:(NSString *)key dateFormat:(NSString *)format asc:(BOOL)asc;
-(NSMutableArray *)ShortByDate:(NSString *)dateFormat key:(NSString *)key asc:(BOOL)asc;
-(NSMutableArray *)ShortByDateTime:(NSString *)dateFormat dateKey:(NSString *)date timeKey:(NSString *)time asc:(BOOL)asc;

-(NSMutableArray *)sortArray;
-(NSMutableArray *)sortArrayBynumaric;

-(NSMutableArray *)removeEqualNameForKey:(NSString *)key;
-(NSMutableArray *)removeEqualObjects;

-(NSMutableArray *)FindObjectsForKey:(NSString *)key Value:(NSString *)value;
-(NSMutableArray *)FindObjectsWithAndobjectsWithKeyValue:(NSMutableDictionary *)dict;
-(NSMutableArray *)FindObjectsWithOrobjectsWithKeyValue:(NSMutableDictionary *)dict;

-(void)moveObjectFromIndex:(NSUInteger)from toIndex:(NSUInteger)to;

@end
