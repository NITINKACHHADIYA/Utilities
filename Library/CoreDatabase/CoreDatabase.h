//
//  CoreDatabase.h
//
//  Created by YourCompany on 289/10/14.
//  Copyright (c) 2014 YourCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDatabase : NSObject

+(BOOL)addToCart:(NSDictionary *)dictionary fromTable:(NSString *)string ModelName:(NSString *)model;
+(NSArray *)fetchDataFromTable:(NSString *)string  ModelName:(NSString *)model;
+(NSArray *)fetchDataFromTable:(NSString *)string Where:(NSString *)where ModelName:(NSString *)model;
+(void)updateRowFromTable:(NSString *)string Where:(NSString *)where WithDictonary:(NSDictionary *)dictionary ModelName:(NSString *)model;
+(BOOL)deleteRowFromTable:(NSString *)string Where:(NSString *)where ModelName:(NSString *)model;
+(BOOL)deleteRowFromTable:(NSString *)string ModelName:(NSString *)model;

@end
