//
//  SFBaseTableViewCell.m
//  Pods
//
//  Created by Derek on 29/9/2016.
//
//

#import "SFBaseTableViewCell.h"

// Frameworks
#import <PureLayout/PureLayout.h>

// Constants
static CGFloat const kDefaultBorderWidth = 1.0;

@interface SFBaseTableViewCell ()

@property (nonatomic, strong) UIView *topSeparator;
@property (nonatomic, strong) UIView *bottomSeparator;

@end

@implementation SFBaseTableViewCell

#pragma mark - Initialization

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setup];
        [self setupConstraints];
    }
    return self;
}

#pragma mark - Setup

- (void)setup {
    
    [self setupTopSeparator];
    [self setupBottomSeparator];
    
    // Override hook
}

- (void)setupTopSeparator {
    
    _topSeparator = [UIView newAutoLayoutView];
    
    _topSeparator.backgroundColor = [UIColor blackColor];
    _topSeparator.hidden = YES;
    _topSeparator.layer.zPosition = MAXFLOAT;
    
    [self.contentView addSubview:_topSeparator];
}

- (void)setupBottomSeparator {
    
    _bottomSeparator = [UIView newAutoLayoutView];
    
    _bottomSeparator.backgroundColor = [UIColor blackColor];
    _bottomSeparator.hidden = YES;
    _bottomSeparator.layer.zPosition = MAXFLOAT;
    
    [self.contentView addSubview:_bottomSeparator];
}

#pragma mark - Setup Layer

- (void)setupLayer {
    
    // Override hook
}

#pragma mark - Setup Constraints

- (void)setupConstraints {
    
    [self setupTopSeparatorConstraints];
    [self setupBottomSeparatorConstraints];
    
    // Override hook
}

- (void)setupTopSeparatorConstraints {
    
    [_topSeparator autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    [_topSeparator autoSetDimension:ALDimensionHeight toSize:kDefaultBorderWidth];
}

- (void)setupBottomSeparatorConstraints {
    
    [_bottomSeparator autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    [_bottomSeparator autoSetDimension:ALDimensionHeight toSize:kDefaultBorderWidth];
}

#pragma mark - Layout

- (void)layoutSubviews {
    
    [super layoutSubviews];
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
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
