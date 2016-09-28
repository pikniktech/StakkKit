//
//  SFLoggingManager.m
//  Pods
//
//  Created by Derek on 28/9/2016.
//
//

#import "SFLoggingManager.h"

@implementation SFLoggingManager

+ (void)setupWithLevel:(SFLogLevel)level {
    
    setenv("XcodeColors", "YES", 0);
    
    [DDLog addLogger:[DDTTYLogger sharedInstance] withLevel:level];
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor redColor] backgroundColor:nil forFlag:SFLogFlagError];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor brownColor] backgroundColor:nil forFlag:SFLogFlagDatabase];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor blueColor] backgroundColor:nil forFlag:SFLogFlagAPI];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor darkGrayColor] backgroundColor:nil forFlag:SFLogFlagDebug];
}

@end
