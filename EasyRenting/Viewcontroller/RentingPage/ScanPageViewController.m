//
//  ScanPageViewController.m
//  二维码
//
//  Created by administrator on 16/4/12.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "ScanPageViewController.h"
#import "Define.h"
#import "houseService.h"
#import "RentHouseService.h"
#import "RentingPageViewController.h"
@interface ScanPageViewController ()

@property (strong, nonatomic)UILabel *timeLab;
@property (strong, nonatomic)UILabel *timeLab1;
@property (strong, nonatomic)UILabel *rentMoney;
@property (strong, nonatomic)UILabel *depositLab;
@property (strong, nonatomic)UILabel *titleLabel;
@property (strong, nonatomic)UIDatePicker *datePicker;
@property (strong, nonatomic)UIDatePicker *datePicker1;
@property (strong, nonatomic)NSDate *date;
@property (strong, nonatomic)NSDate *date1;
@property (strong, nonatomic)UIView *NavigationView;

@property (copy, nonatomic) NSString *timeStr;

@property (copy, nonatomic) NSString *rentStr;

@end

@implementation ScanPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UIImageView *backIma = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    backIma.image = [UIImage imageNamed:@"cccc.png"];
    [self.view addSubview:backIma];
    
    self.tabBarController.hidesBottomBarWhenPushed = YES;
    //自定义的顶部导航
    self.NavigationView  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    
    self.NavigationView.backgroundColor = NAVIGATIONCOLOR;
    
    [self.view addSubview:self.NavigationView];
    
    //导航栏上的返回键
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(2, 30, 25, 25)];
    
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back_select@2x"] forState:UIControlStateNormal];
    
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    [self.NavigationView addSubview:backBtn];

    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 20, 120, 44)];
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    
    self.titleLabel.text = @"xxxxx";
    
    self.titleLabel.textColor = COLOR(255, 253, 193, 1);
    
    [self.NavigationView addSubview:self.titleLabel];
    
    [self createDatePicker];
    
    
    self.timeLab = [[UILabel alloc]initWithFrame:CGRectMake(15, HEIGHT5S(70), SCREEN_WIDTH - 30, HEIGHT5S(20))];
    self.timeLab.font = FONT(15);
//    self.timeLab.textColor = NAVIGATIONCOLOR;
    [self.view addSubview:self.timeLab];
    
    self.timeLab1 = [[UILabel alloc]initWithFrame:CGRectMake(15, HEIGHT5S(220), SCREEN_WIDTH-30, HEIGHT5S(17))];
    self.timeLab1.font = FONT(15);
//    self.timeLab1.textColor = NAVIGATIONCOLOR;
    [self.view addSubview:self.timeLab1];
    
    self.rentMoney = [[UILabel alloc]initWithFrame:CGRectMake(15, HEIGHT5S(400), SCREEN_WIDTH/2-15, HEIGHT5S(17))];
    self.rentMoney.font = FONT(15);
//    self.rentMoney.textColor = NAVIGATIONCOLOR;
    [self.view addSubview:self.rentMoney];
    
    self.depositLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, HEIGHT5S(400), SCREEN_WIDTH/2-15, HEIGHT5S(20))];
    self.depositLab.font= FONT(15);
//    self.depositLab.textColor = NAVIGATIONCOLOR;
    [self.view addSubview:self.depositLab];
    
    [self getCurrentTime];
    
    UIButton *finishBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, HEIGHT5S(500), SCREEN_WIDTH-30, 40)];
    finishBtn.backgroundColor = NAVIGATIONCOLOR;
    [finishBtn setTitle:@"确定租房" forState:UIControlStateNormal];
    [finishBtn setTintColor:COLOR(255, 253, 193, 1)];
    [finishBtn addTarget:self action:@selector(finishBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    finishBtn.layer.cornerRadius = 5;
    [self.view addSubview:finishBtn];
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       
        [houseService houseInfoScan:_strScan andSuccess:^(NSDictionary *dic) {
           
            dispatch_async(dispatch_get_main_queue(), ^{
               
                self.recordDic = dic;
                
                self.rentStr = [dic objectForKey:@"houseinfo_rent"];
 
                [self.view reloadInputViews];
            });
            
        }];
        
    });

}

#pragma mark - createDatePickerView
-(void)createDatePicker{
    self.datePicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0,HEIGHT5S(100), SCREEN_WIDTH, HEIGHT5S(100))];

    _datePicker.backgroundColor=[UIColor clearColor];
    [self.datePicker addTarget:self action:@selector(changeDate:) forControlEvents:UIControlEventValueChanged];
    
    _datePicker.datePickerMode = UIDatePickerModeDate;
    
    [self.view addSubview:_datePicker];
    //设置显示格式
    //默认根据手机本地设置显示为中文还是其他语言
//        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中文显示
    self.datePicker.locale = [NSLocale currentLocale];
//    self.datePicker1.locale = locale;
    
    
    self.datePicker1=[[UIDatePicker alloc]initWithFrame:CGRectMake(0,HEIGHT5S(250), SCREEN_WIDTH, HEIGHT5S(100))];

    _datePicker1.backgroundColor=[UIColor clearColor];
    
    _datePicker1.datePickerMode = UIDatePickerModeDate;
    
    [_datePicker1 addTarget:self action:@selector(changeDate:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_datePicker1];
    //设置显示格式
    //默认根据手机本地设置显示为中文还是其他语言
    //    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中文显示
    _datePicker1.locale = [NSLocale currentLocale];

    

}
-(void)changeDate:(UIDatePicker *)datePicker{
    //获取当前时间
    if ([datePicker isEqual:_datePicker]) {
        self.date=[datePicker date];
        //设置时间格式
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        //时间转化
        NSString *dateString = [dateFormatter stringFromDate:_date];

        self.timeLab.text=[NSString stringWithFormat:@"从：%@",dateString];
    }else{
        self.date1=[datePicker date];
        //设置时间格式
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        //时间转化
        NSString *dateString = [dateFormatter stringFromDate:_date1];

        self.timeLab1.text = [NSString stringWithFormat:@"至：%@",dateString];
    }
    NSTimeInterval time=[_date1 timeIntervalSinceDate:_date];
    
    int days=((int)time)/(3600*24*30);
    
    int days1 = ((int)time)%(3600*24*30)/(3600*24);

    int rent = 500;
    
    if (days1 > 15) {
        int rentmoney = (days + 1) * _rentStr.intValue;
        self.rentMoney.text = [NSString stringWithFormat:@"租金：%d",rentmoney];
        
    }else{
        int rentmoney = days  * _rentStr.intValue;
        self.rentMoney.text = [NSString stringWithFormat:@"租金：%d",rentmoney];
    }
    
    self.depositLab.text = [NSString stringWithFormat:@"押金：%d",rent];
    
}

#pragma mark - 获取当前时间
- (void)getCurrentTime{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    dateFormatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    NSString *dateString =[dateFormatter stringFromDate:[NSDate date]];
    self.timeLab.text=[NSString stringWithFormat:@"从：%@",dateString];
    self.timeLab1.text=[NSString stringWithFormat:@"至：%@",dateString];

}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self changeDate:_datePicker];
    [self changeDate:_datePicker1];
}

- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    self.tabBarController.hidesBottomBarWhenPushed = NO;
}

//确定租房
- (void)finishBtnClick:(UIButton *)sender{

    self.tabBarController.hidesBottomBarWhenPushed = NO;
    
    NSMutableDictionary *recordMutDic = [NSMutableDictionary dictionaryWithCapacity:0];
    
    [recordMutDic setObject:[_recordDic objectForKey:@"t_user_user_id"] forKey:@"userid"];
    [recordMutDic setObject:[_recordDic objectForKey:@"houseinfo_name"] forKey:@"housename"];
    [recordMutDic setObject:[_recordDic objectForKey:@"houseinfo_address"] forKey:@"houseaddress"];
    [recordMutDic setObject:[_recordDic objectForKey:@"houseinfo_area"] forKey:@"housearea"];
    [recordMutDic setObject:[_recordDic objectForKey:@"houseinfo_floor"] forKey:@"housefloor"];
    [recordMutDic setObject:[_recordDic objectForKey:@"house_apartment"] forKey:@"houseapartment"];
    [recordMutDic setObject:[_recordDic objectForKey:@"houseinfo_description"] forKey:@"housedescription"];
    [recordMutDic setObject:[_recordDic objectForKey:@"houseinfo_facility"] forKey:@"housefacility"];
    [recordMutDic setObject:[_recordDic objectForKey:@"houseinfo_rentstyle"] forKey:@"houserentstyle"];
    [recordMutDic setObject:[_recordDic objectForKey:@"houseinfo_rent"] forKey:@"houserent"];
    [recordMutDic setObject:[_recordDic objectForKey:@"city_name"] forKey:@"cityname"];
    [recordMutDic setObject:[_recordDic objectForKey:@"housetype_style"] forKey:@"housetypestyle"];
    [recordMutDic setObject:[_recordDic objectForKey:@"district_name"] forKey:@"housedistrictname"];
    [recordMutDic setObject:[_recordDic objectForKey:@"contacts_name"] forKey:@"contactname"];
    [recordMutDic setObject:[_recordDic objectForKey:@"contacts_phone"] forKey:@"contactphone"];
    [recordMutDic setObject:[_recordDic objectForKey:@"houseinfo_id"] forKey:@"houseinfoid"];
    [recordMutDic setObject:_date1 forKey:@"housetime"];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [RentHouseService recordHouse:recordMutDic andSuccess:^(NSDictionary *dic) {
            
        }];
        
        [RentHouseService finishRent:_strScan andSuccess:^(NSDictionary *dic) {
        
            dispatch_async(dispatch_get_main_queue(), ^{

            });
        }];
    });
    
    
    RentingPageViewController *homevc = [[RentingPageViewController alloc]init];
    
    [self.navigationController pushViewController:homevc animated:YES];
    
    
}

@end
