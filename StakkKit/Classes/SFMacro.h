//
//  SFMacro.h
//  Pods
//
//  Created by Jacky Chan on 5/10/2016.
//
//

#define RootViewController [[[[UIApplication sharedApplication] delegate] window] rootViewController]

#define PostNotification(NAME, USERINFO) [[NSNotificationCenter defaultCenter] postNotificationName:NAME object:nil userInfo:USERINFO];
