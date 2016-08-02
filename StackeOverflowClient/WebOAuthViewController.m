//
//  WebOAuthViewController.m
//  StackeOverflowClient
//
//  Created by Michael Sweeney on 8/1/16.
//  Copyright © 2016 Michael Sweeney. All rights reserved.
//

#import "WebOAuthViewController.h"
@import WebKit;
@import Security;

NSString const *kBaseURL = @"https://stackexchange.com/oauth/dialog";
NSString const *kRedirectURI = @"https://stackexchange.com/oauth/login_success";
NSString const *kClientID = @"7592";
//NSString const *kAccessTokenKey = @"";




@interface WebOAuthViewController () <WKNavigationDelegate>

@end

@implementation WebOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    WKWebView *webView = [[WKWebView alloc]init];
    webView.frame = self.view.frame;
    [self.view addSubview:webView];
    
    webView.navigationDelegate = self;
    
    NSString *finalURL = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@", kBaseURL, kClientID, kRedirectURI];
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:finalURL]]];
}

-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    if ([navigationAction.request.URL.path isEqualToString:@"/oauth/login_success"]) {
        NSString *fragmentString = navigationAction.request.URL.fragment;
        NSArray *components = [fragmentString componentsSeparatedByString:@"&"];
        NSString *fullTokenParameter = components.firstObject;
        NSString *token = [fullTokenParameter componentsSeparatedByString:@"="].lastObject;
        
        
        //TODO: keychain saving
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:token forKey:@"token"];
        [defaults synchronize];
        
        
        //
//        NSData *secret = [token dataUsingEncoding:NSUTF8StringEncoding];
        
//        NSDictionary *query = @{
//                                (id)kSecClass: (id)kSecClassGenericPassword,
//                                (id)kSecAttrService: @"StackOverflowClient",
//                                (id)kSecValueData: secret
//                                };
//        
        
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
        
        
    }
    
    decisionHandler(WKNavigationActionPolicyAllow);
    
}

//- (BOOL) saveToKeyChain:(NSString *)token{
//    NSDictionary *keychainDict = @{
//                                   (__bridge id)kSecClass : (__bridge id)kSecClassGenericPassword,
//                                   (__bridge id)kSecAttrService : kAccessTokenKey,
//                                   (__bridge id)kSecAttrAccount : kAccessTokenKey,
//                                   (__bridge id)kSecAttrAccessible : (__bridge id)kSecAttrAccessibleAfterFirstUnlock,
//                                   (__bridge id)kSecValueData : [NSKeyedArchiver archivedDataWithRootObject:token]
//                                   
//                                   };
//    
//    
//    SecItemDelete( (__bridge CFDictionaryRef)keychainDict);
//    NSLog(@"adding to keychain: %@", token);
//    
//    return SecItemAdd((__bridge CFDictionaryRef)keychainDict, nil);
//    
//}


@end
