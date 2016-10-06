//
//  SFAuthProtocol.h
//  Pods
//
//  Created by Jacky Chan on 5/10/2016.
//
//

@protocol SFBaseAuthProtocol

@required
- (void)login;
- (void)logout;
- (BOOL)isLoggedIn;

@end
