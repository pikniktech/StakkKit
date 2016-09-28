//
//  SFLoggingManager.h
//  Pods
//
//  Created by Derek on 28/9/2016.
//
//

#import <Foundation/Foundation.h>

// Models
#import "SFLog.h"

@interface SFLoggingManager : NSObject

+ (void)setupWithLevel:(SFLogLevel)level;

@end
