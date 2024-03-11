//
//  AdRFMediationNativeViewCell.m
//  ADRFMediationSDKDemo-iOS
//
//  Created by 陶冶明 on 2020/4/21.
//  Copyright © 2020 陈坤. All rights reserved.
//

#import "AdRFMediationNativeViewCell.h"

@implementation AdRFMediationNativeViewCell

- (void)setAdView:(UIView *)adView {
    [_adView removeFromSuperview];
    
    _adView = adView;
    [self.contentView addSubview:_adView];
}

- (void)setCloseBtnView:(UIView *)closeBtnView{
    [_closeBtnView removeFromSuperview];
    _closeBtnView = closeBtnView;
    //frame根据需求进行自行调整
    _closeBtnView.frame = CGRectMake(UIScreen.mainScreen.bounds.size.width-60, 10, 60, 30);
    [self.contentView addSubview:_closeBtnView];
    
}
@end
