//
//  ViewController.h
//  JSON Validator
//
//  Created by Josh Barrow on 2/4/13.
//  Copyright (c) 2013 Jukaela Enterprises. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/**
 The main 'NSViewController' that controls the view of the main NSWindow
 */
@interface ViewController : NSViewController

///---------------------------------------
/// @name Properties
///---------------------------------------

/**
 The 'NSTextView' that will accept pasted text and convert it to formatted JSON or validate said JSON.
 */
@property (strong) IBOutlet NSTextView *textView;

/**
 The validate button
 */
@property (strong) IBOutlet NSButton *validateButton;

/**
 The format button
 */
@property (strong) IBOutlet NSButton *formatButton;

/**
 'NSTextField' that shows the current status.
 */
@property (strong) IBOutlet NSTextField *validLabel;

///---------------------------------------
/// @name Methods
///---------------------------------------

/**
 IBAction that begins validation of the text of 'textView'
 @param sender The caller
 */
-(IBAction)validate:(id)sender;

/**
 IBAction that begins formatting of the text of 'textView'
 @param sender The caller
 */
-(IBAction)format:(id)sender;

/**
 IBAction that unescapes the text of the 'textView'
 @param sender The caller
 */
-(IBAction)unescape:(id)sender;

@end
