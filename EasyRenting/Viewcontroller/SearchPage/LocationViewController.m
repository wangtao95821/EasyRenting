//
//  LocationViewController.m
//  EasyRenting
//
//  Created by administrator on 16/4/19.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "LocationViewController.h"
#import "Define.h"
#import <CoreLocation/CoreLocation.h>
#import "LocationHouseInfoService.h"
#import "MBProgressHUD.h"
#import "SearchPageCell.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "FetchPicService.h"
#import "HouseInfoViewController.h"
@interface LocationViewController ()<CLLocationManagerDelegate>

@property (strong, nonatomic) NSMutableArray *houseInfoArr;

@property (strong, nonatomic) NSMutableArray *imaUrlArr;

@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.houseInfoArr = [NSMutableArray arrayWithCapacity:                                                                                        0];
    self.imaUrlArr = [NSMutableArray arrayWithCapacity:0];
    //把原先的顶部导航隐藏，使用自定义的view代替
    self.navigationController.navigationBar.hidden = YES;
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    self.headView.backgroundColor = COLOR(243, 198, 1, 1);
    [self.view addSubview:self.headView];
    
    self.backBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(3), 27, WIDTH5S(30.0), WIDTH5S(30))];
    [self.backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.headView addSubview:self.backBtn];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH5S(101), 32, WIDTH5S(118), 20)];
    self.titleLabel.font = [UIFont systemFontOfSize:15.0];
    self.titleLabel.textColor = COLOR(254, 252, 192, 1);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.text = @"附近的房子";
    [self.view addSubview:self.titleLabel];
 
    [self indeterminateExample];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        LocationHouseInfoService *service = [[LocationHouseInfoService alloc]init];
        [service location:^(NSMutableArray *arr) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.houseInfoArr setArray:arr];
                [self imaUrlArr];
                [self addView];
                
                if (_houseInfoArr.count == 0) {
                    self.blankLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH5S(80), HEIGHT5S(200), WIDTH5S(160), 20)];
                    //        self.blankLabel.backgroundColor = [UIColor redColor];
                    self.blankLabel.textAlignment = NSTextAlignmentCenter;
                    self.blankLabel.textColor = SMALLWORD;
                    self.blankLabel.text = @"未找到相关房屋信息";
                    [self.myTable addSubview:self.blankLabel];
                }
            });
            
            
        }];
    });
    
    
    
}

//初始化tableView
- (void)addView{
    self.myTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    self.myTable.delegate = self;
    self.myTable.dataSource = self;
    self.myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTable.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.myTable];
    
    
    UITableView *tableView = self.myTable;
    // 下拉刷新
    tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            LocationHouseInfoService *service = [[LocationHouseInfoService alloc]init];
            [service location:^(NSMutableArray *arr) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.houseInfoArr setArray:arr];
                    [self imaUrlArr];
                    
                    if (_houseInfoArr.count > 0) {
                        [self.blankLabel removeFromSuperview];
                    }
                    [self.myTable reloadData];
                    // 结束刷新
                    [tableView.mj_header endRefreshing];
                });
                
            }];
  
        });
   
    }];
   
    //隐藏时间显示
    MJRefreshNormalHeader *header = (MJRefreshNormalHeader *)tableView.mj_header;
    header.lastUpdatedTimeLabel.hidden = YES;
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    tableView.mj_header.automaticallyChangeAlpha = YES;

    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    [self hideMBProgressHUD];
    return _houseInfoArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return HEIGHT5S(120);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *str = @"hehe";
    SearchPageCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[SearchPageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    NSDictionary *dic = _houseInfoArr[indexPath.row];
    if (self.imaUrlArr.count == self.houseInfoArr.count) {
        [cell.houseImage sd_setImageWithURL:[NSURL URLWithString:self.imaUrlArr[indexPath.row]] placeholderImage:[UIImage imageNamed:@"house.jpg"]];
        
    }

    cell.houseNameLabel.text = [dic objectForKey:@"houseinfo_name"];
    NSString *rent = [dic objectForKey:@"houseinfo_rent"];
    NSString *rentStr = [NSString stringWithFormat:@"%@/月",rent];
    cell.houseRentLabel.text = rentStr    ;
    cell.houseAddressLabel.text = [dic objectForKey:@"houseinfo_address"];
    NSString *strss = [dic objectForKey:@"housetype_style"];
    NSString *apartmenStr;
    if ([strss isEqual:@"1"]) {
        apartmenStr = @"实惠一居";
    }else if ([strss isEqual:@"2"]){
        apartmenStr = @"经典两居";
    }else if ([strss isEqual:@"3"]){
        apartmenStr = @"舒适三居";
    }else if ([strss isEqual:@"4"]){
        apartmenStr = @"豪华生活";
    }else if ([strss isEqual:@"5"]){
        apartmenStr = @"阳光主卧";
    }else if ([strss isEqual:@"6"]){
        apartmenStr = @"舒适次卧";
    }else if ([strss isEqual:@"7"]){
        apartmenStr = @"暖心小窝";
    }else if ([strss isEqual:@"8"]){
        apartmenStr = @"独立卫生间";
    }
    cell.houseApartmentLabel.text = apartmenStr;
    NSString *strs = [dic objectForKey:@"houseinfo_rentstyle"];
    NSString *rentstyleStr;
    if ([strs isEqual:@"0"]) {
        rentstyleStr = @"整租";
    }else{
        rentstyleStr = @"分租";
    }
    cell.houseStyleLabel.text = rentstyleStr;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HouseInfoViewController *vc = [[HouseInfoViewController alloc]init];
    self.tabBarController.hidesBottomBarWhenPushed = YES;
    vc.isOnePage = YES;
    vc.houseinfoDic = _houseInfoArr[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
    self.tabBarController.hidesBottomBarWhenPushed = NO;
}



- (void)indeterminateExample {
    // Show the HUD on the root view (self.view is a scrollable table view and thus not suitable,
    // as the HUD would move with the content as we scroll).
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    CGRect rect = hud.frame;
    rect.origin.y = 64;
    rect.size.height = SCREEN_HEIGHT-64-49;
    hud.frame = rect;
    hud.tag = 3500;
    // Fire off an asynchronous task, giving UIKit the opportunity to redraw wit the HUD added to the
    // view hierarchy.
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        
        // Do something useful in the background
        
        sleep(30.);
        
        // IMPORTANT - Dispatch back to the main thread. Always access UI
        // classes (including MBProgressHUD) on the main thread.
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hideAnimated:YES];
        });
    });
    
}

- (void)imaUrl{
    FetchPicService *fps = [[FetchPicService alloc]init];
    self.imaUrlArr = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < self.houseInfoArr.count; i++) {
        [fps houseInfoId:[self.houseInfoArr[i][@"houseinfo_id"] intValue]  successWith:^(NSDictionary *dic) {
            NSArray *arr = dic[@"result"];
            NSString *picName = arr[0][@"houseimage_name"];
            NSString *newPicName = [NSString stringWithFormat:@"http://115.159.215.30/Tupian/image/%@",picName];
            
            [self.imaUrlArr addObject:newPicName];
            
            [self.myTable reloadData];
        }];
        
    }
    
    
}

//隐藏弹出的提示框
- (void)hideMBProgressHUD{
    MBProgressHUD *hud = (MBProgressHUD *)[self.view.window viewWithTag:3500];
    if (hud != nil) {
        hud.removeFromSuperViewOnHide = YES;
        [hud hideAnimated:YES];
    }
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
    [self hideMBProgressHUD];
}

@end
