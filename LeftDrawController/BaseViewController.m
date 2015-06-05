//
//  BaseViewController.m
//  LeftDrawController
//
//  Created by Henry on 15/6/4.
//  Copyright (c) 2015年 Henry. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
@property(nonatomic, strong) UIView *titleView;
@property(nonatomic, strong) UIButton *menuButton;
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.titleView];
    [self.titleView addSubview:self.titleLabel];
    [self.titleView addSubview:self.menuButton];
    
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    self.view.layer.shadowRadius = 5;
    self.view.layer.shadowOpacity = 0.8;
    self.view.layer.shadowOffset = CGSizeMake(-2, -2);
}

- (void)menuButtonAction
{
    if (self.menuButtonSelectedBlock) {
        self.menuButtonSelectedBlock();
    }
}

#pragma mark - Lazy Load

- (UIView *)titleView
{
    if (!_titleView) {
        _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 64)];
        _titleView.backgroundColor = [UIColor grayColor];
    }
    return _titleView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        CGRect frame = self.titleView.bounds;
        frame.origin.y = 20;
        frame.size.height -= 20;
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectInset(frame, 80, 0)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont boldSystemFontOfSize:25];
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

- (UIButton *)menuButton
{
    if (!_menuButton) {
        _menuButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 20, 40, 40)];
        [_menuButton addTarget:self action:@selector(menuButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_menuButton setBackgroundColor:[UIColor orangeColor]];
        [_menuButton.layer setMasksToBounds:YES];
        [_menuButton.layer setCornerRadius:20];
    }
    return _menuButton;
}
@end
