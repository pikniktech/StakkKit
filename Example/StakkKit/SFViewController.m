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
    
    [self setupLogging];
    [self makeSampleRequest];
}

#pragma mark - Helpers

- (void)setupLogging {
    
    [SFLoggingManager setupWithLevel:SFLogLevelAll];
    SFLogError(@"Error Log");
    SFLogDB(@"DB Log");
    SFLogAPI(@"API Log");
    SFLogDebug(@"Debug Log");
}

- (void)makeSampleRequest {
    
    SFNetworkManager *manager = [SFNetworkManager sharedInstance];
    
    [manager requestWithURL:@"https://mxlbw0t3ia.execute-api.ap-northeast-1.amazonaws.com/prod/startup"
                     method:SFRequestMethodGET
                 parameters:nil
          cachePeriodInSecs:0
                    success:^(NSDictionary *responseDict) {
                        
                        SFLogDebug(@"Request succeed");
                    }
                    failure:^(NSError *error) {
                        
                        SFLogError(@"Request failed");
                    }];
}

@end
