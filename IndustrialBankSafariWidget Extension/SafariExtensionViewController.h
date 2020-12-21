//
//  SafariExtensionViewController.h
//  IndustrialBankSafariWidget Extension
//
//  Created by 张文洁 on 2020/12/16.
//

#import <SafariServices/SafariServices.h>

@interface SafariExtensionViewController : SFSafariExtensionViewController

+ (SafariExtensionViewController *)sharedController;

@end
