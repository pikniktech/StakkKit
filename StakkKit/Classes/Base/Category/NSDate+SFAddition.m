//
//  NSDate+SFAddition.m
//  Pods
//
//  Created by Derek on 28/12/2016.
//
//

#import "NSDate+SFAddition.h"

// Models
#import "SFConstant.h"

@implementation NSDate (SFAddition)

- (NSString *)iso8601String {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:kISO8601DateFormat];
    
    NSString *iso8601String = [dateFormatter stringFromDate:self];
    
    return iso8601String;
}

@end
