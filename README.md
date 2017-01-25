# EmptyDataKit  [中文](https://github.com/ProgramerSunny/EmptyDataKit/blob/master/README_CN.md)

[![CI Status](http://img.shields.io/travis/孙扬/EmptyDataKit.svg?style=flat)](https://travis-ci.org/孙扬/EmptyDataKit)
[![Version](https://img.shields.io/cocoapods/v/EmptyDataKit.svg?style=flat)](http://cocoapods.org/pods/EmptyDataKit)
[![License](https://img.shields.io/cocoapods/l/EmptyDataKit.svg?style=flat)](http://cocoapods.org/pods/EmptyDataKit)
[![Platform](https://img.shields.io/cocoapods/p/EmptyDataKit.svg?style=flat)](http://cocoapods.org/pods/EmptyDataKit)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

EmptyDataKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "EmptyDataKit"
```



## ScreenShot

<img src="http://ocg4av0wv.bkt.clouddn.com/ProgramerSunnyDemo.gif" width= "400" />



this kit is also added to the other repository named `SBAnimation`  and the demo in `SBAnimation` is cleaner more clearly. so sorry that I don't want to replace this demo with `SBAnimation` . so I show you the screenshot in that demo here too. you can go [there](https://github.com/SolarBee/SBAnimation)  to read my codes if you need to.



<img src="http://ojno1pj4x.bkt.clouddn.com/EmptyDataKit.gif">





## Usage

Add the codes when you need to use EmptyDataKit, Such as `ViewDidLoad`

```objective-c
		__weak typeof(self) weakSelf = self;
        EmptyDataKit *kit = [[EmptyDataKit alloc] initWithEdk_Image:[UIImage imageNamed:@"common_pic_loadFail"] edk_Message:@"aaa" edk_reloadHandler:^{
            [weakSelf getData];
        }];
        kit.edk_error_image = [UIImage imageNamed: @""];
        kit.edk_error_message = @"网络错误";
        self.tableView.emptyKit = kit;
```



and we also provide you a enum like this 

```objective-c
typedef NS_ENUM(NSUInteger ,EmptyDataType) {
    EDK_Loading,     // if there is a LoadingView, use this ,and also this is a default status.
    EDK_None,        // if there is some data, use this.
    EDK_Empty,       // if there is no data, use this.
    EDK_Error        // if there is some error such as network, use this.
};
```

so that if you want to show different image or description words you can use this. before you use `reloadData` method of this tebleView or collectionView.

## Author

ProgramerSunny, cd_sunyang@163.com

## License

EmptyDataKit is available under the MIT license. See the LICENSE file for more info.
