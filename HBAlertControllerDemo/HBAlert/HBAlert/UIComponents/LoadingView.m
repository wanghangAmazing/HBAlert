//
//  LoadingView.m
//  HBAlertViewController
//
//  Created by Patrick W on 2017/11/24.
//  Copyright © 2017年 P.W. All rights reserved.
//

#import "LoadingView.h"
#import <Masonry.h>
#import "HBAlertController.h"

@interface LoadingView ()

@property (strong, nonatomic) UILabel *textLabel;
@property (strong, nonatomic) UIActivityIndicatorView *activityView;

@end


@implementation LoadingView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSuviews];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupSuviews];
}

- (void)setupSuviews {
    [self addSubview:self.textLabel];
    [self addSubview:self.activityView];
    
    [self.activityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.activityView.mas_bottom).mas_offset(5);
        make.leading.mas_equalTo(5);
        make.trailing.mas_equalTo(-5);
        make.bottom.mas_equalTo(-5);
    }];
    
    self.textLabel.text = @"Loading.....";
    [self.activityView startAnimating];
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        _textLabel.font = [UIFont systemFontOfSize:13];
    }
    return _textLabel;
}

- (UIActivityIndicatorView *)activityView {
    if (!_activityView) {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityView.hidesWhenStopped = YES;
    }
    return _activityView;
}

+ (HBAlertController *)showLoadingViewInViewController:(UIViewController *)viewController {
    LoadingView *loadingView = [LoadingView new];
    loadingView.backgroundColor = [UIColor whiteColor];
    HBAlertController *alert = [[HBAlertController alloc] initWithPositon:HBAlertPositionCenter alertOffSet:CGPointZero];
    alert.customContentView = loadingView;
    [alert setupShowAnimation:HBAlertAnimationOptionCenterSpringIn dismissAnimation:HBAlertAnimationOptionAlpha];
    alert.view.layer.cornerRadius = 5.f;
    alert.view.layer.masksToBounds = YES;
    [viewController presentViewController:alert animated:YES completion:nil];
    return alert;
}

@end
