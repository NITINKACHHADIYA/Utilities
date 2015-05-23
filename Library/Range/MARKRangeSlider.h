@import UIKit;

@interface MARKRangeSlider : UIControl

// Values
@property (nonatomic, assign) CGFloat minimumValue;
@property (nonatomic, assign) CGFloat maximumValue;

@property (nonatomic, assign) CGFloat leftValue;
@property (nonatomic, assign) CGFloat rightValue;

@property (nonatomic, assign) CGFloat minimumDistance;

// Images
@property (nonatomic,retain) UIImage *trackImage;
@property (nonatomic,retain) UIImage *rangeImage;

@property (nonatomic,retain) UIImage *leftThumbImage;
@property (nonatomic,retain) UIImage *rightThumbImage;

@end
