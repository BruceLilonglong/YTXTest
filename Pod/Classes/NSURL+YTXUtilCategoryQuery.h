//
//  NSURL+YTXUtilCategoryQuery.h
//  p4
//
//  Created by CaoJun on 16/2/16.
//  Copyright © 2016年 Elephants Financial Service. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (YTXUtilCategoryQuery)

- (nonnull NSDictionary*) queryDictionary;

- (nonnull NSURL *) URLByAppendingQueryDictionary:(nonnull NSDictionary*) queryDictionary
                             withSortedKeys:(BOOL) sortedKeys;

- (nonnull NSURL *) URLByAppendingQueryDictionary:(nonnull NSDictionary*) queryDictionary;

@end


@interface NSString (URLQuery)

- (nullable NSDictionary*) URLQueryDictionary;

@end

@interface NSDictionary (URLQuery)

- (nullable NSString*) URLQueryStringWithSortedKeys:(BOOL) sortedKeys;

- (nonnull NSString*) URLQueryString;

@end
