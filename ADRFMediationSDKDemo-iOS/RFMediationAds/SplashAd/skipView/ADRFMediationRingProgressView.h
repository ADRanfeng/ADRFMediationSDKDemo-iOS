//
//  ADRFMediationProcessView.h
//  ADRFMediationSDKDemo-iOS
//
//  Created by 技术 on 2020/11/3.
//  Copyright © 2020 陈坤. All rights reserved.
// 自定义跳过按钮  圆形进度条

#import <UIKit/UIKit.h>
#import <ADRFMediationSDK/ADRFMediationAdapterSplashSkipViewProtocol.h>
NS_ASSUME_NONNULL_BEGIN

@interface ADRFMediationRingProgressView : UIView<ADRFMediationAdapterSplashSkipViewProtocol>

@property (nonatomic, assign) NSInteger progress;

@end

NS_ASSUME_NONNULL_END
