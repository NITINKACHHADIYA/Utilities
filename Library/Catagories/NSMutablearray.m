

#import "NSMutablearray.h"

@implementation NSMutableArray (shorting)

-(NSMutableArray *)sortByStringKey:(NSString *)key ascending:(BOOL)asc{
    
    NSSortDescriptor *sortDescriptor;
    sortDescriptor=[[NSSortDescriptor alloc]initWithKey:key ascending:asc];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray=nil;
    sortedArray = [self sortedArrayUsingDescriptors:sortDescriptors];
    [sortDescriptor release];
    return [[[NSMutableArray alloc]initWithArray:sortedArray] autorelease];
}
-(NSMutableArray *)sortByIntKey:(NSString *)key{
    
    NSArray *sortedArray;
    sortedArray = [self sortedArrayUsingComparator:(NSComparator)^(id a, id b) {
        NSNumber *num1 = [NSNumber numberWithInt:[[a objectForKey:key] intValue]];
        NSNumber *num2 = [NSNumber numberWithInt:[[b objectForKey:key] intValue]];
        return [num1 compare:num2];
    }];
    return [[[NSMutableArray alloc]initWithArray:sortedArray] autorelease];
}

-(NSMutableArray *)sortByDateKey:(NSString *)key ascending:(BOOL)asc{
    
    NSSortDescriptor *sortDescriptor;
    sortDescriptor=[[NSSortDescriptor alloc]initWithKey:key ascending:asc];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray;
    sortedArray = [self sortedArrayUsingDescriptors:sortDescriptors];
    [sortDescriptor release];
    return [[[NSMutableArray alloc]initWithArray:sortedArray] autorelease];
}

-(NSMutableArray *)sortByDateStringKey:(NSString *)key dateFormat:(NSString *)format asc:(BOOL)asc{
    
    NSMutableArray *newArray = [[[NSMutableArray alloc] init] autorelease];
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:format];
    
    for (NSDictionary *dict in self){
        
        NSMutableDictionary *newDict = [[[NSMutableDictionary alloc] init] autorelease];
        [newDict addEntriesFromDictionary:dict];
        NSString *str=[dict objectForKey:key];
        NSDate *date = [formatter dateFromString:str];
        [newDict setObject:date forKey:key];
        [newArray addObject:newDict];
    }
    
    newArray=[self sortByDateKey:key ascending:asc];
    
    NSMutableArray *shortArray=[[[NSMutableArray alloc] init] autorelease];
    NSDateFormatter *formatter1 = [[[NSDateFormatter alloc] init] autorelease];
    [formatter1 setDateFormat:format];
    for (int i=0;i<newArray.count;i++){
        
        NSDictionary *dict=[newArray objectAtIndex:i];
        NSMutableDictionary *newDict = [[[NSMutableDictionary alloc] init] autorelease];
        [newDict addEntriesFromDictionary:dict];
        NSDate *date=[dict objectForKey:key];
        NSString *str = [formatter1 stringFromDate:date];
        [newDict setObject:str forKey:key];
        [shortArray addObject:newDict];
    }
    
    return shortArray;
}
-(NSMutableArray *)sortByDateStringKey:(NSString *)key dateFormat:(NSString *)format ascending:(BOOL)asc{
    
    NSMutableArray *newArray = [[[NSMutableArray alloc] init] autorelease];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    
    for (NSDictionary *dict in self){
        
        NSMutableDictionary *newDict = [[NSMutableDictionary alloc] init];
        [newDict addEntriesFromDictionary:dict];
        NSString *str=[dict objectForKey:@"order_date"];
        NSDate *date = [formatter dateFromString:str];
        [newDict setObject:date forKey:@"order_date"];
        [newArray addObject:newDict];
        [newDict release];
    }
    
    newArray=[newArray sortByDateKey:@"order_date" ascending:asc];
    
    NSMutableArray *shortArray=[[[NSMutableArray alloc] init] autorelease];
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:format];
    for (int i=0;i<newArray.count;i++){
        
        NSDictionary *dict=[newArray objectAtIndex:i];
        NSMutableDictionary *newDict = [[NSMutableDictionary alloc] init];
        [newDict addEntriesFromDictionary:dict];
        NSDate *date=[dict objectForKey:@"order_date"];
        //NSLog(@"date:%@",date);
        NSString *str = [formatter1 stringFromDate:date];
        //NSLog(@"date string:%@",str);
        [newDict setObject:str forKey:@"order_date"];
        [shortArray addObject:newDict];
        [newDict release];
    }
    
    [formatter release];
    [formatter1 release];
    
    return shortArray;
}
-(NSMutableArray *)sortArray{
    
    return [[[self sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] mutableCopy] autorelease];
}
-(NSMutableArray *)sortArrayBynumaric{
    
    return [[[self sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [(NSString *)obj1 compare:(NSString *)obj2 options:NSNumericSearch];
    }] mutableCopy] autorelease];
}

-(NSMutableArray *)removeEqualNameForKey:(NSString *)key{
    
    NSMutableArray *array=[[[NSMutableArray alloc] initWithCapacity:0] autorelease];
    
    for (int i=0;i<self.count;i++) {
        
        NSDictionary *dict1=[self objectAtIndex:i];
        
        int m=0;
        for (int j=0;j<array.count;j++) {
            
            NSDictionary *dict2=[array objectAtIndex:j];
            if ([[dict1 objectForKey:key] isEqualToString:[dict2 objectForKey:key]]) {
                m=1;
                break;
            }
        }
        if (m==0) {
            [array addObject:dict1];
        }
    }
    return array;
}
-(NSMutableArray *)removeEqualObjects{
    NSArray *copy = [[self copy] autorelease];
    NSUInteger total = copy.count;
    for (NSUInteger i = total - 1; i > 0; i--)
    {
        id obj = [copy objectAtIndex:i];
        if ([self indexOfObject:obj inRange:NSMakeRange(0, i)] != NSNotFound)
        {
            [self removeObjectAtIndex:i];
        }
    }
    
    return self;
}

-(NSMutableArray *)FindObjectsForKey:(NSString *)key Value:(NSString *)value{
    
    NSMutableString *str=[[[NSMutableString alloc] init] autorelease];
    [str appendString:[NSString stringWithFormat:@"%@ == '%@'",key,value]];
    NSPredicate *pred = [NSPredicate predicateWithFormat:str];
    NSArray *filtered = [self filteredArrayUsingPredicate:pred];
    return [[filtered mutableCopy] autorelease];
}
-(NSMutableArray *)FindObjectsWithAndobjectsWithKeyValue:(NSMutableDictionary *)dict{
    
    NSMutableString *str=[[[NSMutableString alloc] init] autorelease];
    
    for (NSString* key in [dict allKeys]) {
        [str appendString:[NSString stringWithFormat:@"%@ == '%@' AND ",key,[dict objectForKey:key]]];
    }
    NSString *filter=nil;
    if (str.length>4) {
        filter= [str substringToIndex:[str length]-5];
    }    NSPredicate *pred = [NSPredicate predicateWithFormat:filter];
    NSArray *filtered = [self filteredArrayUsingPredicate:pred];
    return [[filtered mutableCopy] autorelease];
}
-(NSMutableArray *)FindObjectsWithOrobjectsWithKeyValue:(NSMutableDictionary *)dict{
    
    NSMutableString *str=[[[NSMutableString alloc] init] autorelease];
    
    for (NSString* key in [dict allKeys]) {
        [str appendString:[NSString stringWithFormat:@"%@ == '%@' OR ",key,[dict objectForKey:key]]];
    }
    
    NSString *filter=nil;
    if (str.length>3) {
        filter= [str substringToIndex:[str length]-4];
    }
    NSPredicate *pred = [NSPredicate predicateWithFormat:filter];
    NSArray *filtered = [self filteredArrayUsingPredicate:pred];
    return [[filtered mutableCopy] autorelease];
}

-(void)moveObjectFromIndex:(NSUInteger)from toIndex:(NSUInteger)to{
    
    if (to != from) {
        id obj = [self objectAtIndex:from];
        [obj retain];
        [self removeObjectAtIndex:from];
        if (to >= [self count]) {
            [self addObject:obj];
        } else {
            [self insertObject:obj atIndex:to];
        }
        [obj release];
    }
}

-(NSMutableArray *)ShortByDate:(NSString *)dateFormat key:(NSString *)key asc:(BOOL)asc{
    
    NSMutableArray *newArray = [[[NSMutableArray alloc] init] autorelease];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormat];
    
    for (NSDictionary *dict in self){
        
        NSMutableDictionary *newDict = [[NSMutableDictionary alloc] init];
        [newDict addEntriesFromDictionary:dict];
        NSString *str=[dict objectForKey:key];

        NSDate *date = [formatter dateFromString:str];
        [newDict setObject:date forKey:@"short_by_date"];
        [newArray addObject:newDict];
    }
    
    newArray=[newArray sortByDateKey:@"short_by_date" ascending:asc];
    return newArray;
}

-(NSMutableArray *)ShortByDateTime:(NSString *)dateFormat dateKey:(NSString *)date timeKey:(NSString *)time asc:(BOOL)asc{
    
    NSMutableArray *newArray = [[[NSMutableArray alloc] init] autorelease];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormat];
    
    for (NSDictionary *dict in self){
        
        NSMutableDictionary *newDict = [[NSMutableDictionary alloc] init];
        [newDict addEntriesFromDictionary:dict];
        NSString *str=[dict objectForKey:date];
        NSString *timeStr=[dict objectForKey:time];

        NSDate *date = [formatter dateFromString:[NSString stringWithFormat:@"%@ %@",str,timeStr]];
        [newDict setObject:date forKey:@"short_by_date"];
        [newArray addObject:newDict];
    }
    
    newArray=[newArray sortByDateKey:@"short_by_date" ascending:asc];
    return newArray;
}

@end

