//
//  LoadingView.h
//  HBAlertViewController
//
//  Created by Patrick W on 2017/11/24.
//  Copyright © 2017年 P.W. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HBAlertController;
@interface LoadingView : UIView

+ (HBAlertController *)showLoadingViewInViewController:(UIViewController *)viewController;

@end
