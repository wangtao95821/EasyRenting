//
//  CollectPageViewController.m
//  EasyRenting
//
//  Created by administrator on 16/4/5.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "CollectPageViewController.h"
#import "Define.h"
#import "CollectCellTableViewCell.h"
#import "FavoritesService.h"
#import "MBProgressHUD.h"
@interface CollectPageViewController ()

@property (copy, nonatomic) NSString *userID;

@property (strong, nonatomic) MBProgressHUD *hud;

@end

@implementation CollectPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.hidden = YES;
    
    UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    
    navView.backgroundColor = NAVIGATIONCOLOR;
    
    [self.view addSubview:navView];
    
    UILabel *navTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH5S(100), 20, WIDTH5S(120), 44)];
    
    navTitleLabel.text = @"收藏夹";
    
    navTitleLabel.font = FONT(15);
    
    navTitleLabel.textColor = COLOR(255, 253, 193, 1);
    
    navTitleLabel.textAlignment = NSTextAlignmentCenter;
    
    [navView addSubview:navTitleLabel];
    
    
    
    //导航栏上的返回键
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 60, 44)];
    
    [backBtn addTarget:self action:@selector(BACK) forControlEvents:UIControlEventTouchUpInside];
    
    [navView addSubview:backBtn];
    
    UIImageView *backIma = [[UIImageView alloc]initWithFrame:CGRectMake(2, 10, 25, 25)];
    backIma.image = [UIImage imageNamed:@"back_select@2x"];
    [backBtn addSubview:backIma];
    
    [self createCollectTable];
    
    //未收藏
    self.collectLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT/4, SCREEN_WIDTH, 30)];
    
    self.collectLabel.text = @"你未收藏任何房屋，请先去收藏吧！";
    
    self.collectLabel.textColor = SMALLWORD;
    
    self.collectLabel.textAlignment = NSTextAlignmentCenter;
    
    self.collectLabel.hidden = YES;
    
    self.collectLabel.font = FONT(15);
    
    [self.collectTable addSubview:self.collectLabel];
    
    
    
    self.FMutArr = [NSMutableArray arrayWithCapacity:0];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *dicUserDefaults = [userDefaults objectForKey:@"personInfo"];
    
    NSArray *arrUserDefaults = [dicUserDefaults objectForKey:@"result"];
    
    NSDictionary *dic1UserDefaults = arrUserDefaults[0];

    self.userID = [dic1UserDefaults objectForKey:@"user_id"];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       
        [FavoritesService FavoritesUserid:1 andSuccess:^(NSMutableArray *collectMutArr) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.FMutArr = collectMutArr;
                
                if (_FMutArr.count != 0) {
                    
                    [self.hud hideAnimated:YES];
                    
                }else{
                
                    sleep(10.);
                    
                    [self.hud hideAnimated:YES];
                    
                    self.collectLabel.hidden = NO;
                }
                
                [self.collectTable reloadData];
            });

        }];
        
    });
}

- (void)createCollectTable{

    self.collectTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, HEIGHT5S(568-64)) style:UITableViewStylePlain];
    
    self.collectTable.delegate = self;
    self.collectTable.dataSource = self;
    
    self.collectTable.showsVerticalScrollIndicator = NO;
    
    self.collectTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.collectTable];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _FMutArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    CollectCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"collect"];
    
    if (cell == nil) {
        
        cell = [[CollectCellTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"collect"];
    }
    
    cell.collectHouseImage.image = [UIImage imageNamed:@"house.jpg"];
    
    cell.collectHouseNamelabel.text = _FMutArr[indexPath.row][@"houseinfo_name"];
    
    cell.collectHouseAddresslabel.text = _FMutArr[indexPath.row][@"houseinfo_address"];
    
    cell.collectHouseRentlabel.text = [NSString stringWithFormat:@"%@/月",_FMutArr[indexPath.row][@"houseinfo_rent"]] ;
    
    cell.collectHouseApartmentlabel.text = _FMutArr[indexPath.row][@"housetype_name"];
    
    if ([_FMutArr[indexPath.row][@"houseinfo_rentstyle"] isEqualToString:@"0"]) {
        
        cell.collectHouseStylelabel.text = @"整租";
        
    }else{
    
        cell.collectHouseStylelabel.text = @"分租";
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return WIDTH5S(120);
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{

    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{

    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{

    [self.FMutArr removeObjectAtIndex:indexPath.row];
    
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

    NSString *houseID = _FMutArr[indexPath.row][@"houseinfo_id"];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       
        [FavoritesService FavoritesDelete:_userID andHouseInfoId:houseID andSuccess:^(NSDictionary *dic) {
           
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.collectTable reloadData];
            });
        }];
    });
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)BACK{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    self.tabBarController.hidesBottomBarWhenPushed = NO;
}

@end
