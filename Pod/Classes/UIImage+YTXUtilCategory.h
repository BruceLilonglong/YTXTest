//
//  UIImage+YTXUtilCategory.h
//  Pods
//
//  Created by CaoJun on 16/2/16.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (YTXUtilCategory)

+ (nonnull UIImage *)originalImageNamed: (nonnull NSString *)name;

+ (nonnull UIImage *)imageWithColor:(nonnull UIColor *)color;

+ (nonnull UIImage *)imageWithColor:(nonnull UIColor *)color cornerRadius:(CGFloat)cornerRadius;

+ (nonnull UIImage *)circularImageWithColor:(nonnull UIColor *)color size:(CGSize)size;

+ (nonnull UIImage *)buttonImageWithColor:(nonnull UIColor *)color cornerRadius:(CGFloat)cornerRadius;

@end
