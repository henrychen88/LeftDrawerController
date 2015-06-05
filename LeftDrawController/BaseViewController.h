//
//  BaseViewController.h
//  LeftDrawController
//
//  Created by Henry on 15/6/4.
//  Copyright (c) 2015年 Henry. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MenuButtonSelectedBlock) (void);

@interface BaseViewController : UIViewController

@property(nonatomic, strong) UILabel *titleLabel;

@property(nonatomic, copy) MenuButtonSelectedBlock menuButtonSelectedBlock;
- (void)setMenuButtonSelectedBlock:(MenuButtonSelectedBlock)menuButtonSelectedBlock;

- (void)menuButtonAction;

@end
