//
//  SFAuthManager.m
//  Pods
//
//  Created by Jacky Chan on 4/10/2016.
//
//

#import "SFAuthManager.h"

@implementation SFAuthManager

#pragma mark - Singleton

+ (instancetype)sharedInstance {
    
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


-(void)loginAnonymous {
    
    FIRUser *user = [FIRAuth auth].currentUser;
    if (user) {
        NSLog(@"user is anonymous:%@",user.isAnonymous?@"YES":@"NO");
        NSLog(@"user is email verified:%@",user.isEmailVerified?@"YES":@"NO");
        NSLog(@"user refreshToken:%@",user.refreshToken);
        NSLog(@"user id:%@",user.uid);
        NSLog(@"user name:%@",user.displayName);
        NSLog(@"user info :%@",user.providerData);
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kLoginAnonymousCompletedNotification object:nil];
        //[authPresenter authAnonymouslyWithCompletion:user error:nil];
    }else{
        [[FIRAuth auth]
         signInAnonymouslyWithCompletion:^(FIRUser *_Nullable user, NSError *_Nullable error) {
             if (!error) {
                 NSLog(@"user is anonymous:%@",user.isAnonymous?@"YES":@"NO");
                 NSLog(@"user is email verified:%@",user.isEmailVerified?@"YES":@"NO");
                 NSLog(@"user refreshToken:%@",user.refreshToken);
                 NSLog(@"user id:%@",user.uid);
                 NSLog(@"user name:%@",user.displayName);
                 NSLog(@"user info :%@",user.providerData);
                 
                 //                 [[UserDataManager sharedManager] syncUserProfile];
             }else{
                 NSLog(@"Fir auth error:%@",error);
             }
             [[NSNotificationCenter defaultCenter] postNotificationName:kLoginAnonymousCompletedNotification object:nil];
         }];
    }
    
}

-(void) loginGoogle{
    [GIDSignIn sharedInstance].delegate = self;
    [[GIDSignIn sharedInstance] signIn];
}
-(void) authFacebook:(UIViewController*)fromViewController{
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    
    [login logInWithReadPermissions:@[@"public_profile", @"email", @"user_friends"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error) {
            NSLog(@"Process error");
        } else if (result.isCancelled) {
            if (result.token) {
                NSLog(@"Logged in");
                //[self signInFacebookWithCredential];
            }else{
                NSLog(@"Cancelled");
            }
        } else {
            NSLog(@"Logged in");
            //[self signInFacebookWithCredential];
        }
        
    }];
    //    [login setLoginBehavior:FBSDKLoginBehaviorNative];
    //    [login
    //     logInWithReadPermissions: @[@"public_profile",@"user_photos",@"user_location"]
    //     fromViewController:fromViewController
    //     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
    //         if (error) {
    //             NSLog(@"Process error");
    //         } else if (result.isCancelled) {
    //             if (result.token) {
    //                 NSLog(@"Logged in");
    //                 [self signInFacebookWithCredential];
    //             }else{
    //                 NSLog(@"Cancelled");
    //             }
    //
    //         } else {
    //             NSLog(@"Logged in");
    //             [self signInFacebookWithCredential];
    //         }
    //
    //     }];
    
}

-(void) signInFacebookWithCredential{
  /*  FIRAuthCredential *credential = [FIRFacebookAuthProvider
                                     credentialWithAccessToken:[FBSDKAccessToken currentAccessToken]
                                     .tokenString];
    [[FIRAuth auth] signInWithCredential:credential completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
        if (!error) {
            NSLog(@"user login");
        }else{
            NSLog(@"user not login error:%@",error);
        }
        [authPresenter authFacebookWithCompletion:user withError:error];
        
    }];*/
    
}

-(void) signOut{
    NSError *error;
    FIRUser *currentUser = [FIRAuth auth].currentUser;
    NSString *providerID =  currentUser.providerData.firstObject.providerID;
    [[FIRAuth auth] signOut:&error];
    if (!error) {
        if ([providerID isEqualToString:@"google.com"]) {
            [[GIDSignIn sharedInstance] signOut];
        }else if ([providerID isEqualToString:@"facebook.com"]){
            FBSDKLoginManager *fbLoginManager = [[FBSDKLoginManager alloc] init];
            [fbLoginManager logOut];
        }
        NSLog(@"LogOut Succeed");
    }else{
        NSLog(@"LogOut Fail");
    }
    if (!error) {
        //[[CacheDataManager sharedManager] removeCacheDataFromKey:IS_LOGIN];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:kLogoutNotification object:nil userInfo:error?@{@"error":error}:nil];
    //[authPresenter signOut:error];
}

-(void) editUserDisplayName:(NSString*)name{
    FIRUser *user = [FIRAuth auth].currentUser;
    NSLog(@"editUserDisplayName uid:%@",user.uid);
    FIRUserProfileChangeRequest *changeRequest = [user profileChangeRequest];
    changeRequest.displayName = name;
    [changeRequest commitChangesWithCompletion:^(NSError *_Nullable error) {
        //[authPresenter editUserDisplayNameWithError:error];
    }];
}
-(void) editUserDisplayName:(NSString*)name pic:(NSURL*)pic{
    FIRUser *user = [FIRAuth auth].currentUser;
    FIRUserProfileChangeRequest *changeRequest = [user profileChangeRequest];
    if (name) {
        changeRequest.displayName = name;
    }
    changeRequest.photoURL = pic;
    [changeRequest commitChangesWithCompletion:^(NSError *_Nullable error) {
     //   [authPresenter editUserDisplayNameWithError:error];
    }];
}

#pragma mark - GIDSignInDelegate
- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    if (error == nil) {
        //        _nameTF.text = user.profile.name;
        NSLog(@"signIn userId%@:",user.userID);
        GIDAuthentication *authentication = user.authentication;
        FIRAuthCredential *credential =
        [FIRGoogleAuthProvider credentialWithIDToken:authentication.idToken
                                         accessToken:authentication.accessToken];
        
        [[FIRAuth auth] signInWithCredential:credential completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
            if (!error) {
                NSLog(@"user login uid:%@",user.uid);
            }else{
                NSLog(@"user not login");
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:kLoginGoogleCompletedNotification object:nil userInfo:error?@{@"error":error}:nil];
            //[authPresenter authGoogleWithCompletion:user withError:error];
        }];
        
    } else {
        NSLog(@"%@", error.localizedDescription);
         [[NSNotificationCenter defaultCenter] postNotificationName:kLoginGoogleCompletedNotification object:nil userInfo:@{@"error":error}];
        //[authPresenter authGoogleWithCompletion:nil withError:error];
    }
}

@end
