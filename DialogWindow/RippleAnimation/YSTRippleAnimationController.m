//
//  YSTRippleAnimationController.m
//  首页滑动DEMO
//
//  Created by admin on 2018/9/11.
//  Copyright © 2018年 ysepay. All rights reserved.
//

#import "YSTRippleAnimationController.h"
//#import "YSTRippleView.h"

@interface YSTRippleAnimationController ()

@property (weak, nonatomic) IBOutlet UIButton *btn;
@end

@implementation YSTRippleAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initView];
}

static CGFloat const btnwidth = 40.f;

- (void)initView {
    
    /*
     1. 第一个圈缩小一下然后弹回
     2. 第二个圈出现并且往外扩散，透明度升高
     3. 第三个圈在第二个圈出现了一半时间的时候出现并且向外扩散
     */
//    self.view.backgroundColor = [UIColor colorWithRed:50/255.f green:150/255.f blue:240/255.f alpha:1.0];
}

- (IBAction)beginAnimation:(id)sender {
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:.05 animations:^{
       
        weakSelf.btn.transform = CGAffineTransformMakeScale(.95, .95);
    } completion:^(BOOL finished) {
        
        // 1. 回弹动画
        [UIView animateWithDuration:.05 animations:^{
            
            weakSelf.btn.transform = CGAffineTransformIdentity;
        }];
        
        // 2. 产生一个光圈开始向外扩散
        [weakSelf generateARippleWithCompletion:^{
            NSLog(@"第一个光圈结束扩散动画");
        }];
        
        // 3. 产生另一个光圈开始向外扩散
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [weakSelf generateARippleWithCompletion:^{
                NSLog(@"第二个光圈结束扩散动画");
                // 继续动画
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakSelf beginAnimation:nil];
                });
                
            }];
        });
    }];
}

// 产生一个光圈开始向外扩散
- (void)generateARippleWithCompletion:(void (^)(void))completion{
    
    UIView *rippleView = [[UIView alloc] init];
    rippleView.frame = self.btn.frame;
    rippleView.layer.cornerRadius = btnwidth/2;
    rippleView.layer.masksToBounds = YES;
    rippleView.layer.borderColor = UIColor.whiteColor.CGColor;
    rippleView.layer.borderWidth = 1.f;
    [self.view addSubview:rippleView];
    rippleView.layer.shouldRasterize = YES;
    rippleView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    [UIView animateWithDuration:.5 delay:0.f options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        rippleView.transform = CGAffineTransformMakeScale(1.83, 1.83);
        rippleView.alpha = 0.f;
    } completion:^(BOOL finished) {
        completion();
        [rippleView removeFromSuperview];
    }];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
