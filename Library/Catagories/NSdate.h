

#import <Foundation/Foundation.h>

typedef enum {
    DateFormatHintNone,
    DateFormatHintRFC822,
    DateFormatHintRFC3339
} DateFormatHint;

@interface NSDate  (date)

+(NSDate *)dateFromInternetDateTimeString:(NSString *)dateString formatHint:(DateFormatHint)hint;
+(NSDate *)dateFromRFC3339String:(NSString *)dateString;
+(NSDate *)dateFromRFC822String:(NSString *)dateString;

-(NSDate*)dateFromDouble:(double) intrval;
-(double)secondOfDate;
-(NSString *)StringFromDateFormat:(NSString *)Format;
-(NSDictionary *)DayMonthYearFromDate;
-(NSString *)DayNameForDate;

-(NSDate *)offsetMonth:(int)numMonths;
-(NSDate *)offsetDay:(int)numDays;
-(NSDate *)offsetHours:(int)hours;
-(int)numDaysInMonth;
-(int)firstWeekDayInMonth;
-(int)year;
-(int)month;
-(int)day;

+(NSDate *)dateStartOfDay:(NSDate *)date;
+(NSDate *)dateStartOfWeek;
+(NSDate *)dateEndOfWeek;

@end
