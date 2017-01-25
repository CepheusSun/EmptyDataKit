# EmptyDataKit

抽空写了一个小东西[**EmptyDataKit**](https://github.com/ProgramerSunny/EmptyDataKit)，可以很轻松的集成UITableView 和 UICollectionView 在数据源没有数据的时候展示一个默认占位图片。

<!--more-->

## gif

<img src="http://ocg4av0wv.bkt.clouddn.com/ProgramerSunnyDemo.gif" width= "400" />

另外这个工具也被我添加进了我来一个叫做`SBAnimation`的仓库中,而且`SBAnimation`中的demo代码更干净和间接，而且完整的示范了这个工具的使用方法。由于精力有限，暂时还没有动力将这里的demo代码替换。所以我也将`SBAnimation`中的截图放到这里来。如果需要的话可以过去看看。[地址](https://github.com/SolarBee/SBAnimation)

<img src="http://ojno1pj4x.bkt.clouddn.com/EmptyDataKit.gif">



## 使用
**0、**框架依赖与`BlocksKit`请在`podfile`中添加`pod 'BlocksKit'`并且在终端执行`pod install --no-repo-update`。如果直接拖进你的工程记得添加 pod BlocksKit

**1、**首先 `pod 'EmptyDataKit'`

**2、**导入头文件`#import <EmptyDataKit/EmptyDataKit.h>`

**3、**在`viewdidload`中添加如下代码

```objective-c
    {
        __weak typeof(self) weakSelf = self;
        EmptyDataKit *kit = [[EmptyDataKit alloc] initWithEdk_Image:[UIImage imageNamed:@"common_pic_loadFail"] edk_Message:@"aaa" edk_reloadHandler:^{
            [weakSelf getData];
        }];
        kit.edk_error_image = [UIImage imageNamed: @""];
        kit.edk_error_message = @"网络错误";
        self.tableView.emptyKit = kit;
    }
```
至此，EmptyDataKit集成成功!   `UIcollectionView`使用方法同理。

另外`EmptyDataKit`有如下枚举

```objective-c
typedef NS_ENUM(NSUInteger ,EmptyDataType) {
    EDK_Loading,     // if there is a LoadingView, use this ,and also this is a default status.
    EDK_None,        // if there is some data, use this.
    EDK_Empty,       // if there is no data, use this.
    EDK_Error        // if there is some error such as network, use this.
};
```

这样在`reloadData`之前给`self.tableView.emptyKit.edk_type`赋值即可区分在不同状态下的不同展示情况。

## 实现原理

思路方面，我给`UITableView`和`UIColectionView`分别添加了两个Category, 并且通过runtime给两个类都关联了两个属性`data` 、 `touchBlock` 和`emptyKit`。

```
@property (nonatomic, assign) BOOL data;
@property (nonatomic, copy) TouchBlock touchBlock;
@property (nonatomic, strong) EmptyDataKit *emptyKit;
```
分别表示是否有数据和一个空数据的时候点击空白部分回调刷新的部分。

考虑到我想同时兼容UITableView 和 UICollectionView 所以我提取了一个object `EmptyDataKit`。

之前的调用方式是在`numberOfSectionsInTableView`方法中调用EmptyDataKit，并且是一个类方法，在新的框架下，EmptyDataKit 作为 TableView 的属性在设置的时候更加自主。

并且通过`MethodSwizzling`在 `tableView` 的 `reloadData` 方法中激发 `EmptyDataKit`,减少了很多调用次数。

```objective-c
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self methodSwizzlingWithOriginalSelector:@selector(reloadData)
                               bySwizzledSelector:@selector(sure_reloadData)];
    });
}

- (void)sure_reloadData {
    [self.emptyKit edk_display:self];
//    id <UITableViewDataSource> dataSource = self.dataSource;
    [self sure_reloadData];
}
```

## TODO：

~~1. 添加CocoaPods 支持。~~
2. 进一步规范文档。
3. 移除对BlocksKit的依赖。

