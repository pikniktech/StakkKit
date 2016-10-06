//
//  SFFirebaseManager.m
//  Pods
//
//  Created by Jacky Chan on 4/10/2016.
//
//

#import "SFFirebaseManager.h"

// Frameworks
#import <Firebase.h>

// Models
#import "SFLog.h"

// Macro
#import "SFMacro.h"

@implementation SFFirebaseManager

#pragma mark - Singleton

+ (instancetype)sharedInstance {
    
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        sharedInstance = [[[self class] alloc] init];
        
    });
    
    return sharedInstance;
}

#pragma mark - SFBaseAuthProtocol

- (void)login {
    
    if ([self isLoggedIn]) {
        
        PostNotification(kLoginFirebaseCompletedNotification, nil)
        return;
    }
    
    [[FIRAuth auth] signInAnonymouslyWithCompletion:^(FIRUser *_Nullable user, NSError *_Nullable error) {
        
        if (!error) {
            // TODO : sync User Profile
        }
        
        PostNotification(kLoginFirebaseCompletedNotification, error? @{@"error": error.localizedDescription}: nil)
    }];
    
}

- (void)logout {
    
    NSError *error;
    
    if ([self isLoggedIn]) {
        
        [[FIRAuth auth] signOut:&error];
        PostNotification(kLogoutFirebaseCompletedNotification, error? @{@"error": error.localizedDescription}: nil)
        
    }
}

- (BOOL)isLoggedIn {
    
    FIRUser *user = [FIRAuth auth].currentUser;
    return user != nil;
}

- (void)updateDisplayName:(NSString *)name {
    
    [self updateDisplayName:name imageURL:nil];
}

- (void)updateDisplayName:(NSString *)name imageURL:(NSURL *)imageURL {
    
    FIRUser *user = [FIRAuth auth].currentUser;
    FIRUserProfileChangeRequest *changeRequest = [user profileChangeRequest];
    
    if (name) {
        
        changeRequest.displayName = name;
    }
    
    if (imageURL) {
        
        changeRequest.photoURL = imageURL;
    }
    
    [changeRequest commitChangesWithCompletion:^(NSError *_Nullable error) {
        
        PostNotification(kUpdateProfileCompletedNotification, error? @{@"error": error.localizedDescription}: nil)
    }];
}

- (FIRUser *)getCurrentUser {
    
    return [[FIRAuth auth] currentUser];
}

@end
