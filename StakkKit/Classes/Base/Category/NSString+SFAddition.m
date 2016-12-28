//
//  NSString+SFAddition.m
//  Pods
//
//  Created by Derek on 28/9/2016.
//
//

#import "NSString+SFAddition.h"

// Models
#import "SFConstant.h"

@implementation NSString (SFAddition)

- (NSDictionary *)toDictionary {
    
    NSError * err;
    NSData *data =[self dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary * response;
    
    if (data) {
        
        response = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
    }
    
    return response;
}

- (NSDate *)iso8601Date {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:kISO8601DateFormat];
    
    NSDate *iso8601Date = [dateFormatter dateFromString:self];
    
    return iso8601Date;
}

@end
