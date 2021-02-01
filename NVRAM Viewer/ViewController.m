//
//  ViewController.m
//  NVRAM Viewer
//
//  Created by Anthony Agatiello on 1/28/21.
//

#import "ViewController.h"
#import "NVRAMController.h"

@implementation ViewController

- (void)configureDropdown {
    [self.choicesDropdown removeAllItems];
    NSArray <NSString *> *dropdownTitles = @[@"36C28AB5-6566-4C50-9EBD-CBB920F83843:current-network", @"36C28AB5-6566-4C50-9EBD-CBB920F83843:preferred-networks", @"Custom"];
    [self.choicesDropdown addItemsWithTitles:dropdownTitles];
}

- (void)hideOrShowCustomElements {
    BOOL isCustom = ![self.choicesDropdown.selectedItem.title isEqualToString:@"Custom"];
    [self.customTextField setHidden:isCustom];
    [self.goButton setHidden:isCustom];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureDropdown];
    [self popupSelectionDidChange:nil];
    [self hideOrShowCustomElements];
}

- (IBAction)popupSelectionDidChange:(NSPopUpButton *)button {
    NSString *title = self.choicesDropdown.selectedItem.title;
    [self hideOrShowCustomElements];
    
    if ([self.choicesDropdown.selectedItem.title isEqualToString:@"Custom"]) {
        // Handle this with the "Go" button instead
        return;
    }
    
    id nvramResult = [NVRAMController getNVRAMVariable:title];
    NSString *resultString = [NVRAMController bytesToString:nvramResult];
    [self.resultLabel setStringValue:resultString];
}

- (IBAction)goPushed:(NSButton *)button {
    id nvramResult = [NVRAMController getNVRAMVariable:self.customTextField.stringValue];
    NSString *resultString = [NVRAMController bytesToString:nvramResult];
    [self.resultLabel setStringValue:resultString];
}

@end
