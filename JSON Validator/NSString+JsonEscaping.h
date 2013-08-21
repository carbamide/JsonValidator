//
//  NSString+JsonEscaping.h
//  JSON Validator
//
//  Created by Joshua Barrow on 8/9/13.
//  Copyright (c) 2013 Jukaela Enterprises. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 'NSString+JsonEscaping' is a catagory on NSString that allows unescaping of JSON contained in an 'NSString'
 */
@interface NSString (JsonEscaping)

/**
 Converts escaped JSON within an 'NSString' to unescaped JSON
 @param jsonString The 'NSString' that contained the escaped JSON
 @return The unescaped JSON
 */
+ (NSString *)stringWithJSONString:(NSString *)jsonString;

/**
 Converts all nulls and bools in JSON in an 'NSString' to equivalents in 'NSString' format
 @param jsonString The 'NSString' that contains nulls or bools
 @return The original 'NSString' with nulls and bools converted to JSON equivalent
 */
+ (NSString *)convertNullsAndBoolsForString:(NSString *)jsonString;

@end
