//
//  SafariExtensionViewController.m
//  IndustrialBankSafariWidget Extension
//
//  Created by 张文洁 on 2020/12/16.
//

#import "SafariExtensionViewController.h"

@interface SafariExtensionViewController ()

@end

@implementation SafariExtensionViewController

+ (SafariExtensionViewController *)sharedController {
    static SafariExtensionViewController *sharedController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedController = [[SafariExtensionViewController alloc] init];
        sharedController.preferredContentSize = NSMakeSize(320, 240);
    });
    return sharedController;
}

@end
