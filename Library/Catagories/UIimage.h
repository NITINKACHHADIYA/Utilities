
#import <UIKit/UIKit.h>

@interface UIImage (MDQRCode)

-(UIImage *)mdQRCodeForString:(NSString *)qrString size:(CGFloat)size;
-(UIImage *)mdQRCodeForString:(NSString *)qrString size:(CGFloat)size fillColor:(UIColor *)fillColor;

-(UIImage *)resizeImageWithNewSize:(CGSize)newSize;
+(UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize :(UIImage *)srcimage;

@end
