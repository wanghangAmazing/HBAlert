//
//  HBAlertController.m
//  HBAlert
//
//  Created by Patrick W on 2017/11/22.
//  Copyright © 2017年 P.W. All rights reserved.
//

#import "HBAlertController.h"
#import "HBAlertAnimation.h"
#import "HBPresentationController.h"
#import <Masonry.h>

@interface HBAlertController ()<UIViewControllerTransitioningDelegate>

@property (strong, nonatomic) UIScrollView *alertContentScrollView;

@end

@implementation HBAlertController

- (instancetype)initWithPositon:(HBAlertPosition)position alertOffSet:(CGPoint)alertOffSet {
    self = [super init];
    if (self) {
        self.definesPresentationContext = YES;
        self.providesPresentationContextTransitionStyle = YES;
        //视图转场
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = self;
        self.hideWhenTouchBlank = YES;
        self.alertSideMargin = 0.f;
        self.position = position;
        self.alertOffset = alertOffSet;
        self.showAnimationDuration = 0.3;
        self.dismissAnimationDuration = 0.3;
    }
    return self;
}

#pragma mark - Super

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubviews];
    [self addNotifications];
}

- (void)dealloc {
    [self removeNotifications];
}

- (void)updateViewConstraints {
    //  更新约束
    CGPoint origin = [self viewOrigin];
    [self.view mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(origin.y);
        make.leading.mas_equalTo(origin.x);
        make.size.mas_equalTo([self fixSelfSize]);
    }];
    
    [super updateViewConstraints];
}

- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
    !self.alertWillDismissHandler ?: self.alertWillDismissHandler();
    [super dismissViewControllerAnimated:flag completion:^{
        !completion ?: completion();
        !self.alertDidDismissHandler ?: self.alertDidDismissHandler();
    }];
}

#pragma mark - Private Method

- (void)setupSubviews {
    //  设置背景视图
    [self.view addSubview:self.backgroundView];
    //  设置内容视图
    [self.view addSubview:self.alertContentScrollView];
    //  添加子视图
    [self.alertContentScrollView addSubview:self.customContentView];
    //  添加约束
    [self makeConstaints];
}

- (void)makeConstaints {
    
    [self.backgroundView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [self.alertContentScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [self.customContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.trailing.mas_equalTo(0);
        make.size.mas_equalTo([self fixCustomContentViewSize]);
    }];
}

#pragma mark - Notification Method

- (void)addNotifications {
    //  注册通知，监听屏幕的转屏事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChangeNotificationAction) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)removeNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}

#pragma mark - Action Method

- (void)deviceOrientationDidChangeNotificationAction {
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Getter Method

- (CGSize)fixCustomContentViewSize {
    //  获取自定义视图的size
    if (CGSizeEqualToSize(self.customContentView.frame.size, CGSizeZero)) {
        CGSize fixSize = [self.customContentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        if (CGSizeEqualToSize(fixSize, CGSizeZero)) {
            return CGSizeMake(50, 50);
        }
        return fixSize;
    }
    return self.customContentView.frame.size;
}

- (CGSize)fixSelfSize {
    CGSize fixSize = [self fixCustomContentViewSize];
    //  宽度计算
    CGFloat maxWidth = MIN(CGRectGetWidth([[UIScreen mainScreen] bounds]), CGRectGetHeight([[UIScreen mainScreen] bounds]));
    if (self.position == HBAlertPositionCenter || self.position == HBAlertPositionTop || self.position == HBAlertPositionBottom) {
        maxWidth -= self.alertSideMargin * 2;
    }
    maxWidth = MIN(maxWidth, fixSize.width);
    maxWidth = MAX(maxWidth, 50.f);
    //  高度计算
    CGFloat maxHeight = CGRectGetHeight([[UIScreen mainScreen] bounds]);
    if (self.position == HBAlertPositionRight || self.position == HBAlertPositionLeft) {
        maxHeight -= self.alertSideMargin * 2;
    }
    maxHeight = MIN(maxHeight, fixSize.height);
    maxHeight = MAX(maxHeight, 50.f);
    
    return CGSizeMake(maxWidth, maxHeight);
}

- (CGPoint)viewOrigin {
    
    CGSize viewSize = [self fixSelfSize];
    CGFloat mainScreenWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat mainScreenHeight = CGRectGetHeight([[UIScreen mainScreen] bounds]);
    CGFloat originX = (mainScreenWidth - viewSize.width) / 2.0;
    CGFloat originY = (mainScreenHeight - viewSize.height) / 2.0;
    
    if (self.position == HBAlertPositionTop) {
        return CGPointMake( originX + self.alertOffset.x, self.alertOffset.y);
    } else if (self.position == HBAlertPositionLeft) {
        return CGPointMake(self.alertOffset.x, originY + self.alertOffset.y);
    } else if (self.position == HBAlertPositionBottom) {
        return CGPointMake(self.alertOffset.x + originX, mainScreenHeight - viewSize.height + self.alertOffset.y);
    } else if (self.position == HBAlertPositionRight) {
        return CGPointMake(mainScreenWidth - viewSize.width + self.alertOffset.x, originY + self.alertOffset.y);
    } else {
        
    }
    return CGPointMake(originX + self.alertOffset.x, originY + self.alertOffset.y);
}

#pragma mark - Setter Method

- (void)setupShowAnimation:(HBAlertAnimationOption)showAnimation dismissAnimation:(HBAlertAnimationOption)dismissAnimation {
    _showAnimationOption = showAnimation;
    _dismissAnimationOption = dismissAnimation;
}

#pragma mark - Lazy Load

- (UIView *)backgroundView {
    if (!_backgroundView) {
        //  默认为一张毛玻璃效果
        UIBlurEffect *blureffrct = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        _backgroundView = [[UIVisualEffectView alloc] initWithEffect:blureffrct];
    }
    return _backgroundView;
}

- (UIScrollView *)alertContentScrollView {
    if (!_alertContentScrollView) {
        _alertContentScrollView = [[UIScrollView alloc] init];
    }
    return _alertContentScrollView;
}

#pragma mark - UIViewControllerTransitioningDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    //  视图出现的动画
    return [HBAlertAnimation animationWithType:HBAlertAnimationTypeShow];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    //  视图消失的动画
    return [HBAlertAnimation animationWithType:HBAlertAnimationTypeDisMiss];
}

- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source {
    return [[HBPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

@end
