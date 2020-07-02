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
}

- (NSUInteger)calculateMemorySize:(UIImage *)image {
    CGImageRef imageRef = image.CGImage;
    if (!imageRef) {
        return 0;
    }
    NSUInteger bytesPerFrame = CGImageGetBytesPerRow(imageRef) * CGImageGetHeight(imageRef);
    NSUInteger frameCount;
    frameCount = image.images.count > 0 ? image.images.count : 1;
    NSUInteger cost = bytesPerFrame * frameCount;
    return cost;
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
