//
//  NSDictionary+SFAddition.m
//  Pods
//
//  Created by Derek on 28/9/2016.
//
//

#import "NSDictionary+SFAddition.h"

@implementation NSDictionary (SFAddition)

- (NSString *)toJSONString {
    
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:&err];
    NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return myString;
}

@end
