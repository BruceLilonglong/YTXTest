//
//  NSURL+YTXUtilCategoryQuery.m
//  p4
//
//  Created by CaoJun on 16/2/16.
//  Copyright © 2016年 Elephants Financial Service. All rights reserved.
//

#import "NSURL+YTXUtilCategoryQuery.h"

NSString *const _Nonnull uq_URLReservedChars     = @"￼=,!$&'()*+;@?\r\n\"<>#\t :/";
NSString *const _Nonnull kQuerySeparator  = @"&";
NSString *const _Nonnull kQueryDivider    = @"=";
NSString *const _Nonnull kQueryBegin      = @"?";
NSString *const _Nonnull kFragmentBegin   = @"#";

@implementation NSURL (YTXUtilCategoryQuery)

- (nonnull NSDictionary*)queryDictionary
{
    return self.query.URLQueryDictionary;
}

- (nonnull NSURL*)URLByAppendingQueryDictionary:(nonnull NSDictionary*) queryDictionary
{
    return [self URLByAppendingQueryDictionary:queryDictionary withSortedKeys:NO];
}

- (nonnull NSURL *)URLByAppendingQueryDictionary:(nonnull NSDictionary *)queryDictionary
                             withSortedKeys:(BOOL)sortedKeys
{
    NSMutableArray *queries = [self.query length] > 0 ? @[self.query].mutableCopy : @[].mutableCopy;
    NSString *dictionaryQuery = [queryDictionary URLQueryStringWithSortedKeys:sortedKeys];
    if (dictionaryQuery) {
        [queries addObject:dictionaryQuery];
    }
    NSString *newQuery = [queries componentsJoinedByString:kQuerySeparator];
    
    if (newQuery.length) {
        NSArray *queryComponents = [self.absoluteString componentsSeparatedByString:kQueryBegin];
        if (queryComponents.count) {
            return [NSURL URLWithString:
                    [NSString stringWithFormat:@"%@%@%@%@%@",
                     queryComponents[0],                      // existing url
                     kQueryBegin,
                     newQuery,
                     self.fragment.length ? kFragmentBegin : @"",
                     self.fragment.length ? self.fragment : @""]];
        }
    }
    return self;
}

@end

#pragma mark -

@implementation NSString (URLQuery)

- (nullable NSDictionary*) URLQueryDictionary {
    NSMutableDictionary *mute = @{}.mutableCopy;
    for (NSString *query in [self componentsSeparatedByString:kQuerySeparator]) {
        NSArray *components = [query componentsSeparatedByString:kQueryDivider];
        if (components.count == 0) {
            continue;
        }
        NSString *key = [components[0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        id value = nil;
        if (components.count == 1) {
            // key with no value
            value = [NSNull null];
        }
        if (components.count == 2) {
            value = [components[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            // cover case where there is a separator, but no actual value
            value = [value length] ? value : [NSNull null];
        }
        if (components.count > 2) {
            // invalid - ignore this pair. is this best, though?
            continue;
        }
        mute[key] = value ?: [NSNull null];
    }
    return mute.count ? mute.copy : nil;
}

@end


@implementation NSDictionary (URLQuery)

static inline NSString * _Nonnull URLEscape(NSString *string);

- (nonnull NSString *)URLQueryString {
    return [self URLQueryStringWithSortedKeys:NO];
}

- (nullable NSString*)URLQueryStringWithSortedKeys:(BOOL)sortedKeys
{
    NSMutableString *queryString = @"".mutableCopy;
    NSArray *keys = sortedKeys ? [self.allKeys sortedArrayUsingSelector:@selector(compare:)] : self.allKeys;
    for (NSString *key in keys) {
        id rawValue = self[key];
        NSString *value = nil;
        // beware of empty or null
        if (!(rawValue == [NSNull null] || ![rawValue description].length)) {
            value = URLEscape([self[key] description]);
        }
        [queryString appendFormat:@"%@%@%@%@",
         queryString.length ? kQuerySeparator : @"",    // appending?
         URLEscape(key),
         value ? kQueryDivider : @"",
         value ? value : @""];
    }
    return queryString.length ? queryString.copy : nil;
}

static inline NSString * _Nonnull URLEscape(NSString *string) {
    return ((__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                                  NULL,
                                                                                  (__bridge CFStringRef)string,
                                                                                  NULL,
                                                                                  (__bridge CFStringRef)uq_URLReservedChars,
                                                                                  kCFStringEncodingUTF8));
}

@end
