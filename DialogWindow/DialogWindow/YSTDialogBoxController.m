//
//  YSTDialogBoxController.m
//  首页滑动DEMO
//
//  Created by admin on 2018/9/20.
//  Copyright © 2018年 ysepay. All rights reserved.
//

#import "YSTDialogBoxController.h"
#import "YSTDialogBoxWindow.h"

#import "AppDelegate.h"

@interface YSTDialogBoxController ()

@property (weak, nonatomic) IBOutlet UIImageView *infoImgV;
@property (nonatomic, strong) UIView *dialogView;
@property (weak, nonatomic) IBOutlet UIView *cell;
@end

@implementation YSTDialogBoxController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSStringFromClass([self class]);
}



- (IBAction)quickInfoTapped:(UITapGestureRecognizer *)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    CGPoint beginPoint = [self.cell convertPoint:CGPointMake(CGRectGetMaxX(self.infoImgV.frame) , self.infoImgV.frame.origin.y) toView:appDelegate.window];
    NSString *text = @"收款金额<1000元， 请手动提现；\n收款金额≥1000元，可快速到账";
    [YSTDialogBoxWindow showWithDialogBoxBeginPoint:beginPoint textContent:text];
}

@end
