
#import "GlobalVariables.h"

@implementation GlobalVariables

static GlobalVariables *instance =nil;

+(GlobalVariables *)getInstance{
    
    @synchronized(self){
        
        if(instance==nil){
            
            instance= [GlobalVariables new];
        }
    }
    return instance;
}

@end
