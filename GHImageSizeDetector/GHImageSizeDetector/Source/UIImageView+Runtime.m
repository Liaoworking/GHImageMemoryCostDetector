//
//  UIImageView+Runtime.m
//  GHImageSizeDetector
//
//  Created by Run Liao on 2020/7/2.
//  Copyright © 2020 Run Liao. All rights reserved.
//

#import "UIImageView+Runtime.h"
#import <objc/runtime.h>
@implementation UIImageView (Runtime)


+(void)start {
    Method method1 = class_getInstanceMethod([self class], @selector(setImage:));
    Method method2 = class_getInstanceMethod([self class], @selector(swizzled_setImage:));
    //交换method1和method2的IMP指针，(IMP代表了方法的具体的实现）
    method_exchangeImplementations(method1, method2);
}


- (void)swizzled_setImage:(UIImage *)image
{
    // call original implementation
    [self swizzled_setImage:image];
    NSLog(@"%lu\n",(unsigned long)[self calculateMemorySize:image]);
    NSLog(@"%lu\n",UIImageJPEGRepresentation(image, 1).length);
    
    UILabel * sizeLabel = [UILabel new];
//    sizeLabel.text = [NSString stringWithFormat:@"%lu\n",(unsigned long)[self calculateMemorySize:image]];
  sizeLabel.text = [self stringWithbytes:[self calculateMemorySize:image]];

    sizeLabel.frame = CGRectMake(0, 0, 40, 10);
    sizeLabel.font = [UIFont systemFontOfSize:8];
    sizeLabel.backgroundColor = [UIColor blackColor];
    sizeLabel.textColor = [UIColor whiteColor];
    [self addSubview:sizeLabel];
}

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

- (NSString *)stringWithbytes:(int)bytes {
  if (bytes < 1024) { // B
      return [NSString stringWithFormat:@"%dB", bytes];
  } else if (bytes >= 1024 && bytes < 1024 * 1024) { // KB
      return [NSString stringWithFormat:@"%.0fKB", (double)bytes / 1024];
  } else { // MB
      return [NSString stringWithFormat:@"%.1fMB", (double)bytes / (1024 * 1024)];
  }
}


void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector)
{
    // the method might not exist in the class, but in its superclass
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    // class_addMethod will fail if original method already exists
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    // the method doesn’t exist and we just added one
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
    else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
    
}


@end
