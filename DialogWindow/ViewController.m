//
//  ViewController.m
//  DialogWindow
//
//  Created by admin on 2018/9/21.
//  Copyright © 2018年 ysepay. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

#import "YSTDialogBoxWindow.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *infoImgV;
@property (nonatomic, strong) UIView *dialogView;
@property (weak, nonatomic) IBOutlet UIView *cell;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
}


- (IBAction)quickInfoTapped:(UITapGestureRecognizer *)sender {
    
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    CGPoint beginPoint = [self.cell convertPoint:CGPointMake(CGRectGetMaxX(self.infoImgV.frame), self.infoImgV.frame.origin.y) toView:appdelegate.window];
    NSString *text = @"收款金额<1000元， 请手动提现；\n收款金额≥1000元，可快速到账";
    [YSTDialogBoxWindow showWithDialogBoxBeginPoint:beginPoint textContent:text];
}

@end
