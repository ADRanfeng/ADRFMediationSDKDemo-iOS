//
//  SetTableViewController.m
//  ADRFMediationDev
//
//  Created by Erik on 2021/4/21.
//

#import "SetTableViewController.h"
#import "PlatformTableViewController.h"
#import "SplashSetTableViewController.h"
#import "NativeAdSetTableViewController.h"
#import "BannerAdSetTableViewController.h"
#import "InterstitialAdSetTableViewController.h"
@interface SetTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *adTypeArray;
@property (nonatomic, strong) UISwitch *switchDarkMode;
@property (nonatomic, copy) NSString *platform;
@end

@implementation SetTableViewController

- (UISwitch *)switchDarkMode {
    if (!_switchDarkMode) {
        _switchDarkMode = [[UISwitch alloc]init];
    }
    return _switchDarkMode;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.adTypeArray = @[@"开屏广告",@"信息流广告",@"横幅广告",@"插屏广告"];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = [UIColor colorWithRed:225/255.0 green:233/255.0 blue:239/255.0 alpha:1];
    _platform = @"默认所有";
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section==0) {
        return 1;
    }
    return _adTypeArray.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:16];
    label.text = @"   广告位设置";
    label.textColor = UIColor.grayColor;
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section==0)
        return 0;
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"cell"];
    if (indexPath.section == 0) {
        cell.textLabel.text = @"广告平台";
        cell.detailTextLabel.text = _platform;
        cell.accessoryType = UIAccessibilityNavigationStyleSeparate;
            
    } else {
        cell.textLabel.text = _adTypeArray[indexPath.row];
        cell.accessoryType = UIAccessibilityNavigationStyleSeparate;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section ==0 ) {
        if (indexPath.row==0) {
            PlatformTableViewController *platformVc = [PlatformTableViewController new];
            platformVc.selectedBlock = ^(NSString * _Nonnull platorm) {
                self->_platform = platorm;
                __weak typeof(self) weakSelf = self;
                [weakSelf.tableView reloadData];
            };
            [self.navigationController pushViewController:platformVc animated:YES];
        }
    } else {
        UIViewController *vc = nil;
        switch (indexPath.row) {
            case 0: {
                vc = [SplashSetTableViewController new];
                break;
            }
            case 1: {
                vc = [NativeAdSetTableViewController new];
                break;
            }
            case 2: {
                vc = [BannerAdSetTableViewController new];
                break;
            }
            case 3: {
                vc = [InterstitialAdSetTableViewController new];
                break;
            }
            default:
                break;
        }
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
