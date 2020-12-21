//
//  ViewController.h
//  IndustrialBankSafariWidget
//
//  Created by 张文洁 on 2020/12/16.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController

@property (weak, nonatomic) IBOutlet NSTextField *appNameLabel;

- (IBAction)openSafariExtensionPreferences:(id)sender;

@end

