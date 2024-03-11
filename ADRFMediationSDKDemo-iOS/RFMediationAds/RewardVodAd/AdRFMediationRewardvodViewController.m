//
//  AdRFMediationRewardvodViewController.m
//  ADRFMediationSDKDemo-iOS
//
//  Created by 陈坤 on 2020/4/21.
//  Copyright © 2020 陈坤. All rights reserved.
//

#import "AdRFMediationRewardvodViewController.h"
#import <ADRFMediationSDK/ADRFMediationSDKRewardvodAd.h>
#import "UIView+Toast.h"
@interface AdRFMediationRewardvodViewController ()<ADRFMediationSDKRewardvodAdDelegate>

@property (nonatomic, strong)ADRFMediationSDKRewardvodAd *rewardvodAd;
@property(nonatomic ,assign) BOOL isReadyToplay;

@end

@implementation AdRFMediationRewardvodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"激励视频";
    self.view.backgroundColor = [UIColor colorWithRed:225/255.0 green:233/255.0 blue:239/255.0 alpha:1];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIButton *loadBtn = [UIButton new];
    loadBtn.layer.cornerRadius = 10;
    loadBtn.clipsToBounds = YES;
    loadBtn.backgroundColor = UIColor.whiteColor;
    [loadBtn setTitle:@"加载激励视频" forState:(UIControlStateNormal)];
    [loadBtn setTitleColor:UIColor.blackColor forState:(UIControlStateNormal)];
    loadBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:loadBtn];
    loadBtn.frame = CGRectMake(30, UIScreen.mainScreen.bounds.size.height/2-60, UIScreen.mainScreen.bounds.size.width-60, 60);
    [loadBtn addTarget:self action:@selector(loadRewardvodAd) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton *showBtn = [UIButton new];
    showBtn.layer.cornerRadius = 10;
    showBtn.clipsToBounds = YES;
    showBtn.backgroundColor = UIColor.whiteColor;
    [showBtn setTitle:@"展示激励视频" forState:(UIControlStateNormal)];
    [showBtn setTitleColor:UIColor.blackColor forState:(UIControlStateNormal)];
    showBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:showBtn];
    [showBtn addTarget:self action:@selector(showRewardvodAd) forControlEvents:(UIControlEventTouchUpInside)];
    showBtn.frame = CGRectMake(30, UIScreen.mainScreen.bounds.size.height/2+20, UIScreen.mainScreen.bounds.size.width-60, 60);
}

- (void)loadRewardvodAd{
    // 1、初始化激励视频广告
    self.rewardvodAd  = [[ADRFMediationSDKRewardvodAd alloc]init];
    self.rewardvodAd.delegate = self;
    self.rewardvodAd.tolerateTimeout = 5;
    self.rewardvodAd.controller = self;
    self.rewardvodAd.posId = @"2efc799f75ce8980bc";
    self.rewardvodAd.userId = @"rf";
    self.rewardvodAd.extraInfo = @"这是一个激励验证";
    self.rewardvodAd.rewardName = @"激励验证测试";
    self.rewardvodAd.rewardAmount = [NSNumber numberWithInt:2];
    // 2、加载激励视频广告
    [self.rewardvodAd loadRewardvodAd];
}

- (void)showRewardvodAd {
    if ([self.rewardvodAd rewardvodAdIsReady] && _isReadyToplay) {
        [self.rewardvodAd showRewardvodAd];
    }else{
        [self.view makeToast:@"激励视频未准备完成"];
    }
}

#pragma mark - ADRFMediationSDKRewardvodAdDelegate
/**
 广告数据加载成功回调
 
 @param rewardvodAd 广告实例
 */
- (void)adrf_rewardvodAdLoadSuccess:(ADRFMediationSDKRewardvodAd *)rewardvodAd{
    
}

/**
 激励视频广告准备好被播放
 
 @param rewardvodAd 广告实例
 */
- (void)adrf_rewardvodAdReadyToPlay:(ADRFMediationSDKRewardvodAd *)rewardvodAd{
    if ([self.rewardvodAd rewardvodAdIsReady]) {
        _isReadyToplay = YES;
        // 建议在这个时机进行展示 也可根据需求在合适的时机进行展示
        // [self.rewardvodAd showRewardvodAd];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view makeToast:@"激励视频准备完成"];
    });
    
}

/**
 视频数据下载成功回调，已经下载过的视频会直接回调
 
 @param rewardvodAd 广告实例
 */
- (void)adrf_rewardvodAdVideoLoadSuccess:(ADRFMediationSDKRewardvodAd *)rewardvodAd{
}
/**
 视频播放页即将展示回调
 
 @param rewardvodAd 广告实例
 */
- (void)adrf_rewardvodAdWillVisible:(ADRFMediationSDKRewardvodAd *)rewardvodAd{
}
/**
 视频广告曝光回调
 
 @param rewardvodAd 广告实例
 */
- (void)adrf_rewardvodAdDidVisible:(ADRFMediationSDKRewardvodAd *)rewardvodAd{
}
/**
 视频播放页关闭回调
 
 @param rewardvodAd 广告实例
 */
- (void)adrf_rewardvodAdDidClose:(ADRFMediationSDKRewardvodAd *)rewardvodAd{
    // 4、广告内存回收
    _rewardvodAd = nil;
}
/**
 视频广告信息点击回调
 
 @param rewardvodAd 广告实例
 */
- (void)adrf_rewardvodAdDidClick:(ADRFMediationSDKRewardvodAd *)rewardvodAd{
    
}
/**
 视频广告视频播放完成
 
 @param rewardvodAd 广告实例
 */
- (void)adrf_rewardvodAdDidPlayFinish:(ADRFMediationSDKRewardvodAd *)rewardvodAd{
    
}

/**
 视频广告视频达到奖励条件
 
 @param rewardvodAd 广告实例
 */
- (void)adrf_rewardvodAdDidRewardEffective:(ADRFMediationSDKRewardvodAd *)rewardvodAd{
    
}

/**
 视频广告请求失败回调
 
 @param rewardvodAd 广告实例
 @param errorModel 具体错误信息
 */
- (void)adrf_rewardvodAdFailToLoad:(ADRFMediationSDKRewardvodAd *)rewardvodAd errorModel:(ADRFMediationAdapterErrorDefine *)errorModel{
    // 4、广告内存回收
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view makeToast:errorModel.description];
    });
    _rewardvodAd = nil;
}

/**
 视频广告播放时各种错误回调
 
 @param rewardvodAd 广告实例
 @param errorModel 具体错误信息
 */
- (void)adrf_rewardvodAdPlaying:(ADRFMediationSDKRewardvodAd *)rewardvodAd errorModel:(ADRFMediationAdapterErrorDefine *)errorModel{
    
}

- (void)adrf_rewardvodAdServerDidSucceed:(ADRFMediationSDKRewardvodAd *)rewardvodAd {
    
}

- (void)adrf_rewardvodAdServerDidFailed:(ADRFMediationSDKRewardvodAd *)rewardvodAd errorModel:(ADRFMediationAdapterErrorDefine *)errorModel {
    
}

@end
