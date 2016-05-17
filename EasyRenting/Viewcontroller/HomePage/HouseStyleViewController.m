//
//  HouseStyleViewController.m
//  EasyRenting
//
//  Created by administrator on 16/3/29.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "HouseStyleViewController.h"
#import "Define.h"
#import "SearchPageCell.h"
#import "SequenceListCell.h"
#import "HouseInfoViewController.h"
#import "RentRangeService.h"
#import "HomePageTableViewCell.h"
#import "CityDistrictService.h"
#import "houseStyleService.h"
#import "RentSequenceService.h"
#import "AreaSequenceService.h"
#import "MBProgressHUD.h"
#import "UIImageView+WebCache.h"
@interface HouseStyleViewController ()
@property (assign, nonatomic) long int i;
@property (assign, nonatomic) BOOL isShow;

@property (strong, nonatomic) NSArray *rentArr;
@property (strong, nonatomic) NSArray *apartmentArr;
@property (strong, nonatomic) NSArray *sequenceArr;

@property (strong, nonatomic) NSArray *houseInfoArr;
@property (strong, nonatomic) NSMutableArray *resultArr;
@property (strong, nonatomic) NSMutableArray *tableArr;

@property (strong, nonatomic)NSMutableArray *imaUrlArr;

@property (strong, nonatomic) MBProgressHUD *hud;
@end

@implementation HouseStyleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isShow = NO;
    self.i = 0;
    self.rentArr = @[@"不限",@"1500元以下",@"1500元-2000元",@"2000元-2500元",@"2500元-3000元",@"3000元-3500元",@"3500元以上"];
//    self.apartmentArr = @[@"不限",@"吴中区",@"工业园区",@"相城区",@"沧浪区"];
    self.sequenceArr = @[@"默认排序",@"面积从小到大",@"面积从大到小",@"价格从高到低",@"价格从低到高"];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = YES;
    
    self.tableArr = [NSMutableArray arrayWithCapacity:0];
    
    
    
    
    self.resultArr = [NSMutableArray arrayWithCapacity:0];
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

    
    self.titleName = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH5S(101), 32, WIDTH5S(118), 20)];
    self.titleName.font = [UIFont systemFontOfSize:15.0];
    self.titleName.textColor = COLOR(254, 252, 192, 1);
    self.titleName.textAlignment = NSTextAlignmentCenter;
    self.titleName.text = self.titleStr;
    [self.view addSubview:self.titleName];
    
    self.myTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 64+HEIGHT5S(42), SCREEN_WIDTH, SCREEN_HEIGHT-64-49)];
    self.myTable.dataSource = self;
    self.myTable.delegate = self;
    self.myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTable.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.myTable];
    
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
    
    NSArray *arr = @[@"价格",@"区域",@"排序"];
    for (int i = 0; i < 3; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(i*WIDTH5S(104)+i*1, 0, WIDTH5S(104), WIDTH5S(42)-1)];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
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
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
    });
    
    
    
    
    CityDistrictService *cds = [[CityDistrictService alloc]init];
    
    [cds ProvinceName:self.provinceName CityNameWith:self.cityName AndCityDistrictWith:^(NSArray *cityDistrict) {
        self.apartmentArr = cityDistrict;
//        NSLog(@"%@------%@",cityDistrict,self.cityName);
        
        [self.apartmentTable reloadData];
    }];
    
    [self houseInfo];
    
    self.hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        
//        sleep(1.);
        
        dispatch_async(dispatch_get_main_queue(), ^{
//            [hud hideAnimated:YES];
        });
    });

    
    // Do any additional setup after loading the view.
}


- (void)houseInfo{
    
    [houseStyleService cityName:self.cityName houseStyleWith:self.houseStyle successWith:^(NSArray *arr) {
        NSLog(@"%@",arr);
        
        if (arr.count > 0) {
            
            [self.hud hideAnimated:YES];
            
            self.houseInfoArr = arr;
            
            [self.tableArr setArray:self.houseInfoArr];
            
            [self.myTable reloadData];
        }else{
        
            sleep(10.);
            
            [self.hud hideAnimated:YES];
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT/3, SCREEN_WIDTH, 30)];
            label.font = FONT(15);
            label.textAlignment = NSTextAlignmentCenter;
            label.text = @"没有相关数据！";
            [self.myTable addSubview:label];
        }
       
        [self imaUrl];
    }];
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
        return self.tableArr.count;
    }else if (tableView == self.rentTable){
        return self.rentArr.count;
    }else if (tableView == self.apartmentTable){
        return self.apartmentArr.count + 1;
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
        
        HomePageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str1];
        if (cell == nil) {
            cell = [[HomePageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str1];
        }
        if (self.imaUrlArr.count == self.houseInfoArr.count) {
            [cell.houseImage sd_setImageWithURL:[NSURL URLWithString:self.imaUrlArr[indexPath.row]] placeholderImage:[UIImage imageNamed:@"house.jpg"]];
            
        }

        cell.houseNamelabel.text = self.tableArr[indexPath.row][@"houseinfo_name"];
        
        cell.houseAddresslabel.text = self.tableArr[indexPath.row][@"district_name"];
        
        NSString *rent = [NSString stringWithFormat:@"%@/月",self.tableArr[indexPath.row][@"houseinfo_rent"]];
        cell.houseRentlabel.text = rent;
        
        cell.houseApartmentlabel.text = self.tableArr[indexPath.row][@"housetype_name"];
        
        if ([(self.tableArr[indexPath.row][@"houseinfo_rentstyle"]) isEqualToString: @"0"] ) {
            cell.houseStylelabel.text = @"整租";
        }else{
            cell.houseStylelabel.text = @"分租";
        }
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
        
        if (indexPath.row > 0) {
            cell.contentLabel.text = _apartmentArr[indexPath.row - 1][@"district"];
        }else{
            cell.contentLabel.text =@"不限";
        }
        
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
    
    if (tableView == _myTable) {
        
        HouseInfoViewController *vc = [[HouseInfoViewController alloc]init];
        self.tabBarController.hidesBottomBarWhenPushed = YES;
        vc.isOnePage = NO;
        
        vc.houseinfoDic = self.tableArr[indexPath.row];
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
        if (indexPath.row > 0) {
            NSString *areaNameStr = _apartmentArr[indexPath.row - 1][@"district"];
            
            for (int i = 0; i<_houseInfoArr.count; i++) {
                if ([areaNameStr isEqualToString:_houseInfoArr[i][@"district_name"]]) {
                    [sendArr addObject:_houseInfoArr[i]];
                    
                }
                
            }
            [self.tableArr setArray:sendArr];
            [self.myTable reloadData];
        }else{
            [self.tableArr setArray:_houseInfoArr];
            [self.myTable reloadData];
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
        
        
        //        UIButton *btn = (UIButton *)[self.view viewWithTag:3002];
        //        [btn setTitle:self.sequenceArr[indexPath.row] forState:UIControlStateNormal];
       
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
