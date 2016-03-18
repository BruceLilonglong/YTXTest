//
//  UITextView+Placeholder.h
//  Pods
//
//  Created by 李龙龙 on 16/3/9.
//
//

#import <UIKit/UIKit.h>

@interface UITextView (Placeholder)

+ (NSString *)test;
+ (NSString *)test1;

@property (nonatomic, readonly) UILabel *placeholderLabel;

@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) NSAttributedString *attributedPlaceholder;
@property (nonatomic, strong) UIColor *placeholderColor;

+ (UIColor *)defaultPlaceholderColor;

@end
