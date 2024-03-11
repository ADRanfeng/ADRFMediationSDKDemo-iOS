//
//  SetConfigManager.h
//  ADRFMediationDev
//
//  Created by Erik on 2021/4/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SetConfigManager : NSObject

+ (instancetype)sharedManager;

@property (nonatomic, copy) NSString *platform;

@property(nonatomic ,assign) BOOL isCustomSkipView;

@property(nonatomic ,assign) BOOL nativeAdMuted;

@property(nonatomic ,assign) NSInteger nativeAdCount;

@property (nonatomic, copy) NSString *nativeAdScenceId;

@property(nonatomic ,assign) NSInteger bannerAdInterval;

@property (nonatomic, copy) NSString *bannerAdScenceId;

@property (nonatomic, copy) NSString *insterstitialAdScenceId;

@end

NS_ASSUME_NONNULL_END
