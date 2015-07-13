//
//  ViewController.m
//  JSON Validator
//
//  Created by Josh Barrow on 2/4/13.
//  Copyright (c) 2013 Jukaela Enterprises. All rights reserved.
//

#import "ViewController.h"
#import "NSString+JsonEscaping.h"
#import "AppDelegate.h"

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

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [[self textView] setRichText:NO];
    [[self textView] setAutomaticQuoteSubstitutionEnabled:NO];
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
        AppDelegate *delegate = [[NSApplication sharedApplication] delegate];
        
        NSAlert *alert = [NSAlert alertWithError:error];
        [alert beginSheetModalForWindow:[delegate window] completionHandler:nil];
        
        NSLog(@"There was an error formatting and validating the json - %@\n", [error localizedDescription]);
    }
}

-(IBAction)format:(id)sender
{
    NSString *stringToFormat = [NSString convertNullsAndBoolsForString:[[self textView] string]];
    
    NSError *error = nil;
    
    NSData *tempData = [stringToFormat dataUsingEncoding:NSUTF8StringEncoding];
    
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
        AppDelegate *delegate = [[NSApplication sharedApplication] delegate];
        
        NSAlert *alert = [NSAlert alertWithError:error];
        [alert beginSheetModalForWindow:[delegate window] completionHandler:nil];
        
        NSLog(@"There was an error formatting and validating the json - %@\n", [error localizedDescription]);
    }
    
    if (unabledToValidate) {
        [[self validLabel] setStringValue:@"Invalid"];
        [[self validLabel] setTextColor:[NSColor redColor]];
    }
}

-(IBAction)unescape:(id)sender
{
    NSString *escapedString = [[self textView] string];
    
    NSString *unescapedString = [NSString stringWithJSONString:escapedString];
    
    if (!unescapedString) {
        AppDelegate *delegate = [[NSApplication sharedApplication] delegate];

        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:@"An error occurred."];
        [alert setInformativeText:@"Unable to unescape the JSON.  An error occurred."];
        [alert beginSheetModalForWindow:[delegate window] completionHandler:nil];
        
        [[self validLabel] setStringValue:@"Error"];
        [[self validLabel] setTextColor:[NSColor redColor]];
        
        return;
    }
    
    [[self validLabel] setStringValue:@"Unescaped"];
    [[self validLabel] setTextColor:[NSColor greenColor]];
    
    [[self textView] setString:unescapedString];
}

@end
