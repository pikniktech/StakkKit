//
//  SFGoogleManager.m
//  Pods
//
//  Created by Jacky Chan on 5/10/2016.
//
//

#import "SFGoogleManager.h"

// Frameworks
#import <GoogleSignIn/GoogleSignIn.h>

// Models
#import "SFLog.h"

// Macro
#import "SFMacro.h"

@interface SFGoogleManager () <GIDSignInDelegate, GIDSignInUIDelegate>

@end

@implementation SFGoogleManager

#pragma mark - Singleton

+ (instancetype)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        sharedInstance = [[[self class] alloc] init];
        [sharedInstance setup];
    });
    
    return sharedInstance;
}

#pragma mark - Setup

- (void)setup {
    
}

#pragma mark - SFBaseAuthProtocol

- (void)login {
    
    if ([self isLoggedIn]) {
        PostNotification(kLoginGoogleCompletedNotification, @{kGoogleUserKey: [[GIDSignIn sharedInstance] currentUser]});
        return;
    }
    
    [GIDSignIn sharedInstance].uiDelegate = self;
    [GIDSignIn sharedInstance].delegate = self;
    [[GIDSignIn sharedInstance] signIn];
}

- (void)logout {
    
    if ([self isLoggedIn]){
        SFLogDebug(@"Google is logged in");
        [[GIDSignIn sharedInstance] signOut];
        
        PostNotification(kLogoutGoogleCompletedNotification, nil)
    }
}

- (BOOL)isLoggedIn {
    
    return [[GIDSignIn sharedInstance] currentUser] != nil;
}

#pragma mark - GIDSignInDelegate

- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error {

    NSDictionary* userInfo = @{kGoogleUserKey: user};
    if (error) {
        [userInfo setValue:error.localizedDescription forKey:@"error"];
    }
    
    PostNotification(kLoginGoogleCompletedNotification, userInfo)
}

#pragma mark - GIDSignInUIDelegate

- (void)signIn:(GIDSignIn *)signIn presentViewController:(UIViewController *)viewController {
    
    NSLog(@"signIn presentViewController");
    [RootViewController presentViewController:viewController animated:YES completion:nil];
}

- (void)signIn:(GIDSignIn *)signIn dismissViewController:(UIViewController *)viewController {
    
    NSLog(@"signIn dismissViewController");
    [RootViewController dismissViewControllerAnimated:YES completion:nil];
}


@end
