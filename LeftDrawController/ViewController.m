//
//  ViewController.m
//  LeftDrawController
//
//  Created by Henry on 15/6/4.
//  Copyright (c) 2015年 Henry. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"

static const CGFloat tableViewMaxScale = 1.3;

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) FirstViewController *firstViewController;
@property(nonatomic, strong) SecondViewController *secondViewController;
@property(nonatomic, strong) ThirdViewController *thirdViewController;
@property(nonatomic, strong) NSArray *menus;
@property(nonatomic, strong) UIViewController *selectedViewController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.menus = @[@"主界面", @"设备列表", @"发现", @"消息", @"设置", @"帮助",  @"关于"];
    
    [self.view addSubview:self.tableView];
    
    [self addChildViewController:self.firstViewController];
    [self.firstViewController didMoveToParentViewController:self];
    [self.view addSubview:self.firstViewController.view];
    self.selectedViewController = self.firstViewController;
}

- (void)adjustFrame
{
    CGRect frame = self.selectedViewController.view.frame;
    CGFloat scale = 1;
    CGFloat tableViewScale = tableViewMaxScale;
    CGFloat offset = CGRectGetWidth(self.view.bounds) * 0.7;
    if (frame.origin.x < 20) {
        scale = 0.8;
        tableViewScale = 1;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        /**
         *  这里如果使用frame的变化＋transform会导致返回的时候位置不对
         *  所以就统一用transform的组合动画
         *  位移的0 缩放对1 均表示为原始状态
         */
        CGAffineTransform transform = CGAffineTransformMakeTranslation((scale < 0.9 ? offset : 0), 0);
        self.selectedViewController.view.transform = CGAffineTransformScale(transform, scale, scale);
        self.tableView.transform = CGAffineTransformMakeScale((tableViewScale > 1 ? tableViewScale + 0.2 : tableViewScale), tableViewScale);
        
    } completion:^(BOOL finished) {
        
    }];
    
    NSLog(@"%@", self.childViewControllers);
    NSLog(@"%@", self.view.subviews);
}

- (void)showViewControllerByIndex:(NSInteger)index
{
    switch (index % 3) {
        case 0:
            [self showFirstViewController];
            break;
        case 1:
            [self showSecondViewController];
            break;
        case 2:
            [self showThirdViewController];
            break;
        default:
            break;
    }
}

- (void)showFirstViewController
{
    [self removeSelectedView];
    [self addChildViewController:self.firstViewController];
    [self.firstViewController didMoveToParentViewController:self];
    [self.view addSubview:self.firstViewController.view];
    self.selectedViewController = self.firstViewController;
    [self adjustFrame];
}

- (void)showSecondViewController
{
    [self removeSelectedView];
    NSLog(@"%@", self.presentedViewController);
    [self addChildViewController:self.secondViewController];
    [self.secondViewController didMoveToParentViewController:self];
    [self.view addSubview:self.secondViewController.view];
    self.selectedViewController = self.secondViewController;
    [self adjustFrame];
}

- (void)showThirdViewController
{
    [self removeSelectedView];
    [self addChildViewController:self.thirdViewController];
    [self.thirdViewController didMoveToParentViewController:self];
    [self.view addSubview:self.thirdViewController.view];
    self.selectedViewController = self.thirdViewController;
    [self adjustFrame];
}

- (void)removeSelectedView
{
    if (self.selectedViewController) {
        [self.selectedViewController willMoveToParentViewController:nil];
        [self.selectedViewController.view removeFromSuperview];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 150;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds) * 0.6, 150 )];
    view.backgroundColor = [UIColor clearColor];
    
    CGFloat size = 80;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, size, size)];
    imageView.image = [UIImage imageNamed:@"avator"];
    imageView.center = CGPointMake(CGRectGetWidth(self.view.bounds) * 0.3, 80);
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = size / 2;
    imageView.layer.borderWidth = 2;
    imageView.layer.borderColor = [UIColor grayColor].CGColor;
    
    [view addSubview:imageView];
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(imageView.frame) + CGRectGetMinY(imageView.frame), CGRectGetWidth(self.view.bounds) * 0.6, 30)];
    nameLabel.textColor = [UIColor purpleColor];
    nameLabel.text = @"J24129114";
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:nameLabel];
    
    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.menus.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CGRect frame = cell.contentView.frame;
    frame.size.width = CGRectGetWidth(self.view.bounds) * 0.6;
    frame.size.height = tableView.rowHeight;
    UILabel *lable = [[UILabel alloc] initWithFrame:frame];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.font = [UIFont systemFontOfSize:20];
    lable.text = self.menus[indexPath.row];
    lable.textColor = [UIColor whiteColor];
    
    [cell.contentView addSubview:lable];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self showViewControllerByIndex:indexPath.row];
}

# pragma mark - Lazy load

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 55;
        _tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollEnabled = NO;
        _tableView.transform = CGAffineTransformMakeScale(tableViewMaxScale + 0.2, tableViewMaxScale);
    }
    return _tableView;
}

- (FirstViewController *)firstViewController
{
    if (!_firstViewController) {
        __block ViewController *blockSelf = self;
        _firstViewController = [[FirstViewController alloc]init];
        [_firstViewController setMenuButtonSelectedBlock:^{
            [blockSelf adjustFrame];
        }];
    }
    return _firstViewController;
}

- (SecondViewController *)secondViewController
{
    if (!_secondViewController) {
        __block ViewController *blockSelf = self;
        _secondViewController = [[SecondViewController alloc]init];
        CGAffineTransform transform = CGAffineTransformMakeTranslation(CGRectGetWidth(self.view.bounds) * 0.7, 0);
        _secondViewController.view.transform = CGAffineTransformScale(transform, 0.8, 0.8);
        [_secondViewController setMenuButtonSelectedBlock:^{
            [blockSelf adjustFrame];
        }];
    }
    return _secondViewController;
}

- (ThirdViewController *)thirdViewController
{
    if (!_thirdViewController) {
        __block ViewController *blockSelf = self;
        _thirdViewController = [[ThirdViewController alloc]init];
        CGAffineTransform transform = CGAffineTransformMakeTranslation(CGRectGetWidth(self.view.bounds) * 0.7, 0);
        _thirdViewController.view.transform = CGAffineTransformScale(transform, 0.8, 0.8);
        [_thirdViewController setMenuButtonSelectedBlock:^{
            [blockSelf adjustFrame];
        }];
    }
    return _thirdViewController;
}

@end
