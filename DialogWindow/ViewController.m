//
//  ViewController.m
//  DialogWindow
//
//  Created by admin on 2018/9/21.
//  Copyright © 2018年 ysepay. All rights reserved.
//

#import "ViewController.h"
#import "YSTDialogBoxController.h"
#import "YSTRippleAnimationController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initWithData];
  
}

- (void)initWithData{
    TableItem *item1 = [TableItem itmeWithTitle:@"弹出对话框" targetClassName:@"YSTDialogBoxController"];
    [self.dataArr addObject:item1];
    
    TableItem *item2 = [TableItem itmeWithTitle:@"波纹动画" targetClassName:@"YSTRippleAnimationController"];
    [self.dataArr addObject:item2];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ViewControllerCell" forIndexPath:indexPath];
    TableItem *item2 = self.dataArr[indexPath.row];
    cell.textLabel.text = item2.title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TableItem *item2 = self.dataArr[indexPath.row];
    
    UIViewController *controller = [NSClassFromString(item2.targetClassName) new];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        self.dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

@end

@implementation TableItem

+ (instancetype)itmeWithTitle:(NSString *)title targetClassName:(NSString *)targetClassName{
    
    TableItem *item = [[TableItem alloc] init];
    
    item.title = title;
    item.targetClassName = targetClassName;
    return item;
}
@end
