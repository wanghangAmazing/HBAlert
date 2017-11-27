//
//  HBPresentationController.m
//  HBAlert
//
//  Created by Patrick W on 2017/11/22.
//  Copyright © 2017年 P.W. All rights reserved.
//

#import "HBPresentationController.h"
#import "HBAlertController.h"
#import <Masonry.h>

@implementation HBPresentationController

- (void)presentationTransitionWillBegin {
    /**
     *  根据苹果的api，演示期间添加自定义视图
     *  这里参考UIAlertController的层级关系
     */
    HBAlertController *alertViewController = (HBAlertController *)self.presentedViewController;
    self.coverView = alertViewController.coverView;
    [self.containerView addSubview:self.coverView];
    [self.coverView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    if (alertViewController.hideWhenTouchBlank) {
        //  添加点击事件
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(currentViewControllerDiss)];
        [self.coverView addGestureRecognizer:tap];
    }
    
    [super presentationTransitionWillBegin];
}


- (UIView *)coverView {
    if (!_coverView) {
        _coverView = [[UIView alloc] init];
        _coverView.backgroundColor = [UIColor blackColor];
        _coverView.alpha = 0.3;
    }
    return _coverView;
}

- (void)currentViewControllerDiss {
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}



@end
