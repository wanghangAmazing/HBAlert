//
//  HBAlertAnimation.m
//  HBAlert
//
//  Created by Patrick W on 2017/11/22.
//  Copyright © 2017年 P.W. All rights reserved.
//

#import "HBAlertAnimation.h"
#import "HBPresentationController.h"
#import "HBAlertController.h"

@interface HBAlertAnimation ()

@property (assign, nonatomic) HBAlertAnimationType animationType;

@end


@implementation HBAlertAnimation

+ (HBAlertAnimation *)animationWithType:(HBAlertAnimationType)type {
    HBAlertAnimation *alertAnimation = [HBAlertAnimation new];
    alertAnimation.animationType = type;
    return alertAnimation;
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    if (self.animationType == HBAlertAnimationTypeShow) {
        //出现的动画时间
        return [(HBAlertController *)toViewController showAnimationDuration];
    } else {
        //消失的动画时间
        return [(HBAlertController *)fromViewController dismissAnimationDuration];
    }
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    if (self.animationType == HBAlertAnimationTypeShow) {
        //出现的动画
        [self showAnimationAlertController:(HBAlertController *)toViewController transition:transitionContext];
    } else {
        //消失的动画
        [self dismissAnimationAlertController:(HBAlertController *)fromViewController transition:transitionContext];
    }
    
}

- (void)showAnimationAlertController:(HBAlertController *)alertViewController transition:(id<UIViewControllerContextTransitioning>)transitionContext {
    HBAlertAnimationOption showOption = alertViewController.showAnimationOption;
    [transitionContext.containerView addSubview:alertViewController.view];
    if (showOption == HBAlertAnimationOptionAlpha) {
        [self alphaInWithAlertController:alertViewController transition:transitionContext];
    } else if (showOption == HBAlertAnimationOptionTopIn) {
        [self topInWithAlertController:alertViewController transition:transitionContext];
    } else if (showOption == HBAlertAnimationOptionBottomIn) {
        [self bottomInWithAlertController:alertViewController transition:transitionContext];
    } else if (showOption == HBAlertAnimationOptionLeftIn) {
        [self leftInWithAlertController:alertViewController transition:transitionContext];
    } else if (showOption == HBAlertAnimationOptionRightIn) {
        [self rightInWithAlertController:alertViewController transition:transitionContext];
    } else if (showOption == HBAlertAnimationOptionCenterSpringIn) {
        [self centerSpringInWithAlertController:alertViewController transition:transitionContext];
    } else {
        [transitionContext completeTransition:YES];
    }
}

- (void)dismissAnimationAlertController:(HBAlertController *)alertViewController transition:(id<UIViewControllerContextTransitioning>)transitionContext {
    HBAlertAnimationOption dismissOption = alertViewController.dismissAnimationOption;
    if (dismissOption == HBAlertAnimationOptionAlpha) {
        [self alphaOutWithAlertController:alertViewController transition:transitionContext];
    } else if (dismissOption == HBAlertAnimationOptionTopOut) {
        [self topOutWithAlertController:alertViewController transition:transitionContext];
    } else if (dismissOption == HBAlertAnimationOptionBottomOut) {
        [self bottomOutWithAlertController:alertViewController transition:transitionContext];
    } else if (dismissOption == HBAlertAnimationOptionLeftOut) {
        [self leftOutWithAlertController:alertViewController transition:transitionContext];
    } else if (dismissOption == HBAlertAnimationOptionRightOut) {
        [self rightOutWithAlertController:alertViewController transition:transitionContext];
    } else if (dismissOption == HBAlertAnimationOptionCenterSpringOut) {
        [self centerSpringOutWithAlertController:alertViewController transition:transitionContext];
    } else {
        [transitionContext completeTransition:YES];
    }
}

#pragma mark - 出现的动画

- (void)alphaInWithAlertController:(HBAlertController *)alertViewController transition:(id<UIViewControllerContextTransitioning>)transitionContext {
    alertViewController.view.alpha = 0.1;
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        alertViewController.view.alpha = 1.0;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

- (void)topInWithAlertController:(HBAlertController *)alertViewController transition:(id<UIViewControllerContextTransitioning>)transitionContext {
    CGRect viewFrame = alertViewController.view.frame;
    alertViewController.view.transform = CGAffineTransformMakeTranslation(0, -CGRectGetMaxY(viewFrame));
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        alertViewController.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

- (void)leftInWithAlertController:(HBAlertController *)alertViewController transition:(id<UIViewControllerContextTransitioning>)transitionContext {
    CGRect viewFrame = alertViewController.view.frame;
    alertViewController.view.transform = CGAffineTransformMakeTranslation(-CGRectGetMaxX(viewFrame), 0);
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        alertViewController.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

- (void)bottomInWithAlertController:(HBAlertController *)alertViewController transition:(id<UIViewControllerContextTransitioning>)transitionContext {
    CGRect viewFrame = alertViewController.view.frame;
    alertViewController.view.transform = CGAffineTransformMakeTranslation(0, CGRectGetHeight(transitionContext.containerView.frame) - viewFrame.origin.y);
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        alertViewController.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

- (void)rightInWithAlertController:(HBAlertController *)alertViewController transition:(id<UIViewControllerContextTransitioning>)transitionContext {
    CGRect viewFrame = alertViewController.view.frame;
    alertViewController.view.transform = CGAffineTransformMakeTranslation(CGRectGetWidth(transitionContext.containerView.frame) - viewFrame.origin.x, 0);
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        alertViewController.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

- (void)centerSpringInWithAlertController:(HBAlertController *)alertViewController transition:(id<UIViewControllerContextTransitioning>)transitionContext {
    alertViewController.view.transform = CGAffineTransformMakeScale(0.1, 0.1);
    alertViewController.view.alpha = 0.0;
    [transitionContext.containerView addSubview:alertViewController.view];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.f usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
        alertViewController.view.transform = CGAffineTransformIdentity;
        alertViewController.view.alpha = 1.0;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

#pragma mark - 消失的动画

- (void)alphaOutWithAlertController:(HBAlertController *)alertViewController transition:(id<UIViewControllerContextTransitioning>)transitionContext {
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        alertViewController.view.alpha = 0.1;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

- (void)topOutWithAlertController:(HBAlertController *)alertViewController transition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        alertViewController.view.transform = CGAffineTransformMakeTranslation(0, -CGRectGetMaxY(alertViewController.view.frame));
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

- (void)leftOutWithAlertController:(HBAlertController *)alertViewController transition:(id<UIViewControllerContextTransitioning>)transitionContext {
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        alertViewController.view.transform = CGAffineTransformMakeTranslation(-CGRectGetMaxX(alertViewController.view.frame), 0);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

- (void)bottomOutWithAlertController:(HBAlertController *)alertViewController transition:(id<UIViewControllerContextTransitioning>)transitionContext {
    CGRect viewFrame = alertViewController.view.frame;
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        alertViewController.view.transform = CGAffineTransformMakeTranslation(0, CGRectGetHeight(transitionContext.containerView.frame) - viewFrame.origin.y);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

- (void)rightOutWithAlertController:(HBAlertController *)alertViewController transition:(id<UIViewControllerContextTransitioning>)transitionContext {
    CGRect viewFrame = alertViewController.view.frame;
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        alertViewController.view.transform = CGAffineTransformMakeTranslation(CGRectGetWidth(transitionContext.containerView.frame) - viewFrame.origin.x, 0);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

- (void)centerSpringOutWithAlertController:(HBAlertController *)alertViewController transition:(id<UIViewControllerContextTransitioning>)transitionContext {
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        alertViewController.view.transform = CGAffineTransformMakeScale(0.1, 0.1);
        alertViewController.view.alpha = 0.f;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
    
}
@end
