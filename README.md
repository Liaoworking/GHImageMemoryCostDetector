# GHImageMemoryCostDetector

an easy way to show the memory cost in your UIImageView, as a reference, to optimise app's memory usage.

![Swift Version](https://img.shields.io/badge/xCode-9.1+-blue.svg)
![Swift Version](https://img.shields.io/badge/iOS-7.0+-blue.svg) 
![Plaform](https://img.shields.io/badge/Platform-iOS-lightgrey.svg)
![License MIT](https://img.shields.io/badge/License-MIT-lightgrey.svg) 


## Installation
Simply add Source folder with files to your project.

## Usage example
![image](https://upload-images.jianshu.io/upload_images/1724449-e15caa4027e5532b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/300)

![image](https://upload-images.jianshu.io/upload_images/1724449-d82fda0110109abb.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/300)

You can find example projects [here](https://github.com/Liaoworking/GHImageMemoryCostDetector)

#### Start

You just only initialize in your appDelegate.m When your App are launching.
**Objective-C usage**

```Objective-C
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [UIImageView showMemoryCost];
    return YES;
}
```

**Swift usage**

```Swift
 func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UIImageView.showMemoryCost()
        return true
    }
```

And then, you can all the imageView memory usage in every imageView.

## Support
UIImageView and it's subclass, like: SDAnimatedImageView.

## Performance

GHImageMemoryCostDetector just add a lightweight text layer in your original imageView.

The time consuming of UIImageView image set event for 20000 times:

![image](https://upload-images.jianshu.io/upload_images/1724449-4b3e579516d2cc10.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

Testing Environment: iPhone X

System Version: iOS 13.4.1

Unit of Time : s




## Features

* This framework only contains two files 

    **UIImageView+MemDetector.h**

    **UIImageView+MemDetector.m**

* Easy to use and uninstall.

* At **release mode**, there will be no more any memory detection of your UIImageView.
