//
//  YSTDialogBoxWindow.h
//  首页滑动DEMO
//
//  Created by admin on 2018/9/20.
//  Copyright © 2018年 ysepay. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YSTDialogBoxWindow : UIView



+ (instancetype)showWithDialogBoxBeginPoint:(CGPoint)DialogBoxBeginPoint textContent:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
