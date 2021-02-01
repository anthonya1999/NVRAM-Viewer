//
//  ViewController.h
//  NVRAM Viewer
//
//  Created by Anthony Agatiello on 1/28/21.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController

@property (strong, nonatomic) IBOutlet NSPopUpButton *choicesDropdown;
@property (strong, nonatomic) IBOutlet NSTextField *resultLabel;
@property (strong, nonatomic) IBOutlet NSTextField *customTextField;
@property (strong, nonatomic) IBOutlet NSButton *goButton;

@end
