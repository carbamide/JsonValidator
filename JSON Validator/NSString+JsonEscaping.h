//
//  NSString+JsonEscaping.h
//  JSON Validator
//
//  Created by Joshua Barrow on 8/9/13.
//  Copyright (c) 2013 Jukaela Enterprises. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JsonEscaping)

+ (NSString *)stringWithJSONString:(NSString *)jsonString;
+ (NSString *)convertNullsAndBoolsForString:(NSString *)jsonString;

@end
