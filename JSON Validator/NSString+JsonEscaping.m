//
//  NSString+JsonEscaping.m
//  JSON Validator
//
//  Created by Joshua Barrow on 8/9/13.
//  Copyright (c) 2013 Jukaela Enterprises. All rights reserved.
//

#import "NSString+JsonEscaping.h"

@implementation NSString (JsonEscaping)

+ (NSString *)stringWithJSONString:(NSString *)jsonString
{
    NSUInteger len = [jsonString length];
    
    if (len < 2 || [jsonString characterAtIndex:0] != '"' || [jsonString characterAtIndex:(len - 1)] != '"') {
        NSLog(@"%s: string does not begin and end with \" characters", __PRETTY_FUNCTION__);
        
        return nil;
    }
    
    NSMutableString *result = [[NSMutableString alloc] initWithCapacity:(len-2)];
    
    NSUInteger limit = len - 1;
    
    for (NSUInteger i = 1; i < limit; ++i) {
        unichar character = [jsonString characterAtIndex:i];
        
        if (character == '\\') {
            if (i == limit - 1) {
                NSLog(@"%s: JSON string cannot end with single backslash", __PRETTY_FUNCTION__);
                
                return nil;
            }
            
            ++i;
            unichar nextCharacter = [jsonString characterAtIndex:i];
            switch (nextCharacter) {
                case 'b':
                    [result appendString:@"\b"];
                    
                    break;
                    
                case 'f':
                    [result appendString:@"\f"];
                    
                    break;
                    
                case 'n':
                    [result appendString:@"\n"];
                    
                    break;
                    
                case 'r':
                    [result appendString:@"\r"];
                    
                    break;
                    
                case 't':
                    [result appendString:@"\t"];
                    
                    break;
                    
                case 'u':
                    if ((i + 4) >= limit) {
                        NSLog(@"%s: insufficient characters remaining after \\u in JSON string", __PRETTY_FUNCTION__);
                        
                        return nil;
                    }
                {
                    NSString *hexdigits = [jsonString substringWithRange:NSMakeRange(i + 1, 4)];
                    
                    i += 4;
                    
                    NSScanner *scanner = [NSScanner scannerWithString:hexdigits];
                    
                    unsigned int hexValue = 0;
                    
                    if (![scanner scanHexInt:&hexValue]) {
                        NSLog(@"%s: invalid hex digits following \\u", __PRETTY_FUNCTION__);
                    }
                    
                    [result appendFormat:@"%C", (unichar)hexValue];
                }
                    break;
                    
                default:
                    [result appendFormat:@"%C", nextCharacter];
                    
                    break;
            }
        }
        else {
            [result appendFormat:@"%C", character];
        }
    }
    
    // Return an immutable copy
    return [NSString stringWithString:result];
}

+(NSString *)convertNullsAndBoolsForString:(NSString *)jsonString
{
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"null" withString:@"\"<null>\""];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"true" withString:@"1"];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"false" withString:@"0"];
    
    return jsonString;
}

@end
