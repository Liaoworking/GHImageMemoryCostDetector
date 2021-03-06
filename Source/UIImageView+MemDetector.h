//
//  UIImageView+Runtime.h
//  GHImageSizeDetector
//
//  Created by Run Liao on 2020/7/2.
//  Copyright © 2020 Run Liao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (Runtime)

/// show the memory cost in your imageView.
+(void)showMemoryCost;

@end

NS_ASSUME_NONNULL_END
