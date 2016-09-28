//
//  NSString+SFAddition.m
//  Pods
//
//  Created by Derek on 28/9/2016.
//
//

#import "NSString+SFAddition.h"

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

@end
