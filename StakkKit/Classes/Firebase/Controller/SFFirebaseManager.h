//
//  SFFirebaseManager.h
//  Pods
//
//  Created by Jacky Chan on 4/10/2016.
//
//

// Frameworks
#import <Foundation/Foundation.h>
#import <FirebaseAuth/FIRUser.h>

// Protocols
#import "SFBaseAuthProtocol.h"

// Notifications
static NSString * const kLoginFirebaseCompletedNotification = @"kLoginFirebaseCompletedNotification";
static NSString * const kLogoutFirebaseCompletedNotification = @"kLogoutFirebaseCompletedNotification";
static NSString * const kUpdateProfileCompletedNotification = @"kUpdateProfileCompletedNotification";

@interface SFFirebaseManager : NSObject <SFBaseAuthProtocol>

+ (instancetype)sharedInstance;

- (void)login;
- (void)logout;
- (BOOL)isLoggedIn;

- (void)updateDisplayName:(NSString *)name;
- (void)updateDisplayName:(NSString *)name imageURL:(NSURL *)imageURL;
- (FIRUser *)getCurrentUser;

@end
