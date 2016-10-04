//
//  SFNetworkManager.h
//  Pods
//
//  Created by Derek on 27/9/2016.
//
//

#import <Foundation/Foundation.h>

// Constants
typedef enum {
    SFRequestMethodGET,
    SFRequestMethodPOST
} SFRequestMethod;

typedef void (^SFRequestSuccessBlock)(NSDictionary *responseDict);
typedef void (^SFRequestFailureBlock)(NSError *error);

@interface SFNetworkManager : NSObject

+ (instancetype)sharedInstance;

- (NSURLSessionDataTask *)requestWithURL:(NSString *)url
                                  method:(SFRequestMethod)method
                              parameters:(NSDictionary *)parameters
                             ignoreCache:(BOOL)ignoreCache
                       cachePeriodInSecs:(CGFloat)cachePeriodInSecs
                                 success:(SFRequestSuccessBlock)success
                                 failure:(SFRequestFailureBlock)failure;

@end
