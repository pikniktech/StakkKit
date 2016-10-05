//
//  SFViewController.m
//  StakkKit
//
//  Created by Derek on 09/27/2016.
//  Copyright (c) 2016 Derek. All rights reserved.
//

#import "SFViewController.h"

// StakkKit
#import "StakkKit.h"

@interface SFViewController ()

@end

@implementation SFViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
//    [self setupLogging];
//    [self setupDatabaseManager];
//    [self makeSampleRequest];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginFacebookComplete:) name:@"kLoginFacebookCompletedNotification" object:nil];
    
}

#pragma mark - Helpers

- (void)setupLogging {
    
    [SFLoggingManager setupWithLevel:SFLogLevelDebug];
//    SFLogError(@"Error Log");
//    SFLogDB(@"DB Log");
//    SFLogAPI(@"API Log");
//    SFLogDebug(@"Debug Log");
}

- (void)setupDatabaseManager {
    
    [SFDatabaseManager sharedInstance];
}

- (void)makeSampleRequest {
    
    SFNetworkManager *manager = [SFNetworkManager sharedInstance];
    
    [manager requestWithURL:@"https://mxlbw0t3ia.execute-api.ap-northeast-1.amazonaws.com/prod/startup"
                     method:SFRequestMethodGET
                 parameters:nil
          cachePeriodInSecs:60
                    success:^(NSDictionary *responseDict) {
                        
                        SFLogDebug(@"Request succeed");
                    }
                    failure:^(NSError *error) {
                        
                        SFLogError(@"Request failed");
                    }];
}

#pragma mark - Buttons 

- (void)loginAnonymous:(id)sender {
    
    [[SFAuthManager sharedInstance] loginAnonymous];
}

- (void)loginFacebook:(id)sender {
    
    [[SFAuthManager sharedInstance] loginFacebook];
}

- (void)loginGoogle:(id)sender {
    
    [[SFAuthManager sharedInstance] loginGoogle];
}

- (void)logout:(id)sender {
    
    [[SFAuthManager sharedInstance] logout];
}

#pragma mark - Notification Callbacks

- (void)loginFacebookComplete:(NSNotification*)notification {
    if (notification) {
        if ([notification userInfo] && [[notification userInfo] objectForKey:@"error"]) {
            NSLog(@"error :0) ");
        }
    }
}

@end
