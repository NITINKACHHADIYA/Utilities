//
//  Utilities.h
//  Utilities
//
//  Created by YourCompany on 143/05/15.
//  Copyright (c) 2015 YourCompany. All rights reserved.
//

//cd ~/Desktop/RWUIControls.framework
//RWUIControls.framework  xcrun lipo -info RWUIControls

#import <Foundation/Foundation.h>

#import "constant.h"

@interface Utilities : NSObject

@end

/*-lc++,-ObjC,-fno-objc-arc,-O0,-all_load*/
/*================== webservices ==================*/
/*==================================================
 
 -(void)RegistrationWebservice:(EVUserObject *)object{
 
 self.view.userInteractionEnabled=NO;
 CGRect screenBounds = [[UIScreen mainScreen] bounds];
 RTSpinKitView *spinner = [[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStyleCircle color:[UIColor blackColor]];
 spinner.center = CGPointMake(CGRectGetMidX(screenBounds),CGRectGetMidY(screenBounds));
 spinner.backgroundColor=[UIColor clearColor];
 [spinner startAnimating];
 [self.view addSubview:spinner];
 
 NSLog(@"========== Registration ==========");
 NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@",KAPPURL]];
 __weak ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
 request.delegate=self;
 [request setRequestMethod:@"POST"];
 [request setPostValue:KPUserRegistration forKey:KPType];
 [request setPostValue:object.strEmail forKey:KPUserEmail];
 [request setPostValue:object.strPassword forKey:KPUserPassword];
 [request setPostValue:object.strFirstName forKey:KPUserFName];
 [request setPostValue:object.strLastName forKey:KPUserLName];
 [request setPostValue:object.strPhone forKey:KPUserPhone];
 [request setPostValue:object.strUsername forKey:KPUserName];
 [request setData:UIImageJPEGRepresentation(self.imgUserPhoto.image,1) withFileName:@"user.jpg" andContentType:@"image" forKey:KPUserImage];
 
 [request setTimeOutSeconds:3*60];
 request.showAccurateProgress=YES;
 [request startAsynchronous];
 
 NSLog(@"%@",[request valueForKey:@"postData"]);
 NSLog(@"===========================");
 
 [request setCompletionBlock:^{
 
 self.view.userInteractionEnabled=YES;
 [spinner removeFromSuperview];
 NSData *ResponseData=[request responseData];
 if (ResponseData.length != 0){
 
 NSError* error=nil;
 NSMutableDictionary* json = [NSJSONSerialization JSONObjectWithData:ResponseData options:kNilOptions error:&error];
 if (!error){
 NSLog(@"%@",json);
 NSArray *ArrayResponse=[[json objectForKey:@"DATA"] copy];
 if (ArrayResponse.count>0) {
 if ([[[ArrayResponse objectAtIndex:0] objectForKey:KResult] isEqualToString:KSuccess]) {
 
 UIAlertView *alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Message",nil) message: [[ArrayResponse objectAtIndex:0] objectForKey:KMessage] delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok",nil) otherButtonTitles:nil];
 [alert show];
 alert=nil;
 
 }else{
 
 UIAlertView *alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Message",nil) message: [[ArrayResponse objectAtIndex:0] objectForKey:KMessage] delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok",nil) otherButtonTitles:nil];
 [alert show];
 alert=nil;
 }
 }
 }else{
 NSLog(@"%@",request.responseString);
 }
 }
 NSLog(@"========== Registration ==========");
 }];
 
 [request setFailedBlock:^{
 
 self.view.userInteractionEnabled=YES;
 [spinner removeFromSuperview];
 NSLog(@"Error:%@",[request error]);
 NSLog(@"========== Registration ==========");
 
 }];
 }
 ==================================================*/
/*================== image load ==================*/
/*==================================================
 -(void)setImage:(NSString *)strUrl ofImageView:(UIImageView *)view{
 
 @try {
 __block SDWebImageManager *manager = [SDWebImageManager sharedManager];
 [manager downloadImageWithURL:[NSURL URLWithString:strUrl] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize){}completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL){if (error) {view.image=nil;manager=nil;}else{view.image=image;manager=nil;}}];
 }@catch (NSException *exception){}
 }
 ==================================================*/
/*================= datecounter ==================*/
/*==================================================
 self.DateView = [[JDDateCountdownFlipView alloc] initWithDayDigitCount:2 imageBundleName:nil];
 [self.viewTimer addSubview:self.DateView];
 self.DateView.frame=self.viewTimer.bounds;
 self.DateView.frame=CGRectMake(0,5,self.DateView.frame.size.width,self.DateView.frame.size.height);
 ==================================================*/
/*================== zoom map ====================*/
/*==================================================
 -(void)zoomToFitMapAnnotations:(MKMapView*)mapView{
 
 if([mapView.annotations count] == 0)
 return;
 
 CLLocationCoordinate2D topLeftCoord;
 topLeftCoord.latitude = -90;
 topLeftCoord.longitude = 180;
 
 CLLocationCoordinate2D bottomRightCoord;
 bottomRightCoord.latitude = 90;
 bottomRightCoord.longitude = -180;
 
 for(DisplayMap *annotation in mapView.annotations)
 {
 topLeftCoord.longitude = fmin(topLeftCoord.longitude, annotation.coordinate.longitude);
 topLeftCoord.latitude = fmax(topLeftCoord.latitude, annotation.coordinate.latitude);
 
 bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, annotation.coordinate.longitude);
 bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, annotation.coordinate.latitude);
 }
 MKCoordinateRegion region;
 region.center.latitude = topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.5;
 region.center.longitude = topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.5;
 region.span.latitudeDelta = fabs(topLeftCoord.latitude - bottomRightCoord.latitude) * 1.15; // Add a little extra space on the sides
 region.span.longitudeDelta = fabs(bottomRightCoord.longitude - topLeftCoord.longitude) * 1.15; // Add a little extra space on the sides
 
 region = [mapView regionThatFits:region];
 [mapView setRegion:region animated:YES];
 }
 ==================================================*/
/*=============== globalvariable =================*/
/*==================================================
 static GlobalVariables *instance =nil;
 
 +(GlobalVariables *)getInstance{
 
 @synchronized(self){
 
 if(instance==nil){
 
 instance= [GlobalVariables new];
 }
 }
 return instance;
 }
 ==================================================*/
/*================= slide view ===================*/
/*==================================================
 self.slideViewController = [[JASidePanelController alloc] init];
 self.slideViewController.shouldDelegateAutorotateToVisiblePanel = NO;
 self.slideViewController.leftFixedWidth=260;
 self.slideViewController.rightFixedWidth=0;
 self.slideViewController.leftGapPercentage=0;
 self.slideViewController.rightGapPercentage=0;
 self.slideViewController.bounceDuration=0;
 self.slideViewController.bouncePercentage=0;
 self.slideViewController.pushesSidePanels=NO;
 self.slideViewController.panningLimitedToTopViewController=NO;
 self.slideViewController.recognizesPanGesture=NO;
 self.slideViewController.allowLeftOverpan=YES;
 self.slideViewController.allowRightOverpan=YES;
 self.slideViewController.bounceOnSidePanelClose=NO;
 self.slideViewController.bounceOnSidePanelOpen=NO;
 
 self.navigationController=[[UINavigationController alloc] initWithRootViewController:[[EVHomeViewController alloc] initWithNibName:@"EVHomeViewController" bundle:nil]];
 self.navigationController.navigationBarHidden=YES;
 
 self.slideViewController.leftPanel = [[EVLeftViewController alloc] initWithNibName:@"EVLeftViewController" bundle:nil];
 self.slideViewController.rightPanel=nil;
 self.slideViewController.centerPanel = self.navigationController;
 ==================================================*/
/*=============== image picker ===================*/
/*==================================================
 -(void)assertPicker{
 
 if (!self.arrayPhotos)
 self.arrayPhotos = [[NSMutableArray alloc] init];
 
 CTAssetsPickerController *picker = [[CTAssetsPickerController alloc] init];
 picker.assetsFilter         = [ALAssetsFilter allPhotos];
 picker.showsCancelButton    = (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad);
 picker.delegate             = self;
 picker.selectedAssets       = [NSMutableArray arrayWithArray:self.arrayPhotos];
 [self presentViewController:picker animated:YES completion:nil];
 }
 -(BOOL)assetsPickerController:(CTAssetsPickerController *)picker isDefaultAssetsGroup:(ALAssetsGroup *)group{
 
 return ([[group valueForProperty:ALAssetsGroupPropertyType] integerValue] == ALAssetsGroupSavedPhotos);
 }
 -(void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets{
 
 [picker.presentingViewController dismissViewControllerAnimated:YES completion:nil];
 self.arrayPhotos = [NSMutableArray arrayWithArray:assets];
 
 for (UIView *v in self.scrlImage.subviews) {
 [v removeFromSuperview];
 }
 
 for (int i=0;i<self.arrayPhotos.count;i++) {
 
 ALAsset *assets=[self.arrayPhotos objectAtIndex:i];
 if (assets){
 CGImageRef image=[assets aspectRatioThumbnail];
 UIImageView *imagev=[[UIImageView alloc] initWithFrame:CGRectMake(5+i*25,1,20,20)];
 imagev.image=[UIImage imageWithCGImage:image];
 [self.scrlImage addSubview:imagev];
 [self.scrlImage setContentSize:CGSizeMake((i+1)*25,22)];
 }
 }
 }
 -(BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldEnableAsset:(ALAsset *)asset{
 // Enable video clips if they are at least 5s
 if ([[asset valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypeVideo]){
 
 NSTimeInterval duration = [[asset valueForProperty:ALAssetPropertyDuration] doubleValue];
 return lround(duration) >= 5;
 }else{
 return YES;
 }
 }
 -(BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldSelectAsset:(ALAsset *)asset{
 if (picker.selectedAssets.count >= 5){
 
 UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Attention",nil) message:NSLocalizedString(@"You can select maximum 5 images",nil) delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Ok",nil), nil];
 [alertView show];
 }
 if (!asset.defaultRepresentation){
 
 UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Attention",nil) message:NSLocalizedString(@"Your images has not yet been downloaded to your device",nil) delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Ok",nil), nil];
 [alertView show];
 }
 return (picker.selectedAssets.count < 5 && asset.defaultRepresentation != nil);
 }
 ==================================================*/
/*================= pull refresh =================*/
/*==================================================
 -(void)setRefreshControl{
 
 if (self.refreshHeaderView == nil) {
 
 EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tblEvents.bounds.size.height, self.tblEvents.frame.size.width,self.tblEvents.bounds.size.height)];
 view.backgroundColor=[UIColor clearColor];
 view.delegate = self;
 [self.tblEvents addSubview:view];
 self.refreshHeaderView = view;
 
 }
 [self.refreshHeaderView refreshLastUpdatedDate];
 }
 -(void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
 
 self.reloading=YES;
 if (self.arrayEvents.count>0) {
 EVHomeObject *obj=[self.arrayEvents firstObject];
 [self EventsWebservice:obj.iEventId NoOfEvents:KPEventNew EventIdKey:KPEventNewID];
 }else{
 [self EventsWebservice:0 NoOfEvents:KPEventNew EventIdKey:KPEventNewID];
 }
 
 }
 -(BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
 
 return self.reloading;
 }
 -(NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
 
 return [NSDate date];
 }
 -(void)stopLoading{
 
 self.reloading=NO;
 [self.refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tblEvents];
 }
 
 #pragma mark - UIScrollViewDelegate Methods -
 
 -(void)scrollViewDidScroll:(UIScrollView *)scrollView{
 
 [self.refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
 }
 -(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
 
 [self.refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
 }
 ==================================================*/
/*================ modify string =================*/
/*==================================================
 NSMutableAttributedString *string=[[NSMutableAttributedString alloc] initWithString:self.lbl1.text];
 [string addAttribute:NSForegroundColorAttributeName value:ColorEvent range:[self.lbl1.text rangeOfString:NSLocalizedString(@"Date:",nil)]];
 self.lbl1.attributedText=string;
 ==================================================*/
/*================ modify textfield ===============*/
/*==================================================
-(void)modifyTextField:(UITextField *)textField rect:(CGRect)rect{
    UIView *paddingView = [[UIView alloc] initWithFrame:rect];
    textField.leftView = paddingView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.rightView = paddingView;
    textField.rightViewMode = UITextFieldViewModeAlways;
}
 ==================================================*/
/*============== filter predicate =================*/
/*==================================================
-(NSPredicate *)predicateById:(NSInteger)Lid{
    NSPredicate *pred = [NSPredicate predicateWithBlock:^BOOL(EVLocationObject* object, NSDictionary *bindings) {
        if(object.iLocationType==Lid){
            return true;
        }
        return false;
    }];
    return pred;
}
[[array valueForKeyPath:@"@unionOfObjects.strLocationName"] componentsJoinedByString:@"@@"]
==================================================*/
/*=============== push notification ==============*/
/*==================================================
 
if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
#ifdef __IPHONE_8_0
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeAlert) categories:nil];
    [application registerUserNotificationSettings:settings];
#endif
} else {
    UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
    [application registerForRemoteNotificationTypes:myTypes];
}

#ifdef __IPHONE_8_0

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    //register to receive notifications
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler{
    //handle the actions
    if ([identifier isEqualToString:@"declineAction"]){
    }
    else if ([identifier isEqualToString:@"answerAction"]){
    }
}

#endif

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    [EVManager shareManager].strDeviceToken=[token copy];
    NSLog(@"%@",[EVManager shareManager].strDeviceToken);
}
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    
}
==================================================*/
/*=============== current location ===============*/
/*==================================================
-(void)CurrentLocation{
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
        if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
            [self.locationManager requestAlwaysAuthorization];
            //NSLocationAlwaysUsageDescription=would like to use your location
        }
    }
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];
    //------
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    [EVManager shareManager].location=[[locations objectAtIndex:0] copy];
}
==================================================*/
/*=================== add layer ==================*/
/*==================================================
CGMutablePathRef path = CGPathCreateMutable();
CGPathMoveToPoint(path, NULL, 0.0f, 0.0f);
CGPathAddLineToPoint(path, NULL, self.imgBg.frame.size.width, 0.0f);
CGPathAddLineToPoint(path, NULL, self.imgBg.frame.size.width, (self.imgBg.frame.size.height/2)-10);
CGPathAddArc(path,NULL,self.imgBg.frame.size.width, (self.imgBg.frame.size.height/2),10, -M_PI_2, M_PI_2,true);
CGPathAddLineToPoint(path, NULL, self.imgBg.frame.size.width, (self.imgBg.frame.size.height/2)+10);
CGPathAddLineToPoint(path, NULL, self.imgBg.frame.size.width, self.imgBg.frame.size.height);
CGPathAddLineToPoint(path, NULL, 0.0f, self.imgBg.frame.size.height);
CGPathAddLineToPoint(path, NULL, 0.0f, (self.imgBg.frame.size.height/2)+10);
CGPathAddArc(path,NULL,0.0f, (self.imgBg.frame.size.height/2),10, M_PI_2, -M_PI_2,true);
CGPathAddLineToPoint(path, NULL, 0.0f, (self.imgBg.frame.size.height/2)-10);
CGPathAddLineToPoint(path, NULL, 0.0, 0.0f);
CAShapeLayer *shapeLayer = [CAShapeLayer layer];
[shapeLayer setPath:path];
[shapeLayer setFillColor:[[UIColor blueColor] CGColor]];
[shapeLayer setAnchorPoint:CGPointMake(0.0f, 0.0f)];
[shapeLayer setPosition:CGPointMake(0.0f, 0.0f)];
self.imgBg.layer.mask = shapeLayer;
CGPathRelease(path);
==================================================*/
/*=============== collectionview =================*/
/*==================================================
UINib *cellNib = [UINib nibWithNibName:KEVServiceCollectionViewCell bundle:nil];
[[cellNib instantiateWithOwner:nil options:nil] objectAtIndex:0];
[self.collectionService registerClass:[EVServiceCollectionViewCell class] forCellWithReuseIdentifier:KEVServiceCollectionViewCell];

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView1 cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UINib *nib = [UINib nibWithNibName:KEVServiceCollectionViewCell bundle: nil];
    [collectionView1 registerNib:nib forCellWithReuseIdentifier:KEVServiceCollectionViewCell];
    
    EVServiceCollectionViewCell *cell=(EVServiceCollectionViewCell *)[collectionView1 dequeueReusableCellWithReuseIdentifier:KEVServiceCollectionViewCell forIndexPath:indexPath];
    return cell;
}
==================================================*/
/*============= Paypal intigaration ==============*/
/*==================================================
-(void)payPalinit:(float)amount{
    //AVWn5BBWQybvVhO_iW60tKxnus93v_Nk9rEcfCKozf27GB4XfGJfPAvS93XH;
    [PayPalMobile initializeWithClientIdsForEnvironments:@{PayPalEnvironmentSandbox : @"",PayPalEnvironmentSandbox : @""}];
    
    _payPalConfig = [[PayPalConfiguration alloc] init];
    _payPalConfig.acceptCreditCards=iPaymentType==3?NO:YES;
    _payPalConfig.languageOrLocale = @"en";
    _payPalConfig.merchantName = @"appname";
    _payPalConfig.merchantPrivacyPolicyURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/privacy-full"];
    _payPalConfig.merchantUserAgreementURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/useragreement-full"];
    _payPalConfig.languageOrLocale = [NSLocale preferredLanguages][0];
    _payPalConfig.payPalShippingAddressOption = PayPalShippingAddressOptionPayPal;
    _payPalConfig.rememberUser=NO;
    [self payNow:amount];
}
-(void)payNow:(float)amount1{
    
    NSString *amount=[NSString stringWithFormat:@"%0.2f",amount1];
    NSDecimalNumber *total = [[NSDecimalNumber alloc] initWithString:amount];
    PayPalPayment *paymentView = [[PayPalPayment alloc] init];
    paymentView.amount = total;
    paymentView.currencyCode = @"USD";
    paymentView.shortDescription = @"Products";
    
    if (!paymentView.processable) {
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Message",nil) message: NSLocalizedString(@"No amount available for pay", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok",nil) otherButtonTitles:nil];
        [alert show];
        alert=nil;
        
    }else{
        
        self.payPalConfig.acceptCreditCards =iPaymentType==3?NO:YES;
        PayPalPaymentViewController *paymentViewController = [[PayPalPaymentViewController alloc] initWithPayment:paymentView configuration:self.payPalConfig delegate:self];
        [self presentViewController:paymentViewController animated:YES completion:nil];
    }
}

#pragma mark PayPalPaymentDelegate methods

-(void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController didCompletePayment:(PayPalPayment *)completedPayment {
    //[self sendCompletedPaymentToServer:completedPayment];
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)payPalPaymentDidCancel:(PayPalPaymentViewController *)paymentViewController {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
==================================================*/
/*=================== gallery ====================*/
 /*=================================================

#pragma mark - MWPhotoBrowserDelegate

-(void)loadImageAtIndex:(NSInteger)index{
    
    NSMutableArray *photos = [[NSMutableArray alloc] init];
    NSMutableArray *thumbs = [[NSMutableArray alloc] init];
    BOOL displayActionButton = NO;
    BOOL displaySelectionButtons = NO;
    BOOL displayNavArrows = NO;
    BOOL enableGrid = NO;
    BOOL startOnGrid = NO;
    
    for (int i=0;i<arrayImages.count;i++) {
        
        [photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:[[arrayImages objectAtIndex:i] objectForKey:@"p_product_multi_image"]]]];
        [thumbs addObject:[MWPhoto photoWithURL:[NSURL URLWithString:[[arrayImages objectAtIndex:i] objectForKey:@"p_product_multi_image"]]]];
    }
    
    if (arrayImages.count==0) {
        
        [photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:[self.dictPrevious objectForKey:@"p_product_image"]]]];
        [thumbs addObject:[MWPhoto photoWithURL:[NSURL URLWithString:[self.dictPrevious objectForKey:@"p_product_image"]]]];
    }
    
    self.photos = photos;
    self.thumbs = thumbs;
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = displayActionButton;
    browser.displayNavArrows = displayNavArrows;
    browser.displaySelectionButtons = displaySelectionButtons;
    browser.alwaysShowControls = displaySelectionButtons;
    browser.zoomPhotosToFill = YES;
    browser.view.backgroundColor=UIColorFromRGBWithAlpha(0X0f8241,1.0);
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
    browser.wantsFullScreenLayout = YES;
#endif
    browser.enableGrid = enableGrid;
    browser.startOnGrid = startOnGrid;
    browser.enableSwipeToDismiss = YES;
    [browser setCurrentPhotoIndex:selectedImage];
    
    // Reset selections
    if (displaySelectionButtons) {
        _selections = [NSMutableArray new];
        for (int i = 0; i < photos.count; i++) {
            [_selections addObject:[NSNumber numberWithBool:NO]];
        }
    }
    [self.navigationController pushViewController:browser animated:YES];
}
-(NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _photos.count;
}
-(id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
}
-(id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index {
    if (index < _thumbs.count)
        return [_thumbs objectAtIndex:index];
    return nil;
}
-(void)photoBrowser:(MWPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index {
    NSLog(@"Did start viewing photo at index %lu", (unsigned long)index);
}
-(BOOL)photoBrowser:(MWPhotoBrowser *)photoBrowser isPhotoSelectedAtIndex:(NSUInteger)index {
    return [[_selections objectAtIndex:index] boolValue];
}
-(void)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index selectedChanged:(BOOL)selected {
    [_selections replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:selected]];
    NSLog(@"Photo at index %lu selected %@", (unsigned long)index, selected ? @"YES" : @"NO");
}
-(void)photoBrowserDidFinishModalPresentation:(MWPhotoBrowser *)photoBrowser {
    // If we subscribe to this method we must dismiss the view controller ourselves
    NSLog(@"Did finish modal presentation");
    [self dismissViewControllerAnimated:YES completion:nil];
}
*//*-(MWCaptionView *)photoBrowser:(MWPhotoBrowser *)photoBrowser captionViewForPhotoAtIndex:(NSUInteger)index {
 MWPhoto *photo = [self.photos objectAtIndex:index];
 MWCaptionView *captionView = [[MWCaptionView alloc] initWithPhoto:photo];
 return [captionView autorelease];
 }
 -(void)photoBrowser:(MWPhotoBrowser *)photoBrowser actionButtonPressedForPhotoAtIndex:(NSUInteger)index {
 NSLog(@"ACTION!");
 }
 -(NSString *)photoBrowser:(MWPhotoBrowser *)photoBrowser titleForPhotoAtIndex:(NSUInteger)index {
 return [NSString stringWithFormat:@"Photo %lu", (unsigned long)index+1];
 }
==================================================*/

