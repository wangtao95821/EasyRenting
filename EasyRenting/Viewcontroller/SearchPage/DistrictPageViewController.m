//
//  DistrictPageViewController.m
//  EasyRenting
//
//  Created by administrator on 16/3/28.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "DistrictPageViewController.h"
#import "Define.h"
#import "SearchPageCell.h"
#import "SequenceListCell.h"
#import "RentRangeService.h"
#import "RentSequenceService.h"
#import "AreaSequenceService.h"
#import "ApartmentService.h"
#import "HouseInfoViewController.h"
#import "GetDistrictHouseInfoService.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"
#import "FetchPicService.h"
#import "UIImageView+WebCache.h"
@interface DistrictPageViewController ()

@property (assign, nonatomic) long int i;
@property (assign, nonatomic) BOOL isShow;
@property (assign, nonatomic) long int rowscount;
@property (strong, nonatomic) NSMutableArray *tableArr;

@property (strong, nonatomic) NSArray *rentArr;
@property (strong, nonatomic) NSArray *apartmentArr;
@property (strong, nonatomic) NSArray *sequenceArr;

@property (strong, nonatomic) NSMutableArray *imaUrlArr;




@end

@implementation DistrictPageViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.houseInfoArr = [NSMutableArray arrayWithCapacity:0];
    
    self.resultArr = [NSMutableArray arrayWithCapacity:0];
   
    self.tableArr = [NSMutableArray arrayWithCapacity:0];
    
    self.imaUrlArr = [NSMutableArray arrayWithCapacity:0];
    self.isShow = NO;
    self.i = 0;
    self.rentArr = @[@"不限",@"1500元以下",@"1500元-2000元",@"2000元-2500元",@"2500元-3000元",@"3000元-3500元",@"3500元以上"];
    self.apartmentArr = @[@"不限",@"1居",@"2居",@"3居",@"4居",@"4居以上"];
    self.sequenceArr = @[@"默认排序",@"面积从小到大",@"面积从大到小",@"价格从高到低",@"价格从低到高"];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //把原先的顶部导航隐藏，使用自定义的view代替
    self.navigationController.navigationBar.hidden = YES;
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    self.headView.backgroundColor = COLOR(243, 198, 1, 1);
    [self.view addSubview:self.headView];
    
    //导航栏上的返回键
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 60, 44)];
    
    //    [backBtn setBackgroundImage:[UIImage imageNamed:@"back_select@2x"] forState:UIControlStateNormal];
    
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    [self.headView addSubview:backBtn];
    
    UIImageView *backIma = [[UIImageView alloc]initWithFrame:CGRectMake(2, 10, 25, 25)];
    backIma.image = [UIImage imageNamed:@"back_select@2x"];
    [backBtn addSubview:backIma];

    
    self.districtName = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH5S(101), 32, WIDTH5S(118), 20)];
    self.districtName.font = [UIFont systemFontOfSize:15.0];
    self.districtName.textColor = COLOR(254, 252, 192, 1);
    self.districtName.textAlignment = NSTextAlignmentCenter;
    self.districtName.text = self.districtStr;
    [self.view addSubview:self.districtName];
 
    [self indeterminateExample];
    //得到地区房屋信息
    GetDistrictHouseInfoService *service = [[GetDistrictHouseInfoService alloc]init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [service CityName:_cityStr AndDistrictName:self.districtStr andSuccessWith:^(NSMutableArray *arr) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.houseInfoArr setArray:arr];
                [self.tableArr setArray:self.houseInfoArr];
                [self imaUrl];
                [self hideMBProgressHUD];
                [self addView];
                if (_tableArr.count == 0) {
                    self.blankLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH5S(80), HEIGHT5S(100), WIDTH5S(160), 20)];
                    self.blankLabel.textAlignment = NSTextAlignmentCenter;
                    self.blankLabel.textColor = SMALLWORD;
                    self.blankLabel.text = @"未找到相关房屋信息";
                    [self.myTable addSubview:self.blankLabel];
                }
            });
        }];
        
        
    });
    

    
    

    
    
}
//显示选项列表
- (void)showList:(UIButton *)sender{
    
    if (_isShow == NO) {
        self.isShow = YES;
        if ([sender tag] == 3000) {
            
            self.rentTable.hidden = NO;
            self.apartmentTable.hidden = YES;
            self.sequenceTable.hidden = YES;
            
        }else if ([sender tag] == 3001){
            self.rentTable.hidden = YES;
            self.apartmentTable.hidden = NO;
            self.sequenceTable.hidden = YES;
        }else{
            
            self.rentTable.hidden = YES;
            self.apartmentTable.hidden = YES;
            self.sequenceTable.hidden = NO;
        }

        self.i = [sender tag];
        UIView *view = (UIView *)[self.view viewWithTag:3010];
        view.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            view.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
        }];
    }else{
        if (_i == [sender tag]) {
            
            UIView *view = (UIView *)[self.view viewWithTag:3010];
            view.hidden = YES;
            self.rentTable.hidden = YES;
            self.apartmentTable.hidden = YES;
            self.sequenceTable.hidden = YES;
            self.isShow = NO;
            self.i = 0;
            
        }else{
            if ([sender tag] == 3000) {
                self.isShow = YES;
                self.rentTable.hidden = NO;
                self.apartmentTable.hidden = YES;
                self.sequenceTable.hidden = YES;
                
            }else if ([sender tag] == 3001){
                self.isShow = YES;
                self.rentTable.hidden = YES;
                self.apartmentTable.hidden = NO;
                self.sequenceTable.hidden = YES;
            }else{
                self.isShow = YES;
                self.rentTable.hidden = YES;
                self.apartmentTable.hidden = YES;
                self.sequenceTable.hidden = NO;
            }
            
            self.i = [sender tag];
            
        }
  
    }
    
}

//点击空白隐藏
- (void)hiddenList{
    UIView *view = (UIView *)[self.view viewWithTag:3010];
    view.hidden = YES;
    self.rentTable.hidden = YES;
    self.apartmentTable.hidden = YES;
    self.sequenceTable.hidden = YES;
    self.isShow = NO;
    self.i = 0;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.myTable) {
        [self hideMBProgressHUD];
        return _tableArr.count;
    }else if (tableView == self.rentTable){
        return 7;
    }else if (tableView == self.apartmentTable){
        return 6;
    }else{
        
        return 5;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (tableView == self.myTable) {
        return HEIGHT5S(120);
    }else{
        
        return HEIGHT5S(44);
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str1 = @"district";
    static NSString *str2 = @"list";
    if (tableView == self.myTable) {
        
        SearchPageCell *cell = [tableView dequeueReusableCellWithIdentifier:str1];
        if (cell == nil) {
            cell = [[SearchPageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str1];
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
    }else if (tableView == self.rentTable){
        SequenceListCell *cell = [tableView dequeueReusableCellWithIdentifier:str2];
        if (cell == nil) {
            cell = [[SequenceListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str2];
        }
        cell.contentLabel.text = _rentArr[indexPath.row];
        return cell;
        
    }else if (tableView == self.apartmentTable){
        SequenceListCell *cell = [tableView dequeueReusableCellWithIdentifier:str2];
        if (cell == nil) {
            cell = [[SequenceListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str2];
        }
        cell.contentLabel.text = _apartmentArr[indexPath.row];
        return cell;
    }else{
        SequenceListCell *cell = [tableView dequeueReusableCellWithIdentifier:str2];
        if (cell == nil) {
            cell = [[SequenceListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str2];
        }
        cell.contentLabel.text = _sequenceArr[indexPath.row];
        return cell;
        
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.blankLabel removeFromSuperview];
    if (tableView == _myTable) {
        
        HouseInfoViewController *vc = [[HouseInfoViewController alloc]init];
        self.tabBarController.hidesBottomBarWhenPushed = YES;
        vc.isOnePage = YES;
        vc.houseinfoDic = _houseInfoArr[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
        
        
        
    }else if (tableView == _rentTable){
        RentRangeService *service = [[RentRangeService alloc]init];
        if (indexPath.row == 0) {
            //不限租金范围的排序
            [service houseInfo:self.houseInfoArr andWithLowestPrice:@"0" andWithHighestPrice:@"0" andsuccessWith:^(NSArray *arr) {
                [self.resultArr setArray:arr];
                [self.tableArr setArray:self.houseInfoArr];
                [self.myTable reloadData];
            }];
        }else if (indexPath.row == 1){
            //1500以下所有信息
            [service houseInfo:self.houseInfoArr andWithLowestPrice:@"0" andWithHighestPrice:@"1500" andsuccessWith:^(NSArray *arr) {
                [self.resultArr setArray:arr];
                [self.tableArr setArray:self.resultArr];
                [self.myTable reloadData];
            }];
            
        }else if (indexPath.row == 2){
            //1500-2000
            [service houseInfo:self.houseInfoArr andWithLowestPrice:@"1500" andWithHighestPrice:@"2000" andsuccessWith:^(NSArray *arr) {
                [self.resultArr setArray:arr];
                [self.tableArr setArray:self.resultArr];
                [self.myTable reloadData];
            }];
        }else if (indexPath.row == 3){
            //2000-2500
            [service houseInfo:self.houseInfoArr andWithLowestPrice:@"2000" andWithHighestPrice:@"2500" andsuccessWith:^(NSArray *arr) {
                [self.resultArr setArray:arr];
                [self.tableArr setArray:self.resultArr];
                [self.myTable reloadData];
            }];
        }else if (indexPath.row == 4){
            //2500-3000
            [service houseInfo:self.houseInfoArr andWithLowestPrice:@"2500" andWithHighestPrice:@"3000" andsuccessWith:^(NSArray *arr) {
                [self.resultArr setArray:arr];
                [self.tableArr setArray:self.resultArr];
                [self.myTable reloadData];
            }];
        }else if (indexPath.row == 5){
            //3000-3500
            [service houseInfo:self.houseInfoArr andWithLowestPrice:@"3000" andWithHighestPrice:@"3500" andsuccessWith:^(NSArray *arr) {
                [self.resultArr setArray:arr];
                [self.tableArr setArray:self.resultArr];
                [self.myTable reloadData];
            }];
            
        }else if (indexPath.row == 6){
            //3500以上
            [service houseInfo:self.houseInfoArr andWithLowestPrice:@"3500" andWithHighestPrice:@"0" andsuccessWith:^(NSArray *arr) {
                [self.resultArr setArray:arr];
                [self.tableArr setArray:self.resultArr];
                [self.myTable reloadData];
            }];
        }

    }else if (tableView == _apartmentTable){
        NSMutableArray *sendArr = [NSMutableArray arrayWithCapacity:0];
        //如果处理后的数组没有值则传所有房屋信息
        if (_resultArr.count == 0) {
            [sendArr setArray:_houseInfoArr];
        }else{
            [sendArr setArray:_resultArr];
        }
        
        if (indexPath.row == 0) {
            [self.tableArr setArray:sendArr];
            [self.myTable reloadData];
            
        }else{
            ApartmentService *service = [[ApartmentService alloc]init];
            [service houseInfo:sendArr andWithApartment:[NSString stringWithFormat:@"%ld",indexPath.row] andSuccessWith:^(NSMutableArray *arr) {
                [self.tableArr setArray:arr];
                [self.myTable reloadData];
            }];
        }
        

    }else if (tableView == _sequenceTable){
        NSMutableArray *sendArr = [NSMutableArray arrayWithCapacity:0];
        //如果处理后的数组没有值则传所有房屋信息
        if (_resultArr.count == 0) {
            [sendArr setArray:_houseInfoArr];
        }else{
            [sendArr setArray:_resultArr];
        }
        
        if (indexPath.row == 0) {
            [self.tableArr setArray:sendArr];
            [self.myTable reloadData];
            
        }else if (indexPath.row == 1 || indexPath.row == 2){  //面积的俩个排序
            AreaSequenceService *service = [[AreaSequenceService alloc]init];
            NSString *sendStr;
            if (indexPath.row == 1) {
                sendStr = @"bigger";
            }else{
                sendStr = @"smaller";
            }
            [service houseInfo:sendArr andWithMethod:sendStr andSuccessWith:^(NSMutableArray *arr) {
                [self.tableArr setArray:arr];
                [self.myTable reloadData];

            }];
            
            
        }else if (indexPath.row == 3 || indexPath.row == 4){  //租金的排序
            
            RentSequenceService *service = [[RentSequenceService alloc]init];
            NSString *sendStr;
            if (indexPath.row == 3) {
                sendStr = @"lower";
            }else{
                sendStr = @"higher";
            }
            [service houseInfo:sendArr andWithMethod:sendStr andSuccessWith:^(NSMutableArray *arr) {
                [self.tableArr setArray:arr];
                [self.myTable reloadData];

            }];
        }

    }
    
    if (_tableArr.count == 0) {
        self.blankLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH5S(80), HEIGHT5S(100), WIDTH5S(160), 20)];
        self.blankLabel.textAlignment = NSTextAlignmentCenter;
        self.blankLabel.textColor = SMALLWORD;
        self.blankLabel.text = @"未找到相关房屋信息";
        [self.myTable addSubview:self.blankLabel];
    }

    [self hiddenList];
    
}

- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    self.tabBarController.hidesBottomBarWhenPushed = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addView{
    self.myTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 64+HEIGHT5S(42), SCREEN_WIDTH, SCREEN_HEIGHT-64-49)];
    self.myTable.dataSource = self;
    self.myTable.delegate = self;
    self.myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTable.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.myTable];
    
    UITableView *tableView = self.myTable;
    // 下拉刷新
    tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        GetDistrictHouseInfoService *service = [[GetDistrictHouseInfoService alloc]init];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [service CityName:_cityStr AndDistrictName:self.districtStr andSuccessWith:^(NSMutableArray *arr) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.houseInfoArr setArray:arr];
                    [self.tableArr setArray:self.houseInfoArr];
                    if (_tableArr.count > 0) {
                        [self.blankLabel removeFromSuperview];
                    }
                    [self imaUrlArr];
                    [self.myTable reloadData];
                    // 结束刷新
                    [tableView.mj_header endRefreshing];
                });
            }];
        });
      
    
        
    }];
    MJRefreshNormalHeader *header = (MJRefreshNormalHeader *)tableView.mj_header;
    header.lastUpdatedTimeLabel.hidden = YES;
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    tableView.mj_header.automaticallyChangeAlpha = YES;
    
    
    //选项view
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, HEIGHT5S(42))];
    view1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view1];
    
    UILabel *lineLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT5S(42)-1, SCREEN_WIDTH, 1)];
    lineLabel1.layer.borderColor = COLOR(223, 223, 223, 1).CGColor;
    lineLabel1.layer.borderWidth = 1;
    [view1 addSubview:lineLabel1];
    
    UILabel *lineLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH5S(105), HEIGHT5S(11), 1, HEIGHT5S(20))];
    lineLabel2.layer.borderColor = COLOR(223, 223, 223, 1).CGColor;
    lineLabel2.layer.borderWidth = 1;
    [view1 addSubview:lineLabel2];
    
    UILabel *lineLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH5S(209), HEIGHT5S(11), 1, HEIGHT5S(20))];
    lineLabel3.layer.borderColor = COLOR(223, 223, 223, 1).CGColor;
    lineLabel3.layer.borderWidth = 1;
    [view1 addSubview:lineLabel3];
    
    NSArray *arr = @[@"租金",@"户型",@"排序"];
    for (int i = 0; i < 3; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(i*WIDTH5S(104)+i*1, 0, WIDTH5S(104), WIDTH5S(42)-1)];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTag:3000+i];
        [btn addTarget:self action:@selector(showList:) forControlEvents:UIControlEventTouchUpInside];
        [view1 addSubview:btn];
    }
    
    self.rentTable = [[UITableView alloc]initWithFrame:CGRectMake(0, HEIGHT5S(42)+64, SCREEN_WIDTH, HEIGHT5S(213))];
    self.rentTable.delegate = self;
    self.rentTable.dataSource = self;
    self.rentTable.tableFooterView = [[UIView alloc]init];
    self.rentTable.hidden = YES;
    self.rentTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.rentTable];
    
    self.apartmentTable = [[UITableView alloc]initWithFrame:CGRectMake(0, HEIGHT5S(42)+64, SCREEN_WIDTH, HEIGHT5S(213))];
    self.apartmentTable.delegate = self;
    self.apartmentTable.dataSource = self;
    self.apartmentTable.tableFooterView = [[UIView alloc]init];
    self.apartmentTable.hidden = YES;
    self.apartmentTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.apartmentTable];
    
    self.sequenceTable = [[UITableView alloc]initWithFrame:CGRectMake(0, HEIGHT5S(42)+64, SCREEN_WIDTH, HEIGHT5S(213))];
    self.sequenceTable.delegate = self;
    self.sequenceTable.dataSource = self;
    self.sequenceTable.tableFooterView = [[UIView alloc]init];
    self.sequenceTable.hidden = YES;
    self.sequenceTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.sequenceTable];
    
    
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT5S(255)+64, SCREEN_WIDTH, SCREEN_HEIGHT-HEIGHT5S(255)-64)];
    view2.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    view2.hidden = YES;
    view2.tag = 3010;
    [self.view addSubview:view2];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenList)];
    [view2 addGestureRecognizer:tap];
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

//隐藏弹出的提示框
- (void)hideMBProgressHUD{
    MBProgressHUD *hud = (MBProgressHUD *)[self.view.window viewWithTag:3500];
    if (hud != nil) {
        hud.removeFromSuperViewOnHide = YES;
        [hud hideAnimated:YES];
    }
}

- (void)imaUrl{
    FetchPicService *fps = [[FetchPicService alloc]init];
    self.imaUrlArr = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < self.houseInfoArr.count; i++) {
        [fps houseInfoId:[self.tableArr[i][@"houseinfo_id"] intValue]  successWith:^(NSDictionary *dic) {
            NSArray *arr = dic[@"result"];
            NSString *picName = arr[0][@"houseimage_name"];
            NSString *newPicName = [NSString stringWithFormat:@"http://115.159.215.30/Tupian/image/%@",picName];
            
            [self.imaUrlArr addObject:newPicName];
            
            [self.myTable reloadData];
        }];
        
    }
    
    
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
    [self hideMBProgressHUD];
}



@end
