//
//  UIImage+YTXUtilCategory.m
//  Pods
//
//  Created by CaoJun on 16/2/16.
//
//

#import "UIImage+YTXUtilCategory.h"

@implementation UIImage (YTXUtilCategory)

+ (nonnull UIImage *)originalImageNamed:(nonnull NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}


//https://github.com/Grouper/FlatUIKit

static CGFloat edgeSizeFromCornerRadius(CGFloat cornerRadius) {
    return cornerRadius * 2 + 1;
}

+ (nonnull UIImage *)imageWithColor:(nonnull UIColor *)color
{
    return [UIImage imageWithColor:color cornerRadius:0];
}

+ (nonnull UIImage *)imageWithColor:(nonnull UIColor *)color
               cornerRadius:(CGFloat)cornerRadius {
    CGFloat minEdgeSize = edgeSizeFromCornerRadius(cornerRadius);
    CGRect rect = CGRectMake(0, 0, minEdgeSize, minEdgeSize);
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
    roundedRect.lineWidth = 0;
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0f);
    [color setFill];
    [roundedRect fill];
    [roundedRect stroke];
    [roundedRect addClip];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(cornerRadius, cornerRadius, cornerRadius, cornerRadius)];
}


+ (nonnull UIImage *)circularImageWithColor:(nonnull UIColor *)color
                               size:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIBezierPath *circle = [UIBezierPath bezierPathWithOvalInRect:rect];
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0f);
    [color setFill];
    [color setStroke];
    [circle addClip];
    [circle fill];
    [circle stroke];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


+ (nonnull UIImage *)buttonImageWithColor:(nonnull UIColor *)color cornerRadius:(CGFloat)cornerRadius
{
    UIColor *shadowColor = [UIColor clearColor];
    UIEdgeInsets shadowInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    UIImage *topImage = [UIImage imageWithColor:color cornerRadius:cornerRadius];
    UIImage *bottomImage = [UIImage imageWithColor:shadowColor cornerRadius:cornerRadius];
    CGFloat totalHeight = edgeSizeFromCornerRadius(cornerRadius) + shadowInsets.top + shadowInsets.bottom;
    CGFloat totalWidth = edgeSizeFromCornerRadius(cornerRadius) + shadowInsets.left + shadowInsets.right;
    CGFloat topWidth = edgeSizeFromCornerRadius(cornerRadius);
    CGFloat topHeight = edgeSizeFromCornerRadius(cornerRadius);
    CGRect topRect = CGRectMake(shadowInsets.left, shadowInsets.top, topWidth, topHeight);
    CGRect bottomRect = CGRectMake(0, 0, totalWidth, totalHeight);
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(totalWidth, totalHeight), NO, 0.0f);
    if (!CGRectEqualToRect(bottomRect, topRect)) {
        [bottomImage drawInRect:bottomRect];
    }
    [topImage drawInRect:topRect];
    UIImage *buttonImage = UIGraphicsGetImageFromCurrentImageContext();
    UIEdgeInsets resizeableInsets = UIEdgeInsetsMake(cornerRadius + shadowInsets.top,
                                                     cornerRadius + shadowInsets.left,
                                                     cornerRadius + shadowInsets.bottom,
                                                     cornerRadius + shadowInsets.right);
    UIGraphicsEndImageContext();
    return [buttonImage resizableImageWithCapInsets:resizeableInsets];
    
}

@end
