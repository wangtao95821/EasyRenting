//
//  SearchPageViewController.m
//  EasyRenting
//
//  Created by administrator on 16/3/28.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "SearchPageViewController.h"
#import "Define.h"
#import "SearchPageCell.h"
#import "SearchInfoViewController.h"
#import "DistrictPageViewController.h"
#import "HouseInfoViewController.h"
#import "GetDistrictHouseInfoService.h"
#import "GetCityHouseInfoService.h"
#import "CityDistrictService.h"
#import "Quantity.h"
#import "MBProgressHUD.h"
#import "MJRefresh.h"
#import "LocationViewController.h"
#import "LoginChatService.h"
#import "UIImageView+WebCache.h"
#import "FetchPicService.h"
@interface SearchPageViewController ()

@property (strong, nonatomic) NSMutableArray *houseInfoArr;

@property (strong, nonatomic) Quantity *amount;

@property (assign, nonatomic) int i;

@property (strong, nonatomic) NSMutableArray *imaUrlArr;
@end

@implementation SearchPageViewController

- (instancetype)initWithPath:(NSString *)KeyPath{
    self = [super init];
    if (self) {
        self.amount = [Quantity addInstance];
        [self.amount addObserver:self forKeyPath:KeyPath options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:YES];
//    
//        self.i = 1;
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            //请求数据，得到区域内所有房屋信息
//            GetCityHouseInfoService *service = [[GetCityHouseInfoService alloc]init];
//            CityDistrictService *service1 = [[CityDistrictService alloc]init];
//            NSString *cityStr = self.cityNameBtn.titleLabel.text;
//            [service CityName:cityStr WithPageIndex:_i andSuccessWith:^(NSMutableArray *arr) {
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [service1 ProvinceName:_provinceStr CityNameWith:cityStr AndCityDistrictWith:^(NSArray *cityDistrict) {
//                        [self.houseInfoArr setArray:arr];
//                        if (_houseInfoArr.count > 0) {
//                            [self.blankLabel removeFromSuperview];
//                            [self imaUrlArr];
//                        }
//                        [self update:cityDistrict];
//                        [self.myTable reloadData];
//                        
//                      
//                    }];
//                    
//                });
//                
//            }];
//            
//        });
// 
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.i = 1;
    
    [self indeterminateExample];
  
    //把原先的顶部导航隐藏，使用自定义的view代替
    self.navigationController.navigationBar.hidden = YES;
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    self.headView.backgroundColor = COLOR(243, 198, 1, 1);
    [self.view addSubview:self.headView];
    
    self.cityNameBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, WIDTH5S(65.0), 44)];
    [self.cityNameBtn setTitle:@"苏州市" forState:UIControlStateNormal];
    self.cityNameBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.cityNameBtn setTitleColor:COLOR(254, 252, 192, 1) forState:UIControlStateNormal];
    [self.cityNameBtn addTarget:self action:@selector(selectCity) forControlEvents:UIControlEventTouchUpInside];
    [self.headView addSubview:self.cityNameBtn];
    
    self.searchText = [[UITextField alloc]initWithFrame:CGRectMake(WIDTH5S(66), 28, WIDTH5S(240), 28)];
    self.searchText.delegate = self;
    self.searchText.backgroundColor = [UIColor whiteColor];
    self.searchText.placeholder = @"    请输入您想查找房屋名";
    self.searchText.font = [UIFont systemFontOfSize:12];
    self.searchText.layer.cornerRadius = 5;
    [self.headView addSubview:self.searchText];

    self.searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(266), 28, WIDTH5S(44), 28)];
    [self.searchBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.searchBtn setTitleColor:COLOR(254, 252, 192, 1) forState:UIControlStateNormal];
    self.searchBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.headView addSubview:self.searchBtn];
    self.searchBtn.hidden = YES;
    [self.searchBtn addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    
    [self.cityNameBtn setTitle:[self.amount.cityDic objectForKey:_provinceStr] forState:UIControlStateNormal];
    self.provinceStr = [self.amount.cityDic allKeys][0];
    self.houseInfoArr = [NSMutableArray arrayWithCapacity:0];
    
//    [self performSelector:@selector(textExample) withObject:nil afterDelay:15];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //请求数据
        GetCityHouseInfoService *service = [[GetCityHouseInfoService alloc]init];
        NSString *cityStr = self.cityNameBtn.titleLabel.text;
        [service CityName:cityStr WithPageIndex:_i andSuccessWith:^(NSMutableArray *arr) {
            dispatch_async(dispatch_get_main_queue(), ^{
    
                [self.houseInfoArr setArray:arr];
                [self imaUrl];
                [self.myTable reloadData];
                self.i++;
                if (_houseInfoArr.count == 0) {
                    self.blankLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH5S(80), HEIGHT5S(200), WIDTH5S(160), 20)];
                    
                    self.blankLabel.textAlignment = NSTextAlignmentCenter;
                    self.blankLabel.textColor = SMALLWORD;
                    self.blankLabel.text = @"未找到相关房屋信息";
                    [self.myTable addSubview:self.blankLabel];
                }

            });
            
            
        }];
        
    });
    
    //获取区域名
    CityDistrictService *service = [[CityDistrictService alloc]init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *cityStr = self.cityNameBtn.titleLabel.text;
        [service ProvinceName:_provinceStr CityNameWith:cityStr AndCityDistrictWith:^(NSArray *cityDistrict) {
            dispatch_async(dispatch_get_main_queue(), ^{
               
                [self addView:cityDistrict];
                [self.myTable reloadData];
                
            });
            
        }];
        
    });
    
  
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"cityDic"]) {
        NSDictionary *dic = self.amount.cityDic;
        self.provinceStr = [dic allKeys][0];
        [self.cityNameBtn setTitle:[dic objectForKey:_provinceStr] forState:UIControlStateNormal];
        [self refreshData];
    }
}

- (void)selectCity{
    

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



- (void)districtInfo:(UIButton *)sender{
    long int i = [sender tag];
    DistrictPageViewController *dvc = [[DistrictPageViewController alloc]init];
    UIButton *btn = (UIButton *)[self.view viewWithTag:i];
    NSString *str = btn.titleLabel.text;
    NSString *cityStr = self.cityNameBtn.titleLabel.text;
    dvc.districtStr = str;
    dvc.cityStr = cityStr;
    self.tabBarController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:dvc animated:YES];
    
}

- (void)search{
    
    SearchInfoViewController *svc = [[SearchInfoViewController alloc]init];
    self.tabBarController.hidesBottomBarWhenPushed = YES;
    NSString *str = self.searchText.text;
    NSString *cityStr = self.cityNameBtn.titleLabel.text;
    svc.searchStr = str;
    svc.cityStr = cityStr;
    [self hidden];
    [self.view endEditing:YES];
    [self.navigationController pushViewController:svc animated:YES];
    
}
//点击textfield时，弹出键盘，使textfield变短且让按钮出现
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    self.blankView.hidden = NO;
    textField.text = nil;
    [UIView animateWithDuration:0.3 animations:^{
        self.searchText.frame = CGRectMake(WIDTH5S(66), 28, WIDTH5S(190), 28);
        self.blankView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    }];
    self.searchBtn.hidden = NO;
    return YES;
}
//键盘收回时，使textfield和按钮恢复原状
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.searchText.frame = CGRectMake(WIDTH5S(66), 28, WIDTH5S(240), 28);
        self.blankView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        self.blankView.hidden = YES;
    }];
    self.searchBtn.hidden = YES;
    return YES;
}

- (void)hidden{
    [UIView animateWithDuration:0.3 animations:^{
        self.searchText.frame = CGRectMake(WIDTH5S(66), 28, WIDTH5S(240), 28);
        self.blankView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        self.blankView.hidden = YES;
    }];
    self.searchBtn.hidden = YES;
    
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}


//在页面中添加视图
- (void)addView:(NSArray*)cityDistrict{
    //初始化tableView
    self.myTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-49) style:UITableViewStylePlain];
    self.myTable.delegate = self;
    self.myTable.dataSource = self;
    self.myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTable.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.myTable];
    
    //tableView的头视图
    UIView *myView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT5S(170))];
    myView.backgroundColor = [UIColor whiteColor];
    UILabel *lineLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(10, HEIGHT5S(20), SCREEN_WIDTH-20, 0.8)];
    lineLabel1.layer.borderWidth = 1;
    lineLabel1.layer.borderColor = COLOR(223, 223, 223, 1).CGColor;
    [myView addSubview:lineLabel1];
    
    UILabel *lineLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(10, HEIGHT5S(65), SCREEN_WIDTH-20, 0.8)];
    lineLabel2.layer.borderWidth = 1;
    lineLabel2.layer.borderColor = COLOR(223, 223, 223, 1).CGColor;
    [myView addSubview:lineLabel2];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, HEIGHT5S(28), WIDTH5S(30), WIDTH5S(30))];
    imageView.image = [UIImage imageNamed:@"搜索标"];
    [myView addSubview:imageView];
    
    UITableView *tableView = self.myTable;
    // 下拉刷新
    tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.i = 1;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            //请求数据，得到区域内所有房屋信息
            GetCityHouseInfoService *service = [[GetCityHouseInfoService alloc]init];
            CityDistrictService *service1 = [[CityDistrictService alloc]init];
            NSString *cityStr = self.cityNameBtn.titleLabel.text;
            [service CityName:cityStr WithPageIndex:_i andSuccessWith:^(NSMutableArray *arr) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [service1 ProvinceName:_provinceStr CityNameWith:cityStr AndCityDistrictWith:^(NSArray *cityDistrict) {
                        [self.houseInfoArr setArray:arr];
                        if (_houseInfoArr.count > 0) {
                            [self.blankLabel removeFromSuperview];
                            [self imaUrlArr];
                        }
                        [self update:cityDistrict];
                        [self.myTable reloadData];
                        
                        // 结束刷新
                        [tableView.mj_header endRefreshing];
                        
                    }];
  
                });
    
            }];
            
        });

    }];
    //隐藏时间显示
    MJRefreshNormalHeader *header = (MJRefreshNormalHeader *)tableView.mj_header;
    header.lastUpdatedTimeLabel.hidden = YES;
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    tableView.mj_header.automaticallyChangeAlpha = YES;
    
    
    // 上拉刷新
    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            //请求数据，得到区域内所有房屋信息
            GetCityHouseInfoService *service = [[GetCityHouseInfoService alloc]init];
            CityDistrictService *service1 = [[CityDistrictService alloc]init];
            NSString *cityStr = self.cityNameBtn.titleLabel.text;
            [service CityName:cityStr WithPageIndex:_i andSuccessWith:^(NSMutableArray *arr) {
                dispatch_async(dispatch_get_main_queue(), ^{
                   
                    [service1 ProvinceName:_provinceStr CityNameWith:cityStr AndCityDistrictWith:^(NSArray *cityDistrict) {
                        if (arr.count > 0) {
                            for (int i = 0; i < arr.count; i++) {
                                [self.houseInfoArr addObject:arr[i]];
                                
                            }
                            if (_houseInfoArr.count > 0) {
                                [self.blankLabel removeFromSuperview];
                                [self imaUrl];
                            }
                            
                            [self update:cityDistrict];
                            [self.myTable reloadData];
                        }
                        
                        self.i++;
                        // 结束刷新
                        [tableView.mj_footer endRefreshing];
                        
                    }];
                    
                });
                
            }];
            
        });
    }];

    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH5S(45), HEIGHT5S(35), WIDTH5S(116), HEIGHT5S(16))];
    label.font = [UIFont systemFontOfSize:12];
    label.text = @"找我附近的房子";
    [myView addSubview:label];
    
    self.locationBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, HEIGHT5S(20), SCREEN_WIDTH, HEIGHT5S(45))];
    self.locationBtn.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    [self.locationBtn addTarget:self action:@selector(location) forControlEvents:UIControlEventTouchUpInside];
    [myView addSubview:self.locationBtn];
    
    //分割区域
    UILabel *myLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT5S(155), SCREEN_WIDTH, HEIGHT5S(15))];
    myLabel.backgroundColor = COLOR(244, 244, 244, 1);
    [myView addSubview:myLabel];
    
    
    
    long int count;
    if (cityDistrict.count > 8) {
        count = 8;
    }else{
        count = cityDistrict.count;
    }
    NSMutableArray *districtArr = [NSMutableArray arrayWithCapacity:0];
    [districtArr setArray: [self district:cityDistrict andWithCount:count]];

    //城市地区按钮
    for (int i = 0; i < count; i++) {
        if (i <= 3) {
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(10+WIDTH5S(78)*i, HEIGHT5S(80), WIDTH5S(66), HEIGHT5S(25))];
            [btn setTitle:[districtArr[i] objectForKey:@"district"]  forState:UIControlStateNormal];
            [btn setTitleColor:COLOR(51, 51, 51, 1) forState:UIControlStateNormal];
            btn.layer.cornerRadius = 5;
            btn.layer.borderWidth = 1;
            btn.layer.borderColor = COLOR(223, 223, 223, 1).CGColor;
            btn.titleLabel.font = [UIFont systemFontOfSize:12];
            [btn addTarget:self action:@selector(districtInfo:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTag:10+i];
            [myView addSubview:btn];
        }else{
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(10+WIDTH5S(78)*(i-4), HEIGHT5S(118), WIDTH5S(66), HEIGHT5S(25))];
            [btn setTitle:[districtArr[i] objectForKey:@"district"] forState:UIControlStateNormal];
            [btn setTitleColor:COLOR(51, 51, 51, 1) forState:UIControlStateNormal];
            btn.layer.cornerRadius = 5;
            btn.layer.borderWidth = 1;
            btn.layer.borderColor = COLOR(223, 223, 223, 1).CGColor;
            btn.titleLabel.font = [UIFont systemFontOfSize:12];
            [btn addTarget:self action:@selector(districtInfo:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTag:10+i];
            [myView addSubview:btn];
        }
        
    }
    
    self.myTable.tableHeaderView = myView;
    
    
    self.blankView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-49)];
    self.blankView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    [self.view addSubview:self.blankView];
    self.blankView.hidden = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidden)];
    [self.blankView addGestureRecognizer:tap];
    
}

- (void)update:(NSArray *)cityDistrict{
    for (int i = 0; i < 8; i++) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:10+i];
        btn.hidden = YES;
    }
    
    long int count;
    if (cityDistrict.count > 8) {
        count = 8;
    }else{
        count = cityDistrict.count;
    }
    NSMutableArray *districtArr = [NSMutableArray arrayWithCapacity:0];
    [districtArr setArray: [self district:cityDistrict andWithCount:count]];
    
    for (int i = 0; i < count; i++) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:10+i];
        btn.hidden = NO;
        [btn setTitle:[districtArr[i] objectForKey:@"district"] forState:UIControlStateNormal];
        
    }
    
}


- (NSMutableArray *)district:(NSArray *)districtarr andWithCount:(long int)count{
    NSMutableArray *arrs = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];

    while (arr.count < count) {
        long int num = arc4random()%districtarr.count;
        NSString *str = [NSString stringWithFormat:@"%ld",num];
        if ([arr containsObject:str] == NO) {
            [arr addObject:str];
        }
    }
    for (int i = 0; i < arr.count; i++) {
        NSString *num = arr[i];
        int Num = [num intValue];
        [arrs addObject:districtarr[Num]];
    }
    return arrs;
    
}

//弹出的提示框
- (void)textExample {
    if (self.myTable != nil) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        // Set the annular determinate mode to show task progress.
        hud.mode = MBProgressHUDModeText;
        hud.label.text = NSLocalizedString(@"刷新成功!", @"HUD message title");
        // Move to bottm center.
        hud.offset = CGPointMake(0.f, 0.f);
        
        [hud hideAnimated:YES afterDelay:1.5f];
    }
    
    
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


- (void)location{
    
    LocationViewController *lvc = [[LocationViewController alloc]init];
    self.tabBarController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:lvc animated:YES];
    
    
}

- (void)refreshData{
    self.i = 1;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //请求数据，得到区域内所有房屋信息
        GetCityHouseInfoService *service = [[GetCityHouseInfoService alloc]init];
        CityDistrictService *service1 = [[CityDistrictService alloc]init];
        NSString *cityStr = self.cityNameBtn.titleLabel.text;
        [service CityName:cityStr WithPageIndex:_i andSuccessWith:^(NSMutableArray *arr) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [service1 ProvinceName:_provinceStr CityNameWith:cityStr AndCityDistrictWith:^(NSArray *cityDistrict) {
                    [self.houseInfoArr setArray:arr];
                    if (_houseInfoArr.count > 0) {
                        [self.blankLabel removeFromSuperview];
                        [self imaUrlArr];
                    }
                    [self update:cityDistrict];
                    [self.myTable reloadData];
                    
                    
                }];
                
            });
            
        }];
        
    });
    
}




@end
