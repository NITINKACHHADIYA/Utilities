//
//  webServices.m
//
//  Created by  on 328/11/14.
//  Copyright (c) 2014 . All rights reserved.
//

#import "webServices.h"
#import "constant.h"
#import "CommonMethods.h"
#import "AppDelegate.h"
#import "ASIFormDataRequest.h"

@implementation webServices
@synthesize delegate;
@synthesize tag;


-(void)loginRequest:(NSString *)email password:(NSString *)password{
    
    AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    HUD=[[MBProgressHUD alloc] initWithView:appDelegate.window];
    [HUD show:YES];
    [appDelegate.window addSubview:HUD];
    
    NSString *post = [NSString stringWithFormat:@"type=seller_login&seller_email=%@&seller_password=%@&seller_device_id=%@",email,password,appDelegate.strDeviceToken];
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSString *apiString = [NSString stringWithFormat:@"%@",APP_URL];
    [request setURL:[NSURL URLWithString:apiString]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSURLConnection *connectionRequest=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    if(connectionRequest) {
        data = [NSMutableData data];
    }else{
        NSError *error=nil;
        if ([self.delegate respondsToSelector:@selector(WebServicesError:type:)]){
            [self.delegate WebServicesError:error type:self.type];
        }
    }
}
-(void)addItemRequest:(NSDictionary *)dict{
    
    AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    HUD=[[MBProgressHUD alloc] initWithView:appDelegate.window];
    [HUD show:YES];
    [appDelegate.window addSubview:HUD];
    
    NSMutableData *postData = [[NSMutableData alloc] init];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSString *apiString = [NSString stringWithFormat:@"%@",APP_URL] ;
    [request setURL:[NSURL URLWithString:apiString]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    for (NSInteger i=0;i<[[dict objectForKey:@"p_image_count"] integerValue];i++) {
        
        [postData appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"p_product_multi_image%ld\"; filename=\"image%ld.jpg\"\r\n",(long)i,(long)i] dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
        NSData *imgData = [NSData dataWithData:UIImageJPEGRepresentation((UIImage *)[dict objectForKey:[NSString stringWithFormat:@"p_product_multi_image%ld",(long)i]],0.8)];
        
        [postData appendData:imgData];
        [postData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [postData appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"p_product_image\"; filename=\"main.jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSData *imgData = [NSData dataWithData:UIImageJPEGRepresentation((UIImage *)[dict objectForKey:[NSString stringWithFormat:@"p_product_image"]],0.8)];
    
    [postData appendData:imgData];
    [postData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    //  parameter username
    
    [postData appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"type\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postData appendData:[@"add_product" dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    //  parameter token
    [postData appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"p_seller_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postData appendData:[[dict objectForKey:@"p_seller_id"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    //  parameter token
    [postData appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"p_tag_count\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postData appendData:[[NSString stringWithFormat:@"%ld",(long)[[dict objectForKey:@"count"] integerValue]] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    

    for (NSInteger i=0;i<[[dict objectForKey:@"count"] integerValue];i++) {
        
        [postData appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"tag_name%ld\"\r\n\r\n",(long)i] dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[[dict objectForKey:[NSString stringWithFormat:@"tag%ld",(long)i]] dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];

    }
    
    // parameter method
    
    [postData appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"p_avail_quantity\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postData appendData:[[dict objectForKey:@"p_avail_quantity"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postData appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"p_name\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postData appendData:[[dict objectForKey:@"p_name"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postData appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"p_description\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postData appendData:[[dict objectForKey:@"p_description"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postData appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"p_price\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postData appendData:[[dict objectForKey:@"p_price"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postData appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"p_size_count\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postData appendData:[[dict objectForKey:@"p_size_count"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    for (NSInteger i=0;i<[[dict objectForKey:@"p_size_count"] integerValue];i++) {
        
        [postData appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"p_size_name%ld\"\r\n\r\n",(long)i] dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[[dict objectForKey:[NSString stringWithFormat:@"p_size%ld",(long)i]] dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
        NSLog(@"--%@",[dict objectForKey:[NSString stringWithFormat:@"p_size%ld",(long)i]]);

    }
    
    
    NSLog(@"-%@",[dict objectForKey:@"p_size_count"]);
    
    [postData appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"p_image_count\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postData appendData:[[dict objectForKey:@"p_image_count"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postData appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"p_color_count\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postData appendData:[[dict objectForKey:@"p_color_count"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    for (NSInteger i=0;i<[[dict objectForKey:@"p_color_count"] integerValue];i++) {
        
        [postData appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"p_color_name%ld\"\r\n\r\n",(long)i] dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[[dict objectForKey:[NSString stringWithFormat:@"p_color%ld",(long)i]] dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
        [postData appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"p_color_code%ld\"\r\n\r\n",(long)i] dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[[dict objectForKey:[NSString stringWithFormat:@"p_color_code%ld",(long)i]] dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
        NSLog(@"--%@",[dict objectForKey:[NSString stringWithFormat:@"p_color%ld",(long)i]]);
        NSLog(@"--%@",[dict objectForKey:[NSString stringWithFormat:@"p_color_code%ld",(long)i]]);

    }
    NSLog(@"-%@",[dict objectForKey:@"p_color_count"]);
    
    [postData appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:postData];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setTimeoutInterval:5*60];
    
    NSURLConnection *connectionRequest=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    if(connectionRequest) {
        data = [NSMutableData data];
    }else{
        NSError *error=nil;
        if ([self.delegate respondsToSelector:@selector(WebServicesError:type:)]){
            [self.delegate WebServicesError:error type:self.type];
        }
    }
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    [connection cancel];
    if (HUD) {
        [HUD removeFromSuperview];
    }
    if ([self.delegate respondsToSelector:@selector(WebServicesError:type:)]){
        [self.delegate WebServicesError:error type:self.type];
    }
    if ([self.delegate respondsToSelector:@selector(WebServicesNext:)]){
        [self.delegate WebServicesNext:self.type];
    }
}
-(void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)incrementalData{
    if (data == nil)
        data = [[NSMutableData alloc] initWithCapacity:4048];
    [data appendData:incrementalData];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)theConnection{
    
    if (HUD) {
        [HUD removeFromSuperview];
    }
    NSString *response = [[NSString alloc] initWithBytes: [data mutableBytes] length:[data length] encoding:NSUTF8StringEncoding];
    [theConnection cancel];
    [self response:response];
}

-(void)response:(NSString *)string{
    
    if (string.length != 0){
        
        NSError* error=nil;
        NSMutableDictionary* json = [NSJSONSerialization JSONObjectWithData:[string dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
        
        if (!error) {
            NSArray *ArrayResponse=[[json objectForKey:@"DATA"] copy];
            if (ArrayResponse.count>0) {
                if ([[[ArrayResponse objectAtIndex:0] objectForKey:@"result"] isEqualToString:@"success"]){
                    
                    if ([self.delegate respondsToSelector:@selector(WebServicesResponse:type:)]){
                        [self.delegate WebServicesResponse:[ArrayResponse mutableCopy] type:self.type];
                    };
                    
                }else{
                    //NSLog(@"%@",string);
                    if ([self.delegate respondsToSelector:@selector(WebServicesAlert:type:)]){
                        [self.delegate WebServicesAlert:[[ArrayResponse objectAtIndex:0] objectForKey:@"msg"] type:self.type];
                    }
                }
            }else{
                //NSLog(@"%@",string);
                if ([self.delegate respondsToSelector:@selector(WebServicesError:type:)]){
                    [self.delegate WebServicesError:error type:self.type];
                }
            }
        }else{
            
            //NSLog(@"%@",string);
            if ([self.delegate respondsToSelector:@selector(WebServicesError:type:)]){
                [self.delegate WebServicesError:error type:self.type];
            }
        }
    }else{
        NSError *error=nil;
        if ([self.delegate respondsToSelector:@selector(WebServicesError:type:)]){
            [self.delegate WebServicesError:error type:self.type];
        };
    }
    
    if ([self.delegate respondsToSelector:@selector(WebServicesNext:)]){
        [self.delegate WebServicesNext:self.type];
    }
}

@end
