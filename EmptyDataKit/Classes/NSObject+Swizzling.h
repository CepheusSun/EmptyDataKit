//
//  NSObject+Swizzling.h
//  EmptyDataKit   GitHub: https://github.com/CepheusSun/EmptyDataKit
//
//  Created by CepheusSun on 16/9/6.
//  Copyright © 2016年 CepheusSun. All rights reserved.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
@interface NSObject (Swizzling)

+ (void)methodSwizzlingWithOriginalSelector:(SEL)originalSelector
                         bySwizzledSelector:(SEL)swizzledSelector;

@end
