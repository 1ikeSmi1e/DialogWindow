//
//  YSTDialogBoxWindow.m
//  首页滑动DEMO
//
//  Created by admin on 2018/9/20.
//  Copyright © 2018年 ysepay. All rights reserved.
//

#import "YSTDialogBoxWindow.h"
#import "Masonry.h"
#import "AppDelegate.h"
#define MSWIDTH         [UIScreen mainScreen].bounds.size.width
#define MSHIGHT         CGRectGetHeight([UIScreen mainScreen].bounds)
#define RECT(x, y, w, h) CGRectMake(x, y, w, h)
#define RGB(R, G, B)    [UIColor colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:1.0]

@interface YSTDialogBoxWindow()

@property (nonatomic,assign) CGFloat DialogBoxBeginX;
@property (nonatomic,weak) UIImageView *imageView;
@property (nonatomic,weak) UILabel *textL;

@property (nonatomic,weak) UIView *touchBeginView;
@end

@implementation YSTDialogBoxWindow

- (instancetype)initWithFrame:(CGRect)frame BoxBeginPoint:(CGPoint)DialogBoxBeginPoint textContent:(NSString *)text{
    
    self = [super initWithFrame:RECT(0, 0, MSWIDTH, MSHIGHT)];
    if (self) {
        
        if (DialogBoxBeginPoint.x > MSWIDTH - 100) {
            
            DialogBoxBeginPoint.x = MSWIDTH - 100;
        }
        
        self.backgroundColor = UIColor.clearColor;
        
        CGFloat X = DialogBoxBeginPoint.x;
        CGFloat Y = DialogBoxBeginPoint.y - 5;
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:@"Mine_Settings_ bubble"];
        [self addSubview:imageView];
        
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(Y);
            make.left.equalTo(self.mas_left).with.offset(X);
            make.right.lessThanOrEqualTo(self.mas_right).with.offset(-40);
            make.height.mas_lessThanOrEqualTo(400);
        }];
        self.imageView = imageView;
        NSMutableAttributedString *attrsStr = [[NSMutableAttributedString alloc] initWithString:text];
        
        NSRange range1 = [text rangeOfString:@"<1000元"];
        NSRange range2 = [text rangeOfString:@"≥1000元"];
        
        UIColor *attrColor = RGB(50, 150, 240);
        [attrsStr addAttribute:NSForegroundColorAttributeName value:attrColor range:range1];
        [attrsStr addAttribute:NSForegroundColorAttributeName value:attrColor range:range2];
        
        UILabel *textL = [[UILabel alloc] init];
        textL.textColor = UIColor.grayColor;
        textL.font = [UIFont systemFontOfSize:12];
        textL.textAlignment = NSTextAlignmentLeft;
        [imageView addSubview:textL];
        [textL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imageView.mas_left).with.offset(8);
            make.top.equalTo(imageView.mas_top).with.offset(8);
            make.right.equalTo(imageView.mas_right).with.offset(-4);
            make.bottom.equalTo(imageView.mas_bottom).with.offset(-8);
            make.height.mas_lessThanOrEqualTo(400);
        }];
        textL.numberOfLines = 0;
        textL.attributedText = attrsStr;
        self.textL = textL;
        
    }
    
    return self;
}


+ (instancetype)showWithDialogBoxBeginPoint:(CGPoint)DialogBoxBeginPoint textContent:(NSString *)text{
    
    
    YSTDialogBoxWindow *window = [[YSTDialogBoxWindow alloc] initWithFrame:CGRectZero BoxBeginPoint:DialogBoxBeginPoint textContent:text];

    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appdelegate.window addSubview:window];
    window.imageView.alpha = 0;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CGRect realFrame = window.imageView.frame;
        window.imageView.frame = RECT(window.imageView.frame.origin.x, window.imageView.frame.origin.y, 0, 0);
        [UIView animateWithDuration:.15 delay:0 options:UIViewAnimationOptionCurveEaseOut  animations:^{
            window.imageView.frame = RECT(window.imageView.frame.origin.x, window.imageView.frame.origin.y, realFrame.size.width + 2, realFrame.size.height + 2);
            window.imageView.alpha = 1.0;
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:.1f animations:^{
                window.imageView.frame = realFrame;
            }];
        }];
    });
   
    
    return window;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    self.touchBeginView = nil;
    CGPoint touchPoint = [touches.anyObject locationInView:self];
    BOOL isTouchInTextLable = (touches.anyObject.view == self.textL) || CGRectContainsPoint(self.imageView.frame, touchPoint);
    if (touches.allObjects.count == 1 && isTouchInTextLable) {
        
        self.touchBeginView = self.textL;
        [UIView animateWithDuration:.15 animations:^{
            
            self.imageView.transform = CGAffineTransformMakeScale(1.3, 1.3);
        }];
       
        return;
    }
    
    [self removeFromSuperview];
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.touchBeginView == self.textL) {
        // 负责缩小
        [UIView animateWithDuration:.15 animations:^{
            self.imageView.transform = CGAffineTransformIdentity;
        }];
    }
}

@end
