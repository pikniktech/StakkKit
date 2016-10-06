//
//  SFFacebookManager.m
//  Pods
//
//  Created by Jacky Chan on 5/10/2016.
//
//

#import "SFFacebookManager.h"

// Frameworks
#import <Foundation/Foundation.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

// Models
#import "SFLog.h"

// Macro
#import "SFMacro.h"

@implementation SFFacebookManager

#pragma mark - Singleton

+ (instancetype)sharedInstance {
    
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        sharedInstance = [[[self class] alloc] init];
    
    });
    
    return sharedInstance;
}

#pragma mark - <SFBaseAuthProtocol>

- (void)login {
    
    if ([self isLoggedIn]) {
        
        PostNotification(kLoginFacebookCompletedNotification, nil)
        return;
        
    }
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    
    [login logInWithReadPermissions:@[@"public_profile", @"email", @"user_friends"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        
        if (error) {
            
            SFLogError(@"Facebook Process error");
            PostNotification(kLoginFacebookCompletedNotification, @{@"error":error.localizedDescription})
            
        } else if (result.isCancelled) {
            
            if (result.token) {
                
                SFLogDebug(@"Facebook already Logged in");
                PostNotification(kLoginFacebookCompletedNotification, nil)
                
            } else {
                
                SFLogDebug(@"Facebook Cancelled");
                
            }
            
        } else {
            
            SFLogDebug(@"Facebook Logged in");
            PostNotification(kLoginFacebookCompletedNotification, nil)
        }
    }];
}

- (void)logout {
    
    if ([self isLoggedIn]) {
        
        SFLogDebug(@"Facebook is logged in");
        FBSDKLoginManager *fbLoginManager = [[FBSDKLoginManager alloc] init];
        [fbLoginManager logOut];
        
        PostNotification(kLogoutFacebookCompletedNotification, nil)
    }
}

- (BOOL)isLoggedIn {
    
    return [FBSDKAccessToken currentAccessToken] != nil;
}

@end
