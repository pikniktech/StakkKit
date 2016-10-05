//
//  SFFirebaseManager.m
//  Pods
//
//  Created by Jacky Chan on 4/10/2016.
//
//

#import "SFFirebaseManager.h"

@implementation SFFirebaseManager

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



@end
