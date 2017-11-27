//
//  HBAlertController.h
//  HBAlert
//
//  Created by Patrick W on 2017/11/22.
//  Copyright © 2017年 P.W. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HBAlertPosition) {
    HBAlertPositionCenter,
    HBAlertPositionTop,
    HBAlertPositionLeft,
    HBAlertPositionBottom,
    HBAlertPositionRight
};

typedef NS_ENUM(NSInteger, HBAlertAnimationOption) {
    /**通用动画*/
    HBAlertAnimationOptionNone,
    HBAlertAnimationOptionAlpha,
    /**显示动画*/
    HBAlertAnimationOptionTopIn,
    HBAlertAnimationOptionBottomIn,
    HBAlertAnimationOptionLeftIn,
    HBAlertAnimationOptionRightIn,
    HBAlertAnimationOptionCenterSpringIn,
    /**消失动画*/
    HBAlertAnimationOptionTopOut,
    HBAlertAnimationOptionBottomOut,
    HBAlertAnimationOptionLeftOut,
    HBAlertAnimationOptionRightOut,
    HBAlertAnimationOptionCenterSpringOut
};

@interface HBAlertController : UIViewController

/**
 初始化方法
 @param position 视图的位置
 @param alertOffSet 偏移
 @return HBAlertController
 */
- (instancetype)initWithPositon:(HBAlertPosition)position alertOffSet:(CGPoint)alertOffSet;

/**点击空白部分视图消失，默认为YES*/
@property (assign, nonatomic) BOOL hideWhenTouchBlank;
/**背景视图*/
@property (strong, nonatomic) UIView *backgroundView;
/**自定义的背景蒙层*/
@property (strong, nonatomic) UIView *coverView;
/**自定义的内容视图*/
@property (strong, nonatomic) UIView *customContentView;
/**两侧的留白, 默认为0*/
@property (assign, nonatomic) CGFloat alertSideMargin;
/**视图的偏移量, 默认为CGPointZero*/
@property (assign, nonatomic) CGPoint alertOffset;
/**视图的显示位置，默认为显示在中心点*/
@property (assign, nonatomic) HBAlertPosition position;
/**出现的动画，默认为无动画*/
@property (assign, nonatomic, readonly) HBAlertAnimationOption showAnimationOption;
/**消失的动画，默认为无动画*/
@property (assign, nonatomic, readonly) HBAlertAnimationOption dismissAnimationOption;
/**出现的动画时间，默认为0.3s，当showAnimationOption == HBAlertAnimationOptionNone时，此属性无效*/
@property (assign, nonatomic) NSTimeInterval showAnimationDuration;
/**消失的动画时间，默认为0.3s，当dismissAnimationOption == HBAlertAnimationOptionNone时，此属性无效*/
@property (assign, nonatomic) NSTimeInterval dismissAnimationDuration;
/**alertController将要dismiss*/
@property (copy, nonatomic) void(^alertWillDismissHandler)(void);
/**alertController dismiss完成*/
@property (copy, nonatomic) void(^alertDidDismissHandler)(void);
/**
 设置出现的动画与消失的动画
 @param showAnimation 显示的动画
 @param dismissAnimation 消失的动画
 */
- (void)setupShowAnimation:(HBAlertAnimationOption)showAnimation dismissAnimation:(HBAlertAnimationOption)dismissAnimation;

@end

