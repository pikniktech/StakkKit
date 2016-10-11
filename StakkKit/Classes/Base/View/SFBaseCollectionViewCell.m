//
//  SFBaseCollectionViewCell.m
//  Pods
//
//  Created by Derek on 29/9/2016.
//
//

#import "SFBaseCollectionViewCell.h"

// Frameworks
#import <PureLayout/PureLayout.h>

@implementation SFBaseCollectionViewCell

#pragma mark - Initialization

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setup];
        [self setupConstraints];
    }
    
    return self;
}

#pragma mark - Setup

- (void)setup {
    
    // Override hook
}

#pragma mark - Setup Constraints

- (void)setupConstraints {
    
    // Override hook
}

#pragma mark - Public

+ (NSString *)reuseIdentifier {
    
    return NSStringFromClass([self class]);
}

#pragma mark - Setters

- (void)setBaseView:(UIView *)baseView {
    
    if (_baseView) {
        
        [_baseView removeFromSuperview];
    }
    
    _baseView = baseView;
    
    if (_baseView) {
        
        [self.contentView addSubview:_baseView];
        _baseView.translatesAutoresizingMaskIntoConstraints = NO;
        [_baseView autoPinEdgesToSuperviewEdges];
    }
}

@end
