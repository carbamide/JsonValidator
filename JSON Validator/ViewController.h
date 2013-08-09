//
//  ViewController.h
//  JSON Validator
//
//  Created by Josh Barrow on 2/4/13.
//  Copyright (c) 2013 Jukaela Enterprises. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController

@property (strong) IBOutlet NSTextView *textView;
@property (strong) IBOutlet NSButton *validateButton;
@property (strong) IBOutlet NSButton *formatButton;
@property (strong) IBOutlet NSTextField *validLabel;

-(IBAction)validate:(id)sender;
-(IBAction)format:(id)sender;
-(IBAction)unescape:(id)sender;

@end
