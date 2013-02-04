//
//  ViewController.m
//  JSON Validator
//
//  Created by Josh Barrow on 2/4/13.
//  Copyright (c) 2013 Jukaela Enterprises. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSLog(@"Initializing self (ViewController)");
    }
    
    return self;
}

-(IBAction)validate:(id)sender
{
    NSError *error = nil;

    NSData *tempData = [[[self textView] string] dataUsingEncoding:NSUTF8StringEncoding];
    
    if ([NSJSONSerialization JSONObjectWithData:tempData options:0 error:&error]) {
        [[self validLabel] setStringValue:@"Valid"];
        [[self validLabel] setTextColor:[NSColor greenColor]];
    }
    else {
        [[self validLabel] setStringValue:@"Invalid"];
        [[self validLabel] setTextColor:[NSColor redColor]];
    }
    
    if (error) {
        NSLog(@"There was an error formatting and validating the json - %@\n", [error localizedDescription]);
    }
}

-(IBAction)format:(id)sender
{
    NSError *error = nil;
    
    NSData *tempData = [[[self textView] string] dataUsingEncoding:NSUTF8StringEncoding];
    
    BOOL unabledToValidate = YES;
    
    if (tempData) {
        id jsonData = [NSJSONSerialization JSONObjectWithData:tempData options:0 error:&error];
        
        if (jsonData) {
            NSData *jsonHolder = [NSJSONSerialization dataWithJSONObject:jsonData options:NSJSONWritingPrettyPrinted error:&error];
            
            if (jsonHolder) {
                [[self textView] setString:[[NSString alloc] initWithData:jsonHolder encoding:NSUTF8StringEncoding]];
                
                [[self validLabel] setStringValue:@"Valid"];
                [[self validLabel] setTextColor:[NSColor greenColor]];
                
                unabledToValidate = NO;
            }
        }
    }
    
    if (error) {
        NSLog(@"There was an error formatting and validating the json - %@\n", [error localizedDescription]);
    }
    
    if (unabledToValidate) {
        [[self validLabel] setStringValue:@"Invalid"];
        [[self validLabel] setTextColor:[NSColor redColor]];
    }
}

@end
