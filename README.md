# HBAlert
	模仿UIAlertController的实现方式来实现一个可以高度自定义的弹出视图。
	 这里不做特别复杂的效果，仅仅作为一种弹出方式以及自定义视图的载体。

## iOS 实现各种自定义弹出视图(简单实现几个示例)
- Loading效果
- 左侧滑出样式
- 底部类似分享滑出
- 右侧滑出

具体效果如下图：

![](https://github.com/wanghangAmazing/HBAlert/blob/master/QQ20171129-231520-HD.gif?raw=true)


##实现原理

	通过自定义viewController的转场动画，来实现视图的弹出方式。

##代码实例
###Loading的效果：

	LoadingView *loadingView = [LoadingView new];
    loadingView.backgroundColor = [UIColor whiteColor];
    HBAlertController *alert = [[HBAlertController alloc] initWithPositon:HBAlertPositionCenter alertOffSet:CGPointZero];
    alert.customContentView = loadingView;
    [alert setupShowAnimation:HBAlertAnimationOptionCenterSpringIn dismissAnimation:HBAlertAnimationOptionAlpha];
    alert.view.layer.cornerRadius = 5.f;
    alert.view.layer.masksToBounds = YES;
    [viewController presentViewController:alert animated:YES completion:nil];
    

###分享视图：

		UIView *shareView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen] bounds]), 200)];
        shareView.backgroundColor = [UIColor yellowColor];
        UILabel *label = [[UILabel alloc] init];
        label.text = @"这是一个分享视图";
        [shareView addSubview:label];
        [label sizeToFit];
        label.center = shareView.center;
        
        HBAlertController *alertVC = [[HBAlertController alloc] initWithPositon:HBAlertPositionBottom alertOffSet:CGPointZero];
        alertVC.customContentView = shareView;
        [alertVC setupShowAnimation:HBAlertAnimationOptionBottomIn dismissAnimation:HBAlertAnimationOptionBottomOut];
        [self presentViewController:alertVC animated:YES completion:nil];
        

###左侧栏：

		UIView *leftView = [[UIView alloc] init];
        leftView.frame = CGRectMake(0, 0, 200, CGRectGetHeight([[UIScreen mainScreen] bounds]));
        leftView.backgroundColor = [UIColor redColor];
        
        HBAlertController *alertVC = [[HBAlertController alloc] initWithPositon:HBAlertPositionLeft alertOffSet:CGPointZero];
        alertVC.customContentView = leftView;
        [alertVC setupShowAnimation:HBAlertAnimationOptionLeftIn dismissAnimation:HBAlertAnimationOptionLeftOut];
        
        UIVisualEffectView *visualEffect = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
        alertVC.coverView = visualEffect;
        
        [self presentViewController:alertVC animated:YES completion:nil];
        

###下拉栏：

		UIView *pullView = [[UIView alloc] init];
        [pullView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(CGRectGetWidth([[UIScreen mainScreen] bounds]) - 50 , 60));
        }];
        
        pullView.backgroundColor = [UIColor purpleColor];
        
        HBAlertController *alertVC = [[HBAlertController alloc] initWithPositon:HBAlertPositionTop alertOffSet:CGPointMake(0, 20)];
        alertVC.customContentView = pullView;
        [alertVC setupShowAnimation:HBAlertAnimationOptionTopIn dismissAnimation:HBAlertAnimationOptionTopOut];
        alertVC.view.layer.cornerRadius = 5.f;
        alertVC.view.layer.masksToBounds = YES;
        
        [self presentViewController:alertVC animated:YES completion:nil];

###下载进度：

		UIView *contentView = [[UIView alloc] init];
        contentView.backgroundColor = [UIColor whiteColor];
        UIProgressView *progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        UILabel *titleLabel = [UILabel new];
        titleLabel.text = @"正在下载";
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [contentView addSubview:titleLabel];
        [contentView addSubview:progressView];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.centerX.mas_equalTo(0);
        }];
        
        [progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLabel.mas_bottom).mas_offset(10);
            make.leading.mas_equalTo(10);
            make.trailing.mas_equalTo(-10);
            make.size.mas_equalTo(CGSizeMake(200, 5));
            make.bottom.mas_equalTo(-10);
        }];
        if (@available(iOS 10.0, *)) {
            [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
                [progressView setProgress:progressView.progress + 0.01 animated:YES];
                if (progressView.progress == 1) {
                    titleLabel.text = @"下载完成";
                    [timer invalidate];
                }
            }];
        }
        HBAlertController *alertVC = [[HBAlertController alloc] initWithPositon:HBAlertPositionCenter alertOffSet:CGPointZero];
        alertVC.customContentView = contentView;
        [alertVC setupShowAnimation:HBAlertAnimationOptionTopIn dismissAnimation:HBAlertAnimationOptionBottomOut];
        alertVC.view.layer.cornerRadius = 5.f;
        alertVC.view.layer.masksToBounds = YES;
        [self presentViewController:alertVC animated:YES completion:nil];
               

##结束语
	此类并没有封装得很好，仅仅用于感兴趣的朋友参考实现方式！！！！
