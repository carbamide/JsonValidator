//
//  AppDelegate.m
//  JSON Validator
//
//  Created by Josh on 1/23/13.
//  Copyright (c) 2013 Jukaela Enterprises. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
@property (nonatomic) BOOL validated;

@end
@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    
}

-(IBAction)validate:(id)sender
{
    NSData *tempData = [[[self textView] string] dataUsingEncoding:NSUTF8StringEncoding];
    
    if ([NSJSONSerialization JSONObjectWithData:tempData options:0 error:nil]) {
        [[self validLabel] setStringValue:@"Valid"];
        [[self validLabel] setTextColor:[NSColor greenColor]];
    }
    else {
        [[self validLabel] setStringValue:@"Invalid"];
        [[self validLabel] setTextColor:[NSColor redColor]];
    }
}

-(IBAction)format:(id)sender
{
    NSData *tempData = [[[self textView] string] dataUsingEncoding:NSUTF8StringEncoding];
    
    BOOL unabledToValidate = YES;
    
    if (tempData) {
        id jsonData = [NSJSONSerialization JSONObjectWithData:tempData options:0 error:nil];
        if (jsonData) {
            NSData *jsonHolder = [NSJSONSerialization dataWithJSONObject:jsonData options:NSJSONWritingPrettyPrinted error:nil];
            if (jsonHolder) {
                [[self textView] setString:[[NSString alloc] initWithData:jsonHolder encoding:NSUTF8StringEncoding]];
                
                [[self validLabel] setStringValue:@"Valid"];
                [[self validLabel] setTextColor:[NSColor greenColor]];
                
                unabledToValidate = NO;
            }
        }
    }
    
    if (unabledToValidate == YES) {
        [[self validLabel] setStringValue:@"Invalid"];
        [[self validLabel] setTextColor:[NSColor redColor]];
    }
}

@end
