//
//  HBAlertAnimation.h
//  HBAlert
//
//  Created by Patrick W on 2017/11/22.
//  Copyright © 2017年 P.W. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HBAlertAnimationType) {
    HBAlertAnimationTypeShow,
    HBAlertAnimationTypeDisMiss,
};

@interface HBAlertAnimation : NSObject<UIViewControllerAnimatedTransitioning>

+ (HBAlertAnimation *)animationWithType:(HBAlertAnimationType)type;

@end
