//
//  webServices.h
//
//
//  Created by  on 328/11/14.
//  Copyright (c) 2014 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

#define APP_URL @""

@protocol WebServicesDelegate <NSObject>
@optional

-(void)WebServicesResponse:(NSMutableArray *)arrayResponse type:(NSString *)type;
-(void)WebServicesError:(NSError *)error type:(NSString *)type;
-(void)WebServicesAlert:(NSString *)alert type:(NSString *)type;
-(void)WebServicesNext:(NSString *)type;

@end

@interface webServices : NSObject<NSURLConnectionDelegate>
{
    NSMutableData *data;
    MBProgressHUD *HUD;
    
}

@property (nonatomic,weak) id <WebServicesDelegate> delegate;
@property (nonatomic)  int tag;
@property (nonatomic,weak) NSString *type;

-(void)loginRequest:(NSString *)email password:(NSString *)password;
-(void)addItemRequest:(NSDictionary *)dict;

@end

/**/
//============================//
/*NSString *post = [NSString stringWithFormat:@"Userid=%@&deviceid=%@&OutputType=JSON",userid,deviceid];
 NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
 NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
 
 NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
 NSString *apiString = [NSString stringWithFormat:@"%@getdownloads/downloadcount/",APP_URL_20140822] ;
 [request setURL:[NSURL URLWithString:apiString]];
 [request setHTTPMethod:@"POST"];
 [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
 [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
 [request setHTTPBody:postData];
 
 ConnectionDownloadCount = [[NSURLConnection alloc] initWithRequest:request delegate:self];
 
 if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"status"] isEqualToString:@"pause"]) {
 if(ConnectionDownloadCount) {
 data = [NSMutableData data];
 }else{
 [self connectionFailed];
 }
 }*/

