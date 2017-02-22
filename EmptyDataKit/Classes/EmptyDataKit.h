//
//  EmptyDataKit.h
//  EmptyDataKit   GitHub: https://github.com/CepheusSun/EmptyDataKit
//
//  Created by CepheusSun on 16/9/6.
//  Copyright © 2016年 CepheusSun. All rights reserved.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UITableView+NoData.h"
#import "UICollectionView+NoData.h"

typedef NS_ENUM(NSUInteger ,EmptyDataType) {
    EDK_Loading,     // if there is a LoadingView, use this ,and also this is a default status.
    EDK_None,        // if there is some data, use this.
    EDK_Empty,       // if there is no data, use this.
    EDK_Error        // if there is some error such as network, use this.
};

// use prptocol 'UIAppearance' and key word 'UI_APPEARANCE_SELECTOR' to configure a global property
@interface EmptyDataKit : NSObject

#pragma mark - empty data type

/**
 空数据类型，一般情况下，loading的时候是没有数据的，
 但是这个时候展示 没有数据 或者网络错误十分影响用户体验，
 这个时候展示 loadingview 或者其他什么都是没问题的
 所以默认是 ‘EDK_Loading’
 */
@property (nonatomic ,assign) EmptyDataType edk_type;

#pragma mark - message and image
@property (nonatomic ,strong) UIImage *edk_image;
@property (nonatomic ,copy) NSString *edk_message;

#pragma mark - error message and error image
@property (nonatomic ,copy) NSString *edk_error_message;
@property (nonatomic ,strong) UIImage *edk_error_image;

#pragma mark - empty view touched block.
@property (nonatomic ,copy) dispatch_block_t edk_reloadHandler;


#pragma mark - initialize method
- (instancetype)initWithEdk_Image:(UIImage *)edk_Image
                      edk_Message:(NSString *)edk_Message
                edk_reloadHandler:(dispatch_block_t)reloadHandler;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

#pragma mark - public method
- (void)edk_display:(UIScrollView *)widget;



@end
