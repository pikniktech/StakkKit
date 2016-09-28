//
//  SFNetworkManager.m
//  Pods
//
//  Created by Derek on 27/9/2016.
//
//

#import "SFNetworkManager.h"

// Frameworks
#import "AFNetworking.h"

//Models
#import "SFLog.h"

//// Controllers
#import "SFDatabaseManager.h"

typedef void (^SFActionSuccessBlock)(NSString *url, NSDictionary *responseDict, SFRequestSuccessBlock successBlock, BOOL isFromCache, CGFloat cachePeriodInSecs);
typedef void (^SFActionFailureBlock)(NSString *url, NSError *error, SFRequestFailureBlock failure);

@interface SFNetworkManager ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation SFNetworkManager

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
    
    self.sessionManager = [AFHTTPSessionManager manager];
}


#pragma mark - Public

- (NSURLSessionDataTask *)requestWithURL:(NSString *)url
                                  method:(SFRequestMethod)method
                              parameters:(NSDictionary *)parameters
                       cachePeriodInSecs:(CGFloat)cachePeriodInSecs
                                 success:(SFRequestSuccessBlock)success
                                 failure:(SFRequestFailureBlock)failure {
    
    // Success action block
    SFActionSuccessBlock successActionBlock = ^(NSString *url,
                                                NSDictionary *responseDict,
                                                SFRequestSuccessBlock successBlock,
                                                BOOL isFromCache,
                                                CGFloat cachePeriodInSecs) {
        
        [SFNetworkManager endRequestLoggingWithURL:url
                                       isFromCache:isFromCache
                                         isSuccess:YES
                                    responseObject:responseDict
                                             error:nil];
        
        if (!isFromCache && cachePeriodInSecs > 0) {
            
            [[SFDatabaseManager sharedInstance] createOrUpdateAPICacheWithURL:url
                                                                       method:[SFNetworkManager stringForMethod:method]
                                                                   parameters:parameters
                                                                     response:responseDict
                                                            cachePeriodInSecs:cachePeriodInSecs
                                                                     complete:^(BOOL success) {
                                                                         
                                                                         if (successBlock) {
                                                                             
                                                                             successBlock(responseDict);
                                                                         }
                                                                     }];
        } else {
            
            if (successBlock) {
                
                successBlock(responseDict);
            }
        }
    };
    
    // Failure action block
    SFActionFailureBlock failureActionBlock = ^(NSString *url,
                                                NSError *error,
                                                SFRequestFailureBlock failure) {
        
        [SFNetworkManager endRequestLoggingWithURL:url
                                       isFromCache:NO
                                         isSuccess:NO
                                    responseObject:nil
                                             error:error];
        
        if (failure) {
            
            failure(error);
        }
    };
    
    // Start request logging
    [SFNetworkManager startRequestLoggingWithMethod:method URL:url parameters:parameters];
    
    // Try to get response from cache
    SFDBAPICache *model = [[SFDatabaseManager sharedInstance] getAPICacheWithURL:url
                                                                          method:[SFNetworkManager stringForMethod:method]
                                                                      parameters:parameters];
    
    NSURLSessionDataTask *task = nil;
    
    if (model) {
        
        successActionBlock(url, model.response, success, YES, cachePeriodInSecs);
        
    } else {
        
        AFHTTPSessionManager *manager = self.sessionManager;
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        
        if (method == SFRequestMethodGET) {
            
            task = [manager GET:url
                     parameters:parameters
                       progress:nil
                        success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                            
                            successActionBlock(url, responseObject, success, NO, cachePeriodInSecs);
                            
                        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                            
                            failureActionBlock(url, error, failure);
                        }];
            
        } else {
            
            task = [manager POST:url
                      parameters:parameters
                        progress:nil
                         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                             
                             successActionBlock(url, responseObject, success, NO, cachePeriodInSecs);
                             
                         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                             
                             failureActionBlock(url, error, failure);
                         }];
        }
    }
    
    return task;
}

#pragma mark - Helpers

+ (void)startRequestLoggingWithMethod:(SFRequestMethod)method
                                  URL:(NSString *)url
                           parameters:(NSDictionary *)parameters {
    
    NSMutableString *logString = [[NSMutableString alloc] init];
    
    [logString appendString:@"---Request started---\n"];
    [logString appendFormat:@"URL: %@\n", url];
    [logString appendFormat:@"Method: %@\n", [SFNetworkManager stringForMethod:method]];
    [logString appendFormat:@"Parameters: %@\n", parameters];
    [logString appendString:@"---Request started---\n"];
    
    SFLogAPI(@"%@", logString);
}


+ (void)endRequestLoggingWithURL:(NSString *)url
                     isFromCache:(BOOL)isFromCache
                       isSuccess:(BOOL)success
                  responseObject:(NSDictionary *)responseObject
                           error:(NSError *)error
{
    NSMutableString *logString = [[NSMutableString alloc] init];
    
    [logString appendString:@"---Request ended---\n"];
    [logString appendFormat:@"URL: %@\n", url];
    [logString appendFormat:@"Status: %@\n", success ? @"Success" : @"Fail"];
    [logString appendFormat:@"FromCache: %@\n", isFromCache ? @"YES" : @"NO"];
    
    if (success) {
        
        [logString appendFormat:@"ResponseObject: %@\n", responseObject];
        
    } else {
        
        if (error) {
            
            [logString appendFormat:@"Error: %@\n", [error localizedDescription]];
        }
    }
    
    [logString appendString:@"---Request ended---"];
    
    SFLogAPI(@"%@", logString);
}

+ (NSString *)stringForMethod:(SFRequestMethod)method {
    
    if (method == SFRequestMethodGET) {
        
        return @"GET";
        
    } else {
        
        return @"POST";
    }
}

@end
