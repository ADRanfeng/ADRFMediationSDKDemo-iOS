//
//  AdRFMediationSplashViewController.m
//  ADRFMediationSDKDemo-iOS
//
//  Created by 陈坤 on 2020/4/21.
//  Copyright © 2020 陈坤. All rights reserved.
//

#import "AdRFMediationSplashViewController.h"
#import <ADRFMediationSDK/ADRFMediationSDKSplashAd.h>
#import <ADRFMediationKit/UIColor+ADRFMediationKit.h>
#import <ADRFMediationKit/ADRFMediationKitMacros.h>
#import "SetConfigManager.h"
#import "ADRFMediationSplashSkipView.h"
#import "ADRFMediationRingProgressView.h"
@interface AdRFMediationSplashViewController ()<ADRFMediationSDKSplashAdDelegate>

@property (nonatomic, strong) ADRFMediationSDKSplashAd *splashAd;

@property (nonatomic, strong) ADRFMediationSplashSkipView *skipNormalView;

@property (nonatomic, strong) ADRFMediationRingProgressView *skipRingView;

@end

@implementation AdRFMediationSplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"开屏广告";
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self loadSplashAd];
}


// 开屏测试id 518f5daa123ec3e866
- (void)loadSplashAd{
    self.splashAd = [[ADRFMediationSDKSplashAd alloc]init];
    self.splashAd.delegate = self;
    self.splashAd.controller = self;
    self.splashAd.posId = @"871fe19fe7df5b5c4b";
    self.splashAd.tolerateTimeout = 4;
    self.splashAd.needBottomSkipButton = YES;
    self.splashAd.backgroundColor = [UIColor adrf_getColorWithImage:[UIImage imageNamed:@"750x1334.png"] withNewSize:[UIScreen mainScreen].bounds.size];
    
    CGFloat bottomViewHeight = [UIScreen mainScreen].bounds.size.height * 0.15;
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, bottomViewHeight);
    UIImageView *logoImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"AdRFMediation_Logo.png"]];
    logoImageView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-135)/2, (bottomViewHeight-46)/2, 135, 46);
    [bottomView addSubview:logoImageView];
    [self.splashAd loadAndShowInWindow:[UIApplication sharedApplication].keyWindow withBottomView:bottomView];
}

#pragma mark - ADRFMediationSDKSplashAdDelegate
/**
 开屏展现成功
 
 @param splashAd 广告实例
 */
- (void)adrf_splashAdSuccessToPresentScreen:(ADRFMediationSDKSplashAd *)splashAd{
    NSLog(@"%s",__func__);
}

/**
 开屏展现失败
 
 @param splashAd 广告实例
 @param error 具体错误信息
 */
- (void)adrf_splashAdFailToPresentScreen:(ADRFMediationSDKSplashAd *)splashAd failToPresentScreen:(ADRFMediationAdapterErrorDefine *)error{
    NSLog(@"%s",__func__);
    _splashAd = nil;
}

/**
 开屏广告点击
 
 @param splashAd 广告实例
 */
- (void)adrf_splashAdClicked:(ADRFMediationSDKSplashAd *)splashAd{
    NSLog(@"%s",__func__);
}

/**
 开屏被关闭
 
 @param splashAd 广告实例
 */
- (void)adrf_splashAdClosed:(ADRFMediationSDKSplashAd *)splashAd{
    NSLog(@"%s",__func__);
    _splashAd = nil;
}

/**
 开屏展示
 
 @param splashAd 广告实例
 */
- (void)adrf_splashAdEffective:(ADRFMediationSDKSplashAd *)splashAd{
    NSLog(@"%s",__func__);
}

@end
