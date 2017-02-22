//
//  EmptyDataKit.m
//  EmptyDataKit   GitHub: https://github.com/CepheusSun/EmptyDataKit
//
//  Created by CepheusSun on 16/9/6.
//  Copyright © 2016年 CepheusSun. All rights reserved.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import "EmptyDataKit.h"
#import "UICollectionView+NoData.h"
#import "UITableView+NoData.h"
#import <BlocksKit/BlocksKit+UIKit.h>

#ifndef EDK_SCREEN_WIDTH
#define EDK_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#endif

@implementation EmptyDataKit

- (instancetype)initWithEdk_Image:(UIImage *)edk_Image
                      edk_Message:(NSString *)edk_Message
                edk_reloadHandler:(dispatch_block_t)reloadHandler {
    self = [super init];
    if (self) {
        self.edk_image = edk_Image;
        self.edk_message = edk_Message;
        self.edk_reloadHandler = [reloadHandler copy];
        self.edk_type = EDK_Loading;
    }
    return self;
}

- (void)edk_display:(UIScrollView *)widget {
    switch (self.edk_type) {
        case EDK_Loading:
            self.edk_type = EDK_Empty;
            break;
        case EDK_None:
            [self edk_displayWidget:widget ifData:YES reloadBlock:self.edk_reloadHandler];
            break;
        case EDK_Empty:
            [self edk_displayWidget:widget ifData:NO reloadBlock:self.edk_reloadHandler];
            break;
        case EDK_Error:
            [self edk_displayWidget:widget ifData:NO reloadBlock:self.edk_reloadHandler];
            break;
    }
}

#pragma mark - private
- (void)edk_displayWidget:(id)widget
               ifData:(BOOL)isData
          reloadBlock:(dispatch_block_t)reloadBlock {
    
    [widget setValue:@(isData) forKey:@"data"];
    
    if (!isData) {
        if (reloadBlock) {
            [widget setValue:reloadBlock forKey:@"touchBlock"];
        }
        
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                          0,
                                                                          EDK_SCREEN_WIDTH / 2,
                                                                          EDK_SCREEN_WIDTH / 2 + 100)];
        
        {
            UIImageView *imageView  = [[UIImageView alloc] init];
            if (self.edk_type == EDK_Error) {
                imageView.image = self.edk_error_image;
            }else {
                imageView.image = self.edk_image;
            }
            imageView.frame         = CGRectMake(0,
                                                 0,
                                                 EDK_SCREEN_WIDTH / 2,
                                                 EDK_SCREEN_WIDTH / 2);
            imageView.contentMode   = UIViewContentModeCenter;
            imageView.clipsToBounds = YES;
            imageView.center        = CGPointMake(EDK_SCREEN_WIDTH / 2, 100);
            [backgroundView addSubview:imageView];
        }
        
        {
            UILabel *messageLabel      = [[UILabel alloc] init];
            if (self.edk_type == EDK_Error) {
                messageLabel.text          = self.edk_error_message ? self.edk_error_message : @" ";
            }else {
                messageLabel.text          = self.edk_message ? self.edk_message : @" ";
            }
            messageLabel.font          = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
            messageLabel.textColor     = [UIColor lightGrayColor];
            messageLabel.textAlignment = NSTextAlignmentCenter;
            [messageLabel sizeToFit];
            messageLabel.center = CGPointMake(EDK_SCREEN_WIDTH / 2,
                                              EDK_SCREEN_WIDTH / 2 - 20);
            
            [backgroundView addSubview:messageLabel];
            [widget setValue:backgroundView forKey:@"backgroundView"];
            [widget setValue:@0 forKey:@"scrollEnabled"];
        }
        
    } else {
        [widget setValue:nil forKey:@"backgroundView"];
        [widget setValue:nil forKey:@"touchBlock"];
        [widget setValue:@1 forKey:@"scrollEnabled"];
    }
    
    __weak typeof(widget) weakWidget = widget;
    [[widget valueForKey:@"backgroundView"] bk_whenTapped:^{
        if ([weakWidget valueForKey:@"touchBlock"] && ![[weakWidget valueForKey:@"data"] boolValue]) {
            void (^newTouchBlock)() = [weakWidget valueForKey:@"touchBlock"];
            newTouchBlock();
        }
    }];
}

@end
