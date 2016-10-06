//
//  SFFacebookManager.h
//  Pods
//
//  Created by Jacky Chan on 5/10/2016.
//
//

// Protocols
#import "SFBaseAuthProtocol.h"

// Notifications
static NSString* const kLoginFacebookCompletedNotification = @"kLoginFacebookCompletedNotification";
static NSString* const kLogoutFacebookCompletedNotification = @"kLogoutFacebookCompletedNotification";

@interface SFFacebookManager : NSObject <SFBaseAuthProtocol>

+ (instancetype)sharedInstance;

- (void)login;
- (void)logout;
- (BOOL)isLoggedIn;

@end
