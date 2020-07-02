//
//  GHImageSizeDetetor.swift
//  GHImageSizeDetector
//
//  Created by Run Liao on 2020/7/2.
//  Copyright © 2020 Run Liao. All rights reserved.
//

import ObjectiveC
import UIKit
extension UIViewController {
//    static func start() {
//        // 交换思路：
//        // 1、将原生方法动态添加到自定义的方法地址上
//        // 2、如果1添加成功，将自定义的方法添加到原生方法的地址上
//        // 3、如果添加不成功，将这两个方法再用方法交换函数进行地址交换：method_exchangeImplementations
//        // 获取两个方法
//        let originalSelector = #selector(init)
//        let swizzledSelector = #selector(gh_initialize)
//        
//        // 通过Selector获取方法地址
//        guard let originalMethod = class_getInstanceMethod(self, originalSelector) else { return }
//        guard let swizzledMethod = class_getInstanceMethod(self, swizzledSelector) else { return }
//        
//        // 将系统的方法动态添加到自定义方法的地址上
//        // 参数说明：
//        // 第一个参数：给哪个类添加方法
//        // 第二个参数：添加方法的方法选择器
//        // 第三个参数：添加方法的函数实现（函数地址）
//        // 第四个参数：函数的类型
//        let didAddMethod = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
//        
//        // 上一步添加成功，再将自定义的添加到原生方法的地址上
//        if didAddMethod {
//            class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
//        } else {
//            // 之前添加不成功，再交换两个方法的地址
//            method_exchangeImplementations(originalMethod, swizzledMethod)
//        }
//    }
    
    // MARK: - Method Swizzling
    
    @objc func gh_initialize() {
        // 调用自定义的方法去实现系统原生的方法，因为此时自定义的方法地址已经是系统对应方法的地址了
        self.gh_initialize()
        
        // TODO：自己想要添加的功能
        print("nsh_viewWillAppear: \(description)")
    }
    
    
    
    func realStart() {
        let oldClassName = NSStringFromClass(UIImageView.self)
        let newClassName = NSStringFromClass(SetedImageView.self)
        let name = String(utf8String: class_getName(SetedImageView.self))!

        
        guard let MyClass = objc_allocateClassPair(UIImageView.self, name, 0) else { return }
        
        objc_registerClassPair(MyClass)
        object_setClass(self, MyClass)
    }
}


class SetedImageView: UIImageView {

    override var image: UIImage? {
        didSet{
            print("啊我被set了")
        }
    }
    
    
}
