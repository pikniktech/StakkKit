//
//  SFBaseCollectionViewCell.h
//  Pods
//
//  Created by Derek on 29/9/2016.
//
//

#import <UIKit/UIKit.h>

@interface SFBaseCollectionViewCell : UICollectionViewCell

- (void)setup; // Override hook

- (void)setupConstraints; // Override hook

+ (NSString *)reuseIdentifier;

@end
