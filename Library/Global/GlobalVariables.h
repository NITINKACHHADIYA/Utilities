
#import <Foundation/Foundation.h>

@interface GlobalVariables : NSObject

+(GlobalVariables *)getInstance;

@property (nonatomic,retain)    NSString          *tokenString;

@property (nonatomic,retain)    NSString        *user_number;
@property (nonatomic,retain)    NSString        *user_id;
@property (nonatomic,retain)    NSString        *user_image;
@property (nonatomic,retain)    NSString        *user_email;
@property (nonatomic,retain)    NSString        *user_name;
@property (nonatomic,retain)    NSString        *user_full_name;
@property (nonatomic,retain)    NSString        *user_password;
@property (nonatomic,retain)    NSString        *user_type;
@property (nonatomic,retain)    NSString        *user_workplace;

@property (nonatomic,assign)    BOOL            isSetting;
@property (nonatomic,assign)    BOOL            isNotificationON;
@property (nonatomic,assign)    BOOL            isSoundON;
@property (nonatomic,assign)    BOOL            isVibrationON;
@property (nonatomic,assign)    BOOL            isRemindON;
@property (nonatomic,assign)    BOOL            isShiftON;
@property (nonatomic,assign)    BOOL            isEdit;

@property (nonatomic,retain)    NSMutableArray  *array_profile_images;
@property (nonatomic,retain)    NSMutableArray  *array_user_details;
@property (nonatomic,retain)    NSMutableArray  *array_employees;

@property (nonatomic,assign)    int             reminderTIME;
@property (nonatomic,assign)    int             ButtonTag;
@property (nonatomic,assign)    int             colleaguesProfileFromWhichView;
@property (nonatomic,assign)    int             shifteditFromWhichView;
@property (nonatomic,assign)    int             NotificationView;

@end