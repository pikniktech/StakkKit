//
//  SFDBAPICache.h
//  Pods
//
//  Created by Derek on 28/9/2016.
//
//

#import "SFBaseDBModel.h"

@interface SFDBAPICache : SFBaseDBModel

@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *method;
@property (nonatomic, copy) NSString *parametersString;
@property (nonatomic, copy) NSDictionary *response;
@property (nonatomic, copy) NSDate *expiryDate;

@end
