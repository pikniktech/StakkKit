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
    
    [DDLog addLogger:[DDTTYLogger sharedInstance] withLevel:(DDLogLevel)level];
    
//    setenv("XcodeColors", "YES", 0);
//
//    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
//    
//    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor redColor]
//                                     backgroundColor:nil
//                                             forFlag:(DDLogFlag)SFLogFlagError];
//    
//    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor brownColor]
//                                     backgroundColor:nil
//                                             forFlag:(DDLogFlag)SFLogFlagDatabase];
//    
//    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor blueColor]
//                                     backgroundColor:nil
//                                             forFlag:(DDLogFlag)SFLogFlagAPI];
//    
//    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor darkGrayColor]
//                                     backgroundColor:nil
//                                             forFlag:(DDLogFlag)SFLogFlagDebug];
}

@end
