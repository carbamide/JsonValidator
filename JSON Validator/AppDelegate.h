//
//  AppDelegate.h
//  JSON Validator
//
//  Created by Josh on 1/23/13.
//  Copyright (c) 2013 Jukaela Enterprises. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (strong) IBOutlet NSTextView *textView;
@property (strong) IBOutlet NSButton *validateButton;
@property (strong) IBOutlet NSButton *formatButton;
@property (strong) IBOutlet NSTextField *validLabel;

-(IBAction)validate:(id)sender;
-(IBAction)format:(id)sender;

@end
