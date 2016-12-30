//
//  SFBaseView.m
//  Pods
//
//  Created by Derek on 29/9/2016.
//
//

#import "SFBaseView.h"

@implementation SFBaseView

#pragma mark - Initialization

- (instancetype)init {
    
    if (self = [super init]) {
        
        [self setup];
        [self setupConstraints];
    }
    
    return self;
}

#pragma mark - Setup

- (void)setup {
    
    // Override hook
}

#pragma mark - Setup Layer

- (void)setupLayer {
    
    // Override hook
}

#pragma mark - Setup Constraints

- (void)setupConstraints {
    
    // Override hook
}

@end
