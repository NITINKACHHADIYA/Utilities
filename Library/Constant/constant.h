
#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
#import "NSdate.h"
#import "NSMutablearray.h"
#import "NSstring.h"
#import "UIButton+Border.h"
#import "UIcolor.h"
#import "UIimage.h"
#import "UIview.h"
#import "UIimageView+Border.h"
#import "UIImageView+WebCache.h"
#import "DBConnection.h"
#import "GlobalVariables.h"
#import "JASidePanelController.h"
#import "UIViewController+JASidePanel.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
#import "EGORefreshTableHeaderView.h"
#import "MARKRangeSlider.h"
#import "JDFlipNumberView.h"
#import "JDDateCountdownFlipView.h"
#import "RTSpinKitView.h"
#import "CTAssetsPickerController.h"
#import "CTAssetsPageViewController.h"
#import "DisplayMap.h"
#import "Luhn.h"
#import "PayPalMobile.h"

@interface constant : NSObject

#define UIColorFromRGBWithAlpha(rgbValue,a) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#ifdef DEBUG
#   define NSLog(...) NSLog(__VA_ARGS__)//#   define NSLog(...) NSLog(__VA_ARGS__)

#else
#   define NSLog(...)
#endif

#define Release(x) [x release]

#define safeRelease(x) [x release], x = nil

@end
