//
//  AdRFMediationBannerViewController.m
//  ADRFMediationSDKDemo-iOS
//
//  Created by 陈坤 on 2020/4/21.
//  Copyright © 2020 陈坤. All rights reserved.
//

#import "AdRFMediationBannerViewController.h"
#import <ADRFMediationSDK/ADRFMediationSDKBannerAdView.h>
#import <ADRFMediationKit/ADRFMediationKitMacros.h>
#import "SetConfigManager.h"
@interface AdRFMediationBannerItem : NSObject

@property (nonatomic, assign) CGFloat rate;

@property (nonatomic, copy) NSString *posId;

@property (nonatomic, copy) NSString *title;

+ (instancetype)itemWithRate:(CGFloat)rate posId:(NSString *)posId title:(NSString *)title;

@end


@interface AdRFMediationBannerViewController ()<ADRFMediationSDKBannerAdViewDelegate>

@property (nonatomic, strong) ADRFMediationSDKBannerAdView * bannerView;

@property (nonatomic, copy) NSArray<AdRFMediationBannerItem *> *array;

@property (nonatomic, strong) NSMutableArray<UIButton *> *btns;

@end

@implementation AdRFMediationBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    for (int i = 0; i < self.array.count; i++) {
        [self createButtonWithItem:self.array[i] index:i];
    }
}


#pragma mark - Private method

- (void)loadBannerWithRate:(CGFloat)rate posId:(NSString *)posId {
    [self.bannerView removeFromSuperview];
    self.bannerView.delegate = nil;
    self.bannerView = nil;
    
    // 1、初始化banner视图，并给定frame值，rate取值根据banner的尺寸
    self.bannerView = [[ADRFMediationSDKBannerAdView alloc] initWithFrame:CGRectMake(0, 250, kADRFScreenWidth, kADRFScreenWidth / rate)];
    self.bannerView.delegate = self;
    // 2、设置控制器，用来弹出落地页，重要
    self.bannerView.controller = self;
    // 3、设置广告位id，重要
    self.bannerView.posId = posId;
    self.bannerView.refershTime = [SetConfigManager sharedManager].bannerAdInterval;
    if (![[SetConfigManager sharedManager].bannerAdScenceId isEqualToString:@""])
        self.bannerView.scenesId = [SetConfigManager sharedManager].bannerAdScenceId;
    // 可设置bannerview的背景色，请按需添加修改该行代码
    //    self.bannerView.backgroundColor = UIColor.redColor;
    // 4、可先展示再请求
    // 5、加载并展示
    [self.bannerView loadAndShowWithError:nil];
}

#pragma mark - ADRFMediationSDKBannerAdViewDelegate
/**
 广告获取成功
 
 @param bannerView banner实例
 */
- (void)adrf_bannerViewDidReceived:(ADRFMediationSDKBannerAdView *)bannerView{
    [self.view addSubview:self.bannerView];
}
/**
 广告拉取失败
 
 @param bannerView banner实例
 @param errorModel 错误描述
 */
- (void)adrf_bannerViewFailToReceived:(ADRFMediationSDKBannerAdView *)bannerView errorModel:(ADRFMediationAdapterErrorDefine *)errorModel{
    NSLog(@"adrf_bannerViewFailToReceived:%@, %@",errorModel.errorDescription, errorModel.errorDetailDict);
    [_bannerView removeFromSuperview];
    _bannerView = nil;
}

/**
 广告点击
 
 @param bannerView 广告实例
 */
- (void)adrf_bannerViewClicked:(ADRFMediationSDKBannerAdView *)bannerView{
    
}
/**
 广告关闭
 
 @param bannerView 广告实例
 */
- (void)adrf_bannerViewClose:(ADRFMediationSDKBannerAdView *)bannerView{
    _bannerView = nil;
}

/**
 广告展示
 
 @param bannerView 广告实例
 */
- (void)adrf_bannerViewExposure:(ADRFMediationSDKBannerAdView *)bannerView{
    NSLog(@"============曝光成功=========");
}

#pragma mark - Touch event

- (void)clickLoadBannerButton:(UIButton *)btn {
    btn.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        btn.enabled = YES;
    });
    for (UIButton *lbtn in self.btns) {
        lbtn.backgroundColor = (lbtn == btn) ? [UIColor colorWithRed:222/255.0 green:236/255.0 blue:251/255.0 alpha:1.0] : [UIColor whiteColor];
    }
    AdRFMediationBannerItem *item = self.array[btn.tag];
    [self loadBannerWithRate:item.rate posId:item.posId];
}

#pragma mark - Helper - UI

- (void)createButtonWithItem:(AdRFMediationBannerItem *)item index:(NSInteger)index {
    UIButton *btn = [UIButton new];
    [self.view addSubview:btn];

    static NSInteger btn_num_per_line = 4;
    static CGFloat btn_height = 32;
    static CGFloat btn_margin_top = 10;
    static CGFloat btn_margin_left = 10;
    static CGFloat margin_top = 16;
    static CGFloat margin_left = 17;
    
    CGFloat btn_width = ((self.view.frame.size.width - margin_left * 2) - ((btn_num_per_line - 1) * btn_margin_left)) / btn_num_per_line;
    CGFloat x = ((index % btn_num_per_line) * (btn_margin_left + btn_width)) + margin_left;
    CGFloat y = (index / btn_num_per_line) * (btn_margin_top + btn_height) + margin_top + 100;
    
    btn.frame = CGRectMake(x, y, btn_width, btn_height);
    
    btn.tag = index;
    
    [btn addTarget:self action:@selector(clickLoadBannerButton:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:item.title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:0 green:122/255.0 blue:1 alpha:1] forState:UIControlStateNormal];
    btn.layer.borderWidth = 1.0;
    btn.layer.borderColor = [UIColor colorWithRed:199/255.0 green:199/255.0 blue:204/255.0 alpha:1.0].CGColor;
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.btns addObject:btn];
    
    [self.view addSubview:btn];
}

#pragma mark - Lazy load

- (NSArray<AdRFMediationBannerItem *> *)array {
    if(!_array) {
        NSMutableArray *array = [NSMutableArray new];
        
        [array addObject:[AdRFMediationBannerItem itemWithRate:640/100.0 posId:@"84aa0f60143e6ab18c" title:@"640*100"]];
        [array addObject:[AdRFMediationBannerItem itemWithRate:600/150.0 posId:@"" title:@"600*150"]];
        [array addObject:[AdRFMediationBannerItem itemWithRate:600/260.0 posId:@"" title:@"600*260"]];
        [array addObject:[AdRFMediationBannerItem itemWithRate:600/300.0 posId:@"" title:@"600*300"]];
        [array addObject:[AdRFMediationBannerItem itemWithRate:690/388.0 posId:@"" title:@"690*388"]];
        [array addObject:[AdRFMediationBannerItem itemWithRate:600/400.0 posId:@"" title:@"600*400"]];
        [array addObject:[AdRFMediationBannerItem itemWithRate:600/500.0 posId:@"" title:@"600*500"]];
        
        _array = [array copy];
    }
    return _array;
}

- (NSMutableArray<UIButton *> *)btns {
    if(!_btns) {
        _btns = [NSMutableArray new];
    }
    return _btns;;
}

@end

@implementation AdRFMediationBannerItem

+ (instancetype)itemWithRate:(CGFloat)rate posId:(NSString *)posId title:(NSString *)title {
    AdRFMediationBannerItem *item = [super new];
    if(self) {
        item.rate = rate;
        item.posId = posId;
        item.title = title;
    }
    return item;
}

@end
