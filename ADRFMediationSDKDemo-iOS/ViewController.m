//
//  ViewController.m
//  ADRFMediationSDKDemo-iOS
//
//  Created by 陈坤 on 2020/5/27.
//  Copyright © 2020 陈坤. All rights reserved.
//

#import "ViewController.h"
#import <ADRFMediationKit/ADRFMediationKitMacros.h>
#import <ADRFMediationKit/NSObject+ADRFMediationKit.h>
#import <ADRFMediationKit/UIColor+ADRFMediationKit.h>
#import <ADRFMediationKit/UIFont+ADRFMediationKit.h>
#import <ADRFMediationSDK/ADRFMediationSDK.h>

#import "AdRFMediationSplashViewController.h"
#import "AdRFMediationBannerViewController.h"
#import "AdRFMediationNativeViewController.h"
#import "AdRFMediationRewardvodViewController.h"
#import "AdRFMediationInterstitialViewController.h"
//#import "TableViewController.h"
#import "SetConfigManager.h"
#import "SetTableViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = [NSString stringWithFormat:@"ADRFMediation 广告聚合SDK Demo"];
    UIButton *setAdConfigBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    [setAdConfigBtn setTitle:@"设置" forState:(UIControlStateNormal)];
    [setAdConfigBtn setImage:[UIImage imageNamed:@"set"] forState:(UIControlStateNormal)];
    [setAdConfigBtn setTitleColor:UIColor.whiteColor forState:(UIControlStateNormal)];
    setAdConfigBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    setAdConfigBtn.frame = CGRectMake(0, 0, 50, 20);
    [setAdConfigBtn addTarget:self action:@selector(setSingleAdConfig) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:setAdConfigBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dataArray = @[@"开屏广告",@"信息流广告", @"Banner横幅广告",@"激励视频",@"插屏广告"];
    
    [self.mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.mainTableView];
}

- (void)setSingleAdConfig {
    SetTableViewController *setAd = [[SetTableViewController alloc]init];
    [self.navigationController pushViewController:setAd animated:YES];
}


- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.backgroundColor = [UIColor colorWithRed:225/255.0 green:233/255.0 blue:239/255.0 alpha:1];
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _mainTableView;
}

#pragma make - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UILabel *label = [UILabel new];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:36/255.0 green:132/255.0 blue:207/255.0 alpha:1];
    label.text = [ADRFMediationSDK getSDKVersion];
    
    
    return label;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return 45;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:225/255.0 green:233/255.0 blue:239/255.0 alpha:1];
    cell.contentView.backgroundColor = [UIColor colorWithRed:225/255.0 green:233/255.0 blue:239/255.0 alpha:1];
    NSString *title = [self.dataArray adrf_objectOrNilAtIndex:indexPath.row];

    cell.contentView.clipsToBounds = YES;
    cell.clipsToBounds = YES;
    cell.contentView.layer.cornerRadius = 10;
    cell.layer.cornerRadius = 10;
    UIView *view = [cell.contentView viewWithTag:999];
    if (view) {
        [view removeFromSuperview];
    }
    
    UILabel *labTitle = [[UILabel alloc]init];
    labTitle.font = [UIFont adrf_PingFangRegularFont:18];
    labTitle.backgroundColor = [UIColor whiteColor];
    labTitle.textAlignment = NSTextAlignmentCenter;
    labTitle.textColor = [UIColor adrf_colorWithHexString:@"#666666"];
    labTitle.tag = 999;
    labTitle.text = title;
    labTitle.clipsToBounds = YES;
    [cell.contentView addSubview:labTitle];
    labTitle.frame = CGRectMake(16, 8, self.view.bounds.size.width - 32, 55);
    labTitle.layer.cornerRadius = 10;
    labTitle.layer.borderWidth = 1;
    labTitle.layer.borderColor = [UIColor adrf_colorWithHexString:@"#E5E5EA"].CGColor;
    labTitle.layer.shadowColor = [UIColor adrf_colorWithHexString:@"#000000" alphaComponent:0.1].CGColor;
    labTitle.layer.shadowOffset = CGSizeMake(0, 1);
    labTitle.layer.shadowOpacity = 1;
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 63;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    switch (indexPath.row) {
        case 0: {
            [self.navigationController pushViewController:[AdRFMediationSplashViewController new] animated:YES];
            break;
        }
        case 1: {
            [self.navigationController pushViewController:[AdRFMediationNativeViewController new] animated:YES];
            break;
        }
        case 2: {
            [self.navigationController pushViewController:[AdRFMediationBannerViewController new] animated:YES];
            break;
        }
        case 3: {
            [self.navigationController pushViewController:[AdRFMediationRewardvodViewController new] animated:YES];
            break;
        }
        case 4: {
            [self.navigationController pushViewController:[AdRFMediationInterstitialViewController new] animated:YES];
            break;
        }
        default:
            break;
    }
}


@end
