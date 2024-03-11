//
//  PlatformTableViewController.m
//  ADRFMediationDev
//
//  Created by Erik on 2021/4/25.
//

#import "PlatformTableViewController.h"
#import "SetConfigManager.h"
#import <ADRFMediationSDK/ADRFMediationSDK.h>
@interface PlatformTableViewController ()
@property (nonatomic, strong) NSArray *platformArray;
@property(nonatomic ,assign) NSInteger selectIndex;
@property (nonatomic, strong) NSDictionary *platformDic;
@end

@implementation PlatformTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"广告平台选择";
    self.tableView.backgroundColor = [UIColor colorWithRed:225/255.0 green:233/255.0 blue:239/255.0 alpha:1];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.platformArray = @[@"默认所有",@"天目",@"优量汇",@"穿山甲",@"百度",@"快手"];
    self.platformDic = @{
        @"默认所有":@"",
        @"天目":@"tianmu",
        @"优量汇":@"gdt",
        @"穿山甲":@"toutiao",
        @"百度":@"baidu",
        @"快手":@"ksad",
    };
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.platformArray.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor colorWithRed:225/255.0 green:233/255.0 blue:239/255.0 alpha:1];
    label.font = [UIFont systemFontOfSize:16];
    label.text = @"   请选择需要调试的广告平台（ADN）";
    label.textColor = UIColor.grayColor;
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    
    cell.detailTextLabel.textAlignment = NSTextAlignmentCenter;
    cell.detailTextLabel.text = self.platformArray[indexPath.row];
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = UIColor.blackColor;
    label.text = self.platformArray[indexPath.row];;
    [cell.contentView addSubview:label];
    [label sizeToFit];
    label.frame = CGRectMake(UIScreen.mainScreen.bounds.size.width/2-label.bounds.size.width/2, 45/2-label.bounds.size.height/2, label.bounds.size.width, label.bounds.size.height);
    if (indexPath.row == 0) {
        cell.accessoryView.hidden = NO;
        cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"selected"]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectIndex = indexPath.row;
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    for (UITableViewCell *noneCell in tableView.visibleCells) {
        noneCell.accessoryView.hidden = YES;
    }
    cell.accessoryView.hidden = NO;
    cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"selected"]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (_selectIndex == 0) {
        return;
    }
    if (self.selectedBlock) {
        self.selectedBlock(self.platformArray[_selectIndex]);
    }
    [SetConfigManager sharedManager].platform = self.platformArray[_selectIndex];
    NSString *platformString = self.platformArray[_selectIndex];
    NSString *onlyplatform = [self.platformDic objectForKey:platformString];
    [ADRFMediationSDK setOnlyPlatform:onlyplatform];
    
}

@end
