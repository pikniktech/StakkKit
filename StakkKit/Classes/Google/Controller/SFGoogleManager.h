//
//  SFGoogleManager.h
//  Pods
//
//  Created by Jacky Chan on 5/10/2016.
//
//

// Frameworks
#import <Foundation/Foundation.h>

// Protocols
#import "SFBaseAuthProtocol.h"

// Notifications
static NSString * const kLoginGoogleCompletedNotification = @"kLoginGoogleCompletedNotification";
static NSString * const kLogoutGoogleCompletedNotification = @"kLogoutGoogleCompletedNotification";

// Constants
static NSString * const kGoogleUserKey = @"kGoogleUserKey";

@interface SFGoogleManager : NSObject <SFBaseAuthProtocol>

+ (instancetype)sharedInstance;

- (void)login;
- (void)logout;
- (BOOL)isLoggedIn;

@end
