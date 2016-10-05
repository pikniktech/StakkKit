//
//  SFAuthManager.h
//  Pods
//
//  Created by Jacky Chan on 4/10/2016.
//
//

// Frameworks
#import <Foundation/Foundation.h>
#import <GoogleSignIn/GoogleSignIn.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import <Firebase/Firebase.h>

// Notifications
static NSString* const kLoginAnonymousCompletedNotification = @"kLoginAnonymousCompletedNotification";
static NSString* const kLoginFacebookCompletedNotification = @"kLoginFacebookCompletedNotification";
static NSString* const kLoginGoogleCompletedNotification = @"kLoginGoogleCompletedNotification";
static NSString* const kLogoutNotification = @"kLogoutNotification";

@interface SFAuthManager : NSObject <GIDSignInDelegate, GIDSignInUIDelegate>

+ (instancetype)sharedInstance;

- (void)loginAnonymous;
- (void)loginGoogle;
- (void)loginFacebook;
- (void)logout;
- (BOOL)isLoggedIn;
- (BOOL)isLoggedInAnonymous;
- (BOOL)isLoggedInFacebook;
- (BOOL)isLoggedInGoogle;
- (void)editUserDisplayName:(NSString*)name;
- (void)editUserDisplayName:(NSString*)name pic:(NSURL*)pic;

@end
