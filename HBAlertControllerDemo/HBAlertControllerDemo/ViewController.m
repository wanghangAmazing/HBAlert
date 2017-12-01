//
//  ViewController.m
//  HBAlertControllerDemo
//
//  Created by Patrick W on 2017/11/27.
//  Copyright © 2017年 P.W. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#import <HBAlert/HBAlert.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *datasource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.datasource = @[@"显示一个Loading", @"显示一个分享视图", @"这是一个侧边栏", @"这是一个下拉框", @"这是一个进度条"];
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
    self.tableView.rowHeight = 50.f;
    self.tableView.sectionFooterHeight = 0.f;
    self.tableView.sectionHeaderHeight = 0.f;
}


#pragma mark - UITableViewDataSource
#pragma mark -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class) forIndexPath:indexPath];
    cell.textLabel.text = [self.datasource objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
#pragma mark -

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        HBAlertController *alter = [LoadingView showLoadingViewInViewController:self];
        alter.alertDidDismissHandler = ^{
            NSLog(@"HBAlertController消失了");
        };
    } else if (indexPath.row == 1) {
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
        
    } else if (indexPath.row == 2) {
        
        UIView *leftView = [[UIView alloc] init];
        leftView.frame = CGRectMake(0, 0, 200, CGRectGetHeight([[UIScreen mainScreen] bounds]));
        leftView.backgroundColor = [UIColor redColor];
        
        HBAlertController *alertVC = [[HBAlertController alloc] initWithPositon:HBAlertPositionLeft alertOffSet:CGPointZero];
        alertVC.customContentView = leftView;
        [alertVC setupShowAnimation:HBAlertAnimationOptionLeftIn dismissAnimation:HBAlertAnimationOptionLeftOut];
        
        UIVisualEffectView *visualEffect = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
        alertVC.coverView = visualEffect;
        
        [self presentViewController:alertVC animated:YES completion:nil];
        
    } else if (indexPath.row == 3) {
        
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
        
    } else if (indexPath.row == 4) {
        
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
//        alertVC.hideWhenTouchBlank = NO;
        [alertVC setupShowAnimation:HBAlertAnimationOptionTopIn dismissAnimation:HBAlertAnimationOptionBottomOut];
        alertVC.view.layer.cornerRadius = 5.f;
        alertVC.view.layer.masksToBounds = YES;
        
        [self presentViewController:alertVC animated:YES completion:nil];
    }
}




@end
