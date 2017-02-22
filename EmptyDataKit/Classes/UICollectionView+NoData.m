//
//  UICollectionView+NoData.m
//  EmptyDataKit   GitHub: https://github.com/CepheusSun/EmptyDataKit
//
//  Created by CepheusSun on 16/9/6.
//  Copyright © 2016年 CepheusSun. All rights reserved.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import "UICollectionView+NoData.h"
#import <objc/runtime.h>
#import "EmptyDataKit.h"
#import "NSObject+Swizzling.h"

@interface UICollectionView ()

@property (nonatomic, assign) BOOL data;
@property (nonatomic, copy) dispatch_block_t touchBlock;
@end
@implementation UICollectionView (NoData)


#pragma mark-- 关联属性
static const char *edk_dataKey = "edk_collectionView_data_Key";
- (BOOL)data {
    return [objc_getAssociatedObject(self, edk_dataKey) boolValue];
}

- (void)setData:(BOOL)data {
    objc_setAssociatedObject(self, edk_dataKey, @(data), OBJC_ASSOCIATION_ASSIGN);
}

static const char *edk_blockKey = "edk_collectionView_block_Key";
- (dispatch_block_t)touchBlock {
    return objc_getAssociatedObject(self, edk_blockKey);
}

- (void)setTouchBlock:(dispatch_block_t)touchBlock {
    objc_setAssociatedObject(self, edk_blockKey, touchBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma mark emptydatakit
static const char *edk_kit_Key = "edk_collectionView_kit_Key";
- (EmptyDataKit *)emptyKit {
    return objc_getAssociatedObject(self, edk_kit_Key);
}

- (void)setEmptyKit:(EmptyDataKit *)emptyKit {
    objc_setAssociatedObject(self, edk_kit_Key, emptyKit, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - method swizzing
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



@end
