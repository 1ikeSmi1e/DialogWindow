//
//  ViewController.h
//  DialogWindow
//
//  Created by admin on 2018/9/21.
//  Copyright © 2018年 ysepay. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController


@end


@interface TableItem : NSObject

+ (instancetype)itmeWithTitle:(NSString *)title targetClassName:(NSString *)targetClassName;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *targetClassName;
@end
