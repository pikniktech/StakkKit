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
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import <Firebase/Firebase.h>

// Notification
static NSString* const kLoginAnonymousCompletedNotification = @"kLoginAnonymousCompletedNotification";
static NSString* const kLoginFacebookCompletedNotification = @"kLoginFacebookCompletedNotification";
static NSString* const kLoginGoogleCompletedNotification = @"kLoginGoogleCompletedNotification";
static NSString* const kLogoutNotification = @"kLogoutNotification";

@interface SFAuthManager : NSObject

+ (instancetype)sharedInstance;

-(void) loginAnonymous;
-(void) loginGoogle;
-(void) loginFacebook;
-(void) signOut;
-(void) editUserDisplayName:(NSString*)name;
-(void) editUserDisplayName:(NSString*)name pic:(NSURL*)pic;
-(BOOL) isLoginAnonymous;

@end
