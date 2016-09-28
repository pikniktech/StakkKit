//
//  SFDatabaseManager.h
//  Pods
//
//  Created by Derek on 28/9/2016.
//
//

#import <Foundation/Foundation.h>

// Models
#import "SFDBAPICache.h"

typedef void (^SFDatabaseCompletionBlock)(BOOL success);

@interface SFDatabaseManager : NSObject

+ (instancetype)sharedInstance;

- (void)reset;

- (void)createOrUpdateAPICacheWithURL:(NSString *)url
                               method:(NSString *)method
                           parameters:(NSDictionary *)parameters
                             response:(NSDictionary *)response
                    cachePeriodInSecs:(CGFloat)cachePeriodInSecs
                             complete:(SFDatabaseCompletionBlock)complete;

- (SFDBAPICache *)getAPICacheWithURL:(NSString *)url
                              method:(NSString *)method
                          parameters:(NSDictionary *)parameters;

@end
