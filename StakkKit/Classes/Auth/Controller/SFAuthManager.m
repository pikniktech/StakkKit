//
//  SFAuthManager.m
//  Pods
//
//  Created by Jacky Chan on 4/10/2016.
//
//

#import "SFAuthManager.h"'
#import "SFMacro.h"

@implementation SFAuthManager

#pragma mark - Singleton

+ (instancetype)sharedInstance {
    
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        sharedInstance = [[[self class] alloc] init];
    });
    
    return sharedInstance;
}

#pragma mark - Public

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

-(void) loginGoogle {
    
    [GIDSignIn sharedInstance].uiDelegate = self;
    [GIDSignIn sharedInstance].delegate = self;
    [[GIDSignIn sharedInstance] signIn];
}

-(void) loginFacebook {
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    
    [login logInWithReadPermissions:@[@"public_profile", @"email", @"user_friends"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error) {
            NSLog(@"Facebook Process error");
        } else if (result.isCancelled) {
            if (result.token) {
                NSLog(@"Facebook Logged in");
                [[NSNotificationCenter defaultCenter] postNotificationName:kLoginFacebookCompletedNotification object:nil userInfo:nil];
            }else{
                NSLog(@"Facebook Cancelled");
            }
        } else {
            NSLog(@"Facebook Logged in");
            [[NSNotificationCenter defaultCenter] postNotificationName:kLoginFacebookCompletedNotification object:nil userInfo:nil];
        }
        
    }];
}

- (BOOL)isLoggedIn {
    
    return ([self isLoggedInAnonymous] || [self isLoggedInFacebook] || [self isLoggedInFacebook]);
}

- (BOOL)isLoggedInAnonymous{
    
    FIRUser *user = [FIRAuth auth].currentUser;
    if (user) {
        return YES;
    }
    return NO;
}

- (BOOL)isLoggedInFacebook {
    
    return [FBSDKAccessToken currentAccessToken] != nil;
}

- (BOOL)isLoggedInGoogle {
    
    return [[GIDSignIn sharedInstance] currentUser] != nil;
}

- (void)logout {
    
    NSError *error;
    if ([self isLoggedInFacebook]) {
        
        SFLogDebug(@"Facebook is logged in");
        FBSDKLoginManager *fbLoginManager = [[FBSDKLoginManager alloc] init];
        [fbLoginManager logOut];
    } else if ([self isLoggedInGoogle]){
        
        SFLogDebug(@"Google is logged in");
        [[GIDSignIn sharedInstance] signOut];
    } else if ([self isLoggedInAnonymous]) {
        
        SFLogDebug(@"Anonymous is logged in");
        [[FIRAuth auth] signOut:&error];
    }
    
    if (!error) {
        // remove cached key from db
        
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kLogoutNotification object:nil userInfo:error? @{@"error":error}: nil];
    
    
//    NSError *error;
//    FIRUser *currentUser = [FIRAuth auth].currentUser;
//    NSString *providerID =  currentUser.providerData.firstObject.providerID;
//    [[FIRAuth auth] signOut:&error];
//    if (!error) {
//        if ([providerID isEqualToString:@"google.com"]) {
//            [[GIDSignIn sharedInstance] signOut];
//        }else if ([providerID isEqualToString:@"facebook.com"]){
//            FBSDKLoginManager *fbLoginManager = [[FBSDKLoginManager alloc] init];
//            [fbLoginManager logOut];
//        }
//        NSLog(@"LogOut Succeed");
//    }else{
//        NSLog(@"LogOut Fail");
//    }
    
//    if (!error) {
//        [[CacheDataManager sharedManager] removeCacheDataFromKey:IS_LOGIN];
//    }
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

- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error {
    
    if (error == nil) {
        NSLog(@"signIn userId%@:",user.userID);
//        GIDAuthentication *authentication = user.authentication;
//        FIRAuthCredential *credential =
//        [FIRGoogleAuthProvider credentialWithIDToken:authentication.idToken
//                                         accessToken:authentication.accessToken];
//        
//        [[FIRAuth auth] signInWithCredential:credential completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
//            if (!error) {
//                NSLog(@"user login uid:%@",user.uid);
//            }else{
//                NSLog(@"user not login");
//            }
//            [[NSNotificationCenter defaultCenter] postNotificationName:kLoginGoogleCompletedNotification object:nil userInfo:error?@{@"error":error}:nil];
//            //[authPresenter authGoogleWithCompletion:user withError:error];
//        }];
        [[NSNotificationCenter defaultCenter] postNotificationName:kLoginGoogleCompletedNotification object:nil userInfo:nil];
        
    } else {
        NSLog(@"%@", error.localizedDescription);
         [[NSNotificationCenter defaultCenter] postNotificationName:kLoginGoogleCompletedNotification object:nil userInfo:@{@"error":error}];
        //[authPresenter authGoogleWithCompletion:nil withError:error];
    }
}

#pragma mark - GIDSignInUIDelegate

- (void)signInWillDispatch:(GIDSignIn *)signIn error:(NSError *)error {
    
    NSLog(@"signInWillDispatch");
}

- (void)signIn:(GIDSignIn *)signIn presentViewController:(UIViewController *)viewController {
    
    NSLog(@"signIn presentViewController");
    [RootViewController presentViewController:viewController animated:YES completion:nil];
}

- (void)signIn:(GIDSignIn *)signIn dismissViewController:(UIViewController *)viewController {
    
    NSLog(@"signIn dismissViewController");
    [RootViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
