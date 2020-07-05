//
//  UIImageView+Runtime.m
//  GHImageSizeDetector
//
//  Created by Run Liao on 2020/7/2.
//  Copyright © 2020 Run Liao. All rights reserved.
//

#import "UIImageView+MemDetector.h"
#import <objc/runtime.h>
@implementation UIImageView (Runtime)


+(void)showMemoryCost {
#ifdef DEBUG
    Method originalMethod = class_getInstanceMethod([self class], @selector(setImage:));
    Method swizzledMethod = class_getInstanceMethod([self class], @selector(swizzled_setImage:));
    
    BOOL didAddMethod = class_addMethod([self class], @selector(setImage:), method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod([self class], @selector(swizzled_setImage:), method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
#endif
}


- (void)swizzled_setImage:(UIImage *)image
{
    [self swizzled_setImage:image];
    
    CATextLayer *imageSizeLayer = [[CATextLayer alloc]init];
    imageSizeLayer.fontSize = 8;
    imageSizeLayer.contentsScale = [UIScreen mainScreen].scale;
    imageSizeLayer.backgroundColor = UIColor.blackColor.CGColor;
    if (self.frame.size.width != 0) {
        imageSizeLayer.frame = CGRectMake((self.frame.size.width - 30) * 0.5, (self.frame.size.height - 10) * 0.5, 30, 10);
    } else {
        imageSizeLayer.frame = CGRectMake(0, 0, 30, 10);
    }
    imageSizeLayer.string = [self stringWithbytes:[self calculateMemorySize:image]];
    [self.layer addSublayer:imageSizeLayer];
}

/// Calculate the Memory Size Cost pixel * 4 (r, g, b, alphe) * frameCount
/// @param image image
- (int)calculateMemorySize:(UIImage *)image {
    CGImageRef imageRef = image.CGImage;
    if (!imageRef) {
        return 0;
    }
    NSUInteger bytesPerFrame = CGImageGetBytesPerRow(imageRef) * CGImageGetHeight(imageRef);
    NSUInteger frameCount;
    frameCount = image.images.count > 0 ? image.images.count : 1;
    NSUInteger cost = bytesPerFrame * frameCount;
    return (int)cost;
}

/// friendly Memory usage display
/// @param bytes bytes
- (NSString *)stringWithbytes:(int)bytes {
  if (bytes < 1024) { // B
      return [NSString stringWithFormat:@"%dB", bytes];
  } else if (bytes >= 1024 && bytes < 1024 * 1024) { // KB
      return [NSString stringWithFormat:@"%.0fKB", (double)bytes / 1024];
  } else { // MB
      return [NSString stringWithFormat:@"%.1fMB", (double)bytes / (1024 * 1024)];
  }
}
@end
