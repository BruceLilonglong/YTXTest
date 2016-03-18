//
//  NSArray+YTXUtilCategory.m
//  EFSMobile
//
//  Created by CaoJun on 16/2/16.
//  Copyright © 2016年 Elephants Financial Service. All rights reserved.
//

#import "NSArray+YTXUtilCategory.h"

@implementation NSArray (YTXUtilCategory)

- (nonnull NSString *) toJSONString
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:kNilOptions
                                                         error:&error];
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData
                                              encoding:NSUTF8StringEncoding];
    return  jsonStr;
}

@end
