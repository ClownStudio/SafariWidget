//
//  ViewController.m
//  IndustrialBankSafariWidget
//
//  Created by 张文洁 on 2020/12/16.
//

#import "ViewController.h"
#import <SafariServices/SFSafariApplication.h>
#import <SafariServices/SFSafariExtensionManager.h>
#import <SafariServices/SFSafariExtensionState.h>
#import "SecurityUtil.h"
#import "CCMCryptorTest.h"

static NSString * const appName = @"IndustrialBankSafariWidget";
static NSString * const extensionBundleIdentifier = @"com.JamStudio.IndustrialBankSafariWidget.Extension";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.appNameLabel.stringValue = appName;
    
    [self test];
    
    [SFSafariExtensionManager getStateOfSafariExtensionWithIdentifier:extensionBundleIdentifier completionHandler:^(SFSafariExtensionState * _Nullable state, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!state) {
                // Insert code to inform the user something went wrong.
                return;
            }

            if (state.isEnabled)
                self.appNameLabel.stringValue = [NSString stringWithFormat:@"%@'s extension is currently on.", appName];
            else
                self.appNameLabel.stringValue = [NSString stringWithFormat:@"%@'s extension is currently off. You can turn it on in Safari Extensions preferences.", appName];
        });
    }];
}

- (void)test{
    CCMCryptorTest *test = [[CCMCryptorTest alloc] init];
    CCMPublicKey *publicKey = [test loadPublicKeyResource:@"rsa_public_key"];
    CCMPrivateKey *privateKey = [test loadPrivateKeyResource:@"rsa_private_key"];
    CCMCryptor *cryptor = [[CCMCryptor alloc] init];
    NSError *error;
    
    NSData *inputData = [@"666" dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encryptedData ;
    NSString *encryptedStr;
    NSData *decryptedData;
    NSString *output;
    
    // rsa 加密 with public key
    encryptedData = [cryptor encryptData:inputData withPublicKey:publicKey error:&error];
    encryptedStr = [CCMBase64 base64StringFromData:encryptedData];
    NSLog(@"%@ ", encryptedStr);
    
    // rsa 解密 with private key
    decryptedData = [cryptor decryptData:encryptedData withPrivateKey:privateKey error:&error];
    output = [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
    NSLog(@"%@ ", output);
}

- (IBAction)openSafariExtensionPreferences:(id)sender {
    [SFSafariApplication showPreferencesForExtensionWithIdentifier:extensionBundleIdentifier completionHandler:^(NSError * _Nullable error) {
        if (error) {
            // Insert code to inform the user something went wrong.
            return;
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            [NSApplication.sharedApplication terminate:nil];
        });
    }];
}

@end
