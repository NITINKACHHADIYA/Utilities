

#import "KAAPIs.h"
#import "NSstring.h"
#import "NSdate.h"

@interface KAAPIs()
{
    NSHTTPURLResponse* httpResponse;
}
@end

@implementation KAAPIs

-(void)dealloc{
    
    self.strGetParameters=nil;
    self.strJsonParameters=nil;
    self.strLink=nil;
    
    dateStart=nil;
    dateEnd=nil;
    
    self.dictParameters=nil;
}
-(void)stopRequest{
    
    strLog=nil;
    _responseData=nil;
    [_connectonRequest cancel];
    _connectonRequest=nil;
    [self.delegate kaApisFail:self];
}
-(void)clear{
    
    [_connectonRequest cancel];
    _connectonRequest=nil;
    [self.delegate kaApisFail:self];
}
-(BOOL)checkAlertExist {
    return NO;
}
-(void)startRequest1{
    
    dateStart=[NSDate date];
    strLog=[[NSMutableString alloc] init];
    [strLog appendString:@"\n=============================================================="];
    [strLog appendString:[NSString stringWithFormat:@"\n================= %@ ================\n",[dateStart StringFromDateFormat:@"dd MMM yyyy hh:mm:ss:SSS a"]]];
    [strLog appendString:@"==============================================================\n\n"];
    [strLog appendString:[NSString stringWithFormat:@"Module  \t: %@\n",self.strModuleName]];
    
    NSString *encodedString=@"";
    if(self.iAPIType==KAPITypeGet) {
        encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)self.strGetParameters,NULL,(CFStringRef)@"!*'();:@+$,/?%#[]",kCFStringEncodingUTF8));
        //@"!*'();:@&=+$,/?%#[]"
    }
    NSURL *url=nil;
    if (KAPITypePost==self.iAPIType || KAPITypePostJson==self.iAPIType) {
        url=[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.strLink]];
    }else if(encodedString==nil){
        url=[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.strLink]];
    }else{
        url=[NSURL URLWithString:[NSString stringWithFormat:@"%@?%@",self.strLink,encodedString]];
    }
    encodedString=nil;
    
    NSMutableURLRequest *request1 = [[NSMutableURLRequest alloc] init];
    [request1 setURL:url];
    [request1 setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    [request1 setTimeoutInterval:self.minutes==0?2*60:self.minutes*60];
    [request1 setValue:@"ipad" forHTTPHeaderField:@"User-Agent"];
    
    if (self.iAPIType==KAPITypeGet) {
        [request1 setHTTPMethod:@"GET"];
        [strLog appendString:[NSString stringWithFormat:@"Link    \t: %@\nMethod  \t: %@\n",url,@"GET"]];
        
    }else if (self.iAPIType==KAPITypePost) {
        
        NSMutableString *postValues=[[NSMutableString alloc] init];
        for (int i=0;i<self.dictParameters.count;i++) {
            
            NSString *keys=self.dictParameters.allKeys[i];
            NSString *values=[NSString stringWithFormat:@"%@",[self.dictParameters valueForKey:self.dictParameters.allKeys[i]]];
            [postValues appendString:keys];
            [postValues appendString:@"="];
            [postValues appendString:values];
            [postValues appendString:@"&"];
        }
        
        [request1 setHTTPMethod:@"POST"];
        if (postValues.length>0) {
            [postValues substringToIndex:postValues.length-1];
            NSData *postData = [postValues dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
            
            [request1 setValue:postLength forHTTPHeaderField:@"Content-Length"];
            [request1 setHTTPBody:postData];
        }
        [strLog appendString:[NSString stringWithFormat:@"Link    \t: %@\nMethod  \t: %@\nRequest \t: %@\n",url,@"POST",postValues]];
        postValues=nil;
        
    }else if (self.iAPIType==KAPITypePostJson){
        [request1 setHTTPMethod:@"POST"];
        
        self.strJsonParameters=[self.strJsonParameters stringByReplacingOccurrencesOfString:@"" withString:@""];
        NSData *requestData = [NSData dataWithBytes:[self.strJsonParameters UTF8String] length:[self.strJsonParameters length]];
        NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]];
        
        [request1 setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request1 setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request1 setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request1 setHTTPBody:requestData];
        
        [strLog appendString:[NSString stringWithFormat:@"Link    \t: %@\nMethod  \t: %@\nRequest \t: %@\n",url,@"POST-JSON",self.strJsonParameters]];
    }
    
    [NSURLConnection sendAsynchronousRequest:request1 queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (!error && data!=nil) {
            NSError* error=nil;
            id json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            if (json) {
                NSLog(@"(weather-success)");
                [self.delegate kaApisSuccess:self response:json];
            }
        }
    }];
}
-(void)startRequest{
    
    dateStart=[NSDate date];
    strLog=[[NSMutableString alloc] init];
    [strLog appendString:@"\n=============================================================="];
    [strLog appendString:[NSString stringWithFormat:@"\n================= %@ ================\n",[dateStart StringFromDateFormat:@"dd MMM yyyy hh:mm:ss:SSS a"]]];
    [strLog appendString:@"==============================================================\n\n"];
    [strLog appendString:[NSString stringWithFormat:@"Module  \t: %@\n",self.strModuleName]];

    NSString *encodedString=@"";
    if(self.iAPIType==KAPITypeGet) {
        encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)self.strGetParameters,NULL,(CFStringRef)@"!*'();:@+$,/?%#[]",kCFStringEncodingUTF8));
        self.strLink=[self.strLink stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        //@"!*'();:@&=+$,/?%#[]"
    }
    NSURL *url=nil;
    
    if (KAPITypePost==self.iAPIType || KAPITypePostJson==self.iAPIType) {
        url=[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.strLink]];
    }else if(encodedString==nil){
        url=[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.strLink]];
    }else{
        url=[NSURL URLWithString:[NSString stringWithFormat:@"%@?%@",self.strLink,encodedString]];
    }
    encodedString=nil;
    
    NSMutableURLRequest *request1 = [[NSMutableURLRequest alloc] init];
    [request1 setURL:url];
    [request1 setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    [request1 setTimeoutInterval:self.minutes==0?2*60:self.minutes*60];
    [request1 setValue:@"ipad" forHTTPHeaderField:@"User-Agent"];
    
    if (self.iAPIType==KAPITypeGet) {
        [request1 setHTTPMethod:@"GET"];
        [strLog appendString:[NSString stringWithFormat:@"Link    \t: %@\nMethod  \t: %@\n",url,@"GET"]];
        
    }else if (self.iAPIType==KAPITypePost) {
        
        NSMutableString *postValues=[[NSMutableString alloc] init];
        for (int i=0;i<self.dictParameters.count;i++) {
            
            NSString *keys=self.dictParameters.allKeys[i];
            NSString *values=[NSString stringWithFormat:@"%@",[self.dictParameters valueForKey:self.dictParameters.allKeys[i]]];
            [postValues appendString:keys];
            [postValues appendString:@"="];
            [postValues appendString:values];
            [postValues appendString:@"&"];
        }
        
        [request1 setHTTPMethod:@"POST"];
        if (postValues.length>0) {
            [postValues substringToIndex:postValues.length-1];
            NSData *postData = [postValues dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];

            [request1 setValue:postLength forHTTPHeaderField:@"Content-Length"];
            [request1 setHTTPBody:postData];
        }
        [strLog appendString:[NSString stringWithFormat:@"Link    \t: %@\nMethod  \t: %@\nRequest \t: %@\n",url,@"POST",postValues]];
        postValues=nil;
        
    }else if (self.iAPIType==KAPITypePostJson){
        [request1 setHTTPMethod:@"POST"];
        
        self.strJsonParameters=[self.strJsonParameters stringByReplacingOccurrencesOfString:@"" withString:@""];
        NSData *requestData = [NSData dataWithBytes:[self.strJsonParameters UTF8String] length:[self.strJsonParameters length]];
        NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]];

        [request1 setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request1 setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request1 setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request1 setHTTPBody:requestData];
        [strLog appendString:[NSString stringWithFormat:@"Link    \t: %@\nMethod  \t: %@\nRequest \t: %@\n",url,@"POST-JSON",self.strJsonParameters]];
    }
    
    _responseData=nil;
    _responseData=[[NSMutableData alloc] init];
    _connectonRequest=[[NSURLConnection alloc] initWithRequest:request1 delegate:self];
    [_connectonRequest start];
    
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    httpResponse = (NSHTTPURLResponse*)response;
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [_responseData appendData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    [self PrintLog:nil];

    if (self.complitionBlock)
        self.complitionBlock(nil,_responseData,httpResponse);
    
    if (_responseData.length != 0 && httpResponse.statusCode==200){
        
        //[KAManager shareManager].modelUser.strHeader=[httpResponse.allHeaderFields valueForKey:KKAPOSTHeader]==nil?[KAManager shareManager].modelUser.strHeader:[httpResponse.allHeaderFields valueForKey:KKAPOSTHeader];
        
        if (self.responseType==KResponseTypeJson) {
            
            NSError* error=nil;
            id json = [NSJSONSerialization JSONObjectWithData:_responseData options:kNilOptions error:&error];
            if (!error && json){
                [self.delegate kaApisSuccess:self response:json];
            }else{
                [self.delegate kaApisFail:self];
            }
        }else if(self.responseType==KResponseTypeString) {
            
            if (_responseData.length==0) {
                if (![self checkAlertExist]) {
                }
            }else{
                NSString *json = [[NSString alloc] initWithBytes:[_responseData bytes] length:[_responseData length] encoding:NSUTF8StringEncoding];
                [self.delegate kaApisSuccess:self response:json];
            }
        }else if(self.responseType==KResponseTypeData) {
            [self.delegate kaApisSuccess:self response:_responseData];
        }
    }else if (httpResponse.statusCode==401){
        _connectonRequest=nil;
    }else{
        
        [self.delegate kaApisFail:self];
        _connectonRequest=nil;
    }
    _connectonRequest=nil;
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    [self PrintLog:error];

    if (self.complitionBlock)
        self.complitionBlock(error,nil,nil);
    
    if (error.code==NSURLErrorTimedOut) {
        [self.delegate kaApisTimeOut:self];
        if (![self checkAlertExist]) {

        }
    }else if(error.code==NSURLErrorCannotConnectToHost || error.code==NSURLErrorCannotFindHost || error.code==NSURLErrorNotConnectedToInternet){
        [self.delegate kaApisTimeOut:self];
        if (![self checkAlertExist]) {

        }
    }else{
        [self.delegate kaApisFail:self];
        if (![self checkAlertExist]) {

        }
    }
    _connectonRequest=nil;
}
-(void)finishRequest:(KAAPIsCompleted)complitionBlock{
    
    self.complitionBlock=complitionBlock;
}

-(void)PrintLog:(NSError *)error{
    
    dateEnd=[NSDate date];
    NSTimeInterval executionTime = [dateEnd timeIntervalSinceDate:dateStart];
    
    if (error) {
        [strLog appendString:[NSString stringWithFormat:@"Loading  \t: %.0f ms\n",executionTime*1000]];
        [strLog appendString:[NSString stringWithFormat:@"Error   \t: %@\n",error.localizedDescription]];
        
    }else if (httpResponse.statusCode==200) {
        
        //NSString *json = [[NSString alloc] initWithBytes:[_responseData bytes] length:[_responseData length] encoding:NSUTF8StringEncoding];
        [strLog appendString:[NSString stringWithFormat:@"Loading  \t: %.0f ms\n",executionTime*1000]];
        //[strLog appendString:[NSString stringWithFormat:@"Response\t: %@\n",json]];
        
    }else if (httpResponse.statusCode!=200) {
        
        [strLog appendString:[NSString stringWithFormat:@"Loading  \t: %.0f ms\n",executionTime*1000]];
        [strLog appendString:[NSString stringWithFormat:@"Error   \t: %@-%@\n",@(httpResponse.statusCode),[NSHTTPURLResponse localizedStringForStatusCode:httpResponse.statusCode]]];
    }
    [strLog appendString:@"\n=============================================================="];
    [strLog appendString:[NSString stringWithFormat:@"\n================= %@ ================\n",[dateEnd StringFromDateFormat:@"dd MMM yyyy hh:mm:ss:SSS a"]]];
    [strLog appendString:@"==============================================================\n\n"];
    
    if (httpResponse.statusCode==200) {
        //if(isAppOnTesting)NSLog(@"%@",strLog);
    }else{
        //if(isAppOnTesting)[self WriteLog:strLog];
    }
    strLog=nil;

}
-(void)WriteLog:(NSString *)content{
    
    NSLog(@"\n%@",content);
    NSFileHandle *file = [NSFileHandle fileHandleForUpdatingAtPath:[self LogFilepath]];
    [file seekToEndOfFile];
    [file writeData:[content dataUsingEncoding:NSUTF8StringEncoding]];
    [file closeFile];
    strLog=nil;
}
-(NSString *)LogFilepath{
    //NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    //NSString *fileName = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"log_%@.txt",[[NSDate date] StringFromDateFormat:@"yyyyMMdd"]]];
    
    NSString *fileName = [@"/Users/ruchir/Desktop/logs-Kidsxap-staff/" stringByAppendingPathComponent:[NSString stringWithFormat:@"log_%@.txt",[[NSDate date] StringFromDateFormat:@"yyyyMMdd"]]];
    if(![[NSFileManager defaultManager] fileExistsAtPath:fileName])
        [[NSFileManager defaultManager] createFileAtPath:fileName contents:nil attributes:nil];
    return fileName;
}

@end
