//
//  RentingHouseViewController.m
//  EasyRenting
//
//  Created by administrator on 16/3/28.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "RentingHouseViewController.h"
#import "Define.h"
#import "BtnView.h"
#import "TextFiled.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "FavoritesService.h"
#import "RentHouseService.h"
#import "houseService.h"
#import "ChangeCityViewControllers.h"
//#import <Photos/Photos.h>
#import "CityDistrictService.h"
#import "RentingPageViewController.h"
@interface RentingHouseViewController ()

@property (assign, nonatomic) int r;

@property (strong, nonatomic) NSMutableArray *mutArr;

@property (strong, nonatomic) UISlider *slider;

@property (strong, nonatomic) UILabel *sliderLabel;



@property (strong, nonatomic) UICollectionView *collect;

@property (strong, nonatomic)NSMutableArray *array;

@property (strong, nonatomic) UIImageView *imgView1;


@property (strong, nonatomic) UIButton *btnVV;

@property (copy, nonatomic) NSString *cityNameStr;

@property (copy, nonatomic) NSString *provinceStr;


@property (strong, nonatomic) UIButton *rentingBtn;

@property (strong, nonatomic)CityDistrictService *cds;
@end

@implementation RentingHouseViewController{
    
    ALAssetsLibrary *library;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.p = 0;
    
    self.s = 0;
    
    self.jointStr = @"N";
    
    
    UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    
    navView.backgroundColor = NAVIGATIONCOLOR;
    
    [self.view addSubview:navView];
    
    UILabel *navTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH5S(100), 20, WIDTH5S(120), 44)];
    
    navTitleLabel.text = @"出租";
    
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

    
    self.rentingBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(260), 30, WIDTH5S(50), 30)];
    
    [self.rentingBtn setTitle:@"城市▼" forState:UIControlStateNormal];
    
    [self.rentingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.rentingBtn.titleLabel.font = FONT(12);
    
    [self.rentingBtn addTarget:self action:@selector(cityPage) forControlEvents:UIControlEventTouchUpInside];
    
    [navView addSubview:self.rentingBtn];
    
    self.cds = [[CityDistrictService alloc]init];
    
    self.view.backgroundColor = COLOR(242, 242, 242, 1);
    
    [self createRound];
    
    [self createTitleLable];
    
    [self createPickerV];
    
    [self viewView];
    
    [self viewTextFiledView];
    
    [self createHouseStylePicker];
    
    [self createRentWay];
    
    [self createRentMoney];
    
    [self createHousePic];
    
    [self createConfirmBtn];
    
    self.isxiaoshi = YES;
    self.i = 0;
    
    [self createPhotos];

    
    self.roomArr = [NSMutableArray arrayWithCapacity:0];
    self.btnMutArr = [NSMutableArray arrayWithCapacity:0];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.tabBarController.hidesBottomBarWhenPushed= YES;
    
    [_cds ProvinceName:self.provinceStr CityNameWith:self.cityNameStr AndCityDistrictWith:^(NSArray *cityDistrict) {
        self.animationTypes2 = [NSMutableArray arrayWithCapacity:0];
        
        for (int i = 0; i < cityDistrict.count; i++) {
            [self.animationTypes2 addObject:cityDistrict[i][@"district"]];
        }
        self.animationPicker2 = [[UIPickerView alloc]initWithFrame:CGRectMake(WIDTH5S(135), HEIGHT5S(65-10), WIDTH5S(60), HEIGHT5S(110))];
        self.animationPicker2.dataSource =self;
        self.animationPicker2.delegate = self;
        [self.rentHouseScroll addSubview:self.animationPicker2];
        [[self.animationPicker2.subviews objectAtIndex:1] setHidden:TRUE];
        [[self.animationPicker2.subviews objectAtIndex:2] setHidden:TRUE];
        
        
        NSLog(@"////////***************%@",_cityNameStr);
    }];
    
}

- (void)BACK{
    
    [self.navigationController popViewControllerAnimated:YES];

}


//三个小圆
- (void)createRound{

    self.pView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, HEIGHT5S(64))];
    
    self.pView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.pView];
    
    self.lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH5S(10), 15, WIDTH5S(300), 1)];
    
    self.lineLabel.backgroundColor = COLOR(223, 223, 223, 1);
    
    [self.pView addSubview:self.lineLabel];
    
    self.Round1Label = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(48), 5, WIDTH5S(22), HEIGHT5S(22))];
    
    self.Round1Label.backgroundColor = COLOR(243, 197, 1, 1);
    
    self.Round1Label.layer.cornerRadius = 11;
    
    [self.pView addSubview:self.Round1Label];
    
    self.Round2Label = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(151), 5, WIDTH5S(22), HEIGHT5S(22))];
    
    self.Round2Label.backgroundColor = COLOR(243, 197, 1, 1);
    
    self.Round2Label.layer.cornerRadius = 11;
    
    [self.pView addSubview:self.Round2Label];
    
    self.Round3Label = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(251), 5, WIDTH5S(22), HEIGHT5S(22))];
    
    self.Round3Label.backgroundColor = COLOR(243, 197, 1, 1);
    
    self.Round3Label.layer.cornerRadius = 11;
    
    [self.pView addSubview:self.Round3Label];
    
    self.textLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH5S(100), (102-64), WIDTH5S(118), HEIGHT5S(18))];
    
    self.textLabel.text = @"发布房屋的整体详情";
    
    self.textLabel.textColor = COLOR(243, 197, 1, 1);
    
    self.textLabel.font = [UIFont systemFontOfSize:13];
    
    [self.pView addSubview:self.textLabel];
}

//Scroll
- (void)createTitleLable{
    
    self.rentHouseScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, HEIGHT5S(128), SCREEN_WIDTH, SCREEN_HEIGHT-HEIGHT5S(128))];
    
    self.rentHouseScroll.contentSize = CGSizeMake(SCREEN_WIDTH, HEIGHT5S(2200));
    
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchScrollView)];
    
    [recognizer setNumberOfTapsRequired:1];
    
    [recognizer setNumberOfTouchesRequired:1];
    
    self.rentHouseScroll.delegate = self;
    
    [self.rentHouseScroll addGestureRecognizer:recognizer];
    
    self.rentHouseScroll.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:self.rentHouseScroll];
    
    NSString *str1 = [NSString stringWithFormat:@"%f",HEIGHT5S(22)];
    NSString *str2 = [NSString stringWithFormat:@"%f",HEIGHT5S(280)];
    NSString *str3 = [NSString stringWithFormat:@"%f",HEIGHT5S(422)];
    NSString *str4 = [NSString stringWithFormat:@"%f",HEIGHT5S(552)];
    NSString *str5 = [NSString stringWithFormat:@"%f",HEIGHT5S(702)];
    NSString *str6 = [NSString stringWithFormat:@"%f",HEIGHT5S(832)];
    NSString *str7 = [NSString stringWithFormat:@"%f",HEIGHT5S(1012)];
    NSString *str8 = [NSString stringWithFormat:@"%f",HEIGHT5S(1294)];
    NSString *str9 = [NSString stringWithFormat:@"%f",HEIGHT5S(1562)];
    NSString *str10 = [NSString stringWithFormat:@"%f",HEIGHT5S(1684)];
    NSString *str11 = [NSString stringWithFormat:@"%f",HEIGHT5S(1822)];
    NSString *str12 = [NSString stringWithFormat:@"%f",HEIGHT5S(1942)];

    
    NSArray *arr = @[str1,str2,str3,str4,str5,str6,str7,str8,str9,str10,str11,str12];
    
    NSArray *titleArr = [NSArray arrayWithObjects:@"房源地区",@"详细地址",@"户型",@"面积（m²）",@"楼层",@"房源描述",@"房源设施",@"联系方式（电话微信最少一种）",@"房屋类型",@"出租方式",@"每月租金",@"房屋照片", nil];

    for (int l = 0; l < 12; l++) {
        
        NSString *str = [NSString stringWithFormat:@"%@",arr[l]];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, HEIGHT5S(str.intValue), WIDTH5S(200), HEIGHT5S(20))];
        
        label.font = [UIFont systemFontOfSize:14];
        
        label.textColor = COLOR(150, 154, 167, 1);
        
        label.text = titleArr[l];
        
        [self.rentHouseScroll addSubview:label];
    }
    
    //房屋姓名
    self.houseNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, HEIGHT5S(180), WIDTH5S(200), HEIGHT5S(20))];
    
    self.houseNameLabel.text = @"房屋名称";
    
    self.houseNameLabel.textColor = COLOR(150, 154, 167, 1);
    
    self.houseNameLabel.font = FONT(14);
    
    [self.rentHouseScroll addSubview:self.houseNameLabel];
    
    self.houseNameText = [[UITextField alloc]initWithFrame:CGRectMake(WIDTH5S(15), HEIGHT5S(215), WIDTH5S(290), HEIGHT5S(40))];
    
    self.houseNameText.backgroundColor = [UIColor whiteColor];
    
    self.houseNameText.layer.cornerRadius = 5;
    
    self.houseNameText.font = FONT(12);
    
    self.houseNameText.delegate = self;
    
    self.houseNameText.placeholder = @"请输入你的房屋名称";
    
    if (_recordDic) {
        
        self.houseNameText.text = [_recordDic objectForKey:@"houserecord_name"];
    }
    
    [self.rentHouseScroll addSubview:self.houseNameText];
    
    
    //textfiled左边lable
    UILabel * leftViewName = [[UILabel alloc] initWithFrame:CGRectMake(0,0,10,45)];
    leftViewName.backgroundColor = [UIColor clearColor];
    
    self.houseNameText.leftView = leftViewName;
    
    self.houseNameText.leftViewMode = UITextFieldViewModeAlways;
  
    
    
    self.detaliAdressText = [[UITextView alloc]initWithFrame:CGRectMake(WIDTH5S(15), HEIGHT5S(225+100), WIDTH5S(290), HEIGHT5S(62))];
    
//    self.detaliAdressText.placeholder = @"请输入详细地址";
    
    self.detaliAdressText.layer.borderWidth = 0;
    
    [self.detaliAdressText setBackgroundColor:[UIColor whiteColor]];
    
    self.detaliAdressText.layer.cornerRadius = 5;
    
    self.detaliAdressText.textColor = COLOR(150, 154, 167, 1);
    
    self.detaliAdressText.font = [UIFont systemFontOfSize:12];
    
    self.detaliAdressText.delegate = self;
    
    if (_recordDic) {
        
        self.detaliAdressText.text = [_recordDic objectForKey:@"houserecord_address"];
    }
    
    [self.rentHouseScroll addSubview:self.detaliAdressText];
    

    
    self.detaliHouseText = [[UITextView alloc]initWithFrame:CGRectMake(WIDTH5S(15), HEIGHT5S(785+100), WIDTH5S(290), HEIGHT5S(100))];
    
    self.detaliHouseText.layer.borderWidth = 0;
    
    [self.detaliHouseText setBackgroundColor:[UIColor whiteColor]];
    
    self.detaliHouseText.layer.cornerRadius = 5;
    
    self.detaliHouseText.textColor = COLOR(150, 154, 167, 1);
    
    self.detaliHouseText.font = [UIFont systemFontOfSize:12];
    
    self.detaliHouseText.delegate = self;
    
//    self.detaliHouseText.alpha = 0;
    
    if (_recordDic) {
        
        self.detaliHouseText.text = [_recordDic objectForKey:@"houserecord_description"];
    }
    
    [self.rentHouseScroll addSubview:self.detaliHouseText];

    
    
    
    self.slider = [[UISlider alloc]initWithFrame:CGRectMake(WIDTH5S(30), HEIGHT5S(531+100), WIDTH5S(250), HEIGHT5S(32))];
    
    //最大最小值
    self.slider.minimumValue = 0;
    self.slider.maximumValue = 200;
    
//    设置已经滑过一端滑动条颜色
    self.slider.minimumTrackTintColor = COLOR(243, 197, 1, 1);
//    设置未滑过一端滑动条颜色
    self.slider.maximumTrackTintColor = COLOR(100, 100, 1, 1);
    
    [self.slider addTarget:self action:@selector(test) forControlEvents:UIControlEventValueChanged];
    
    self.slider.continuous = YES;
    
    if (_recordDic) {
        
        self.slider.value = [[_recordDic objectForKey:@"houserecord_rent"] intValue];
    }

    [self.rentHouseScroll addSubview:self.slider];
    
    self.sliderLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, HEIGHT5S(492+100), WIDTH5S(35), HEIGHT5S(18))];
   
    self.sliderLabel.textAlignment = NSTextAlignmentCenter;
    self.sliderLabel.textColor = COLOR(243, 197, 1, 1);
    
    if (_recordDic) {
        
        self.sliderLabel.text = [_recordDic objectForKey:@"houserecord_rent"];
        
    }else{
    
         self.sliderLabel.text = @"0";
    }
    
    [self.rentHouseScroll addSubview:self.sliderLabel];

    
}

//创建UIPickerView
- (void)createPickerV{
    
    self.mutArr = [NSMutableArray arrayWithCapacity:0];

        self.animationPicker1 = [[UIPickerView alloc]initWithFrame:CGRectMake(WIDTH5S(130), HEIGHT5S(450), WIDTH5S(60), HEIGHT5S(80))];
        
        self.animationPicker1.delegate = self;
        self.animationPicker1.dataSource = self;
        
        [self.rentHouseScroll addSubview:self.animationPicker1];
        
        [self.mutArr addObject:self.animationPicker1];
        
        UILabel *houseLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH5S(180), HEIGHT5S(450), WIDTH5S(60), HEIGHT5S(80))];
        
        houseLabel.text = @"室";
        
        houseLabel.font = [UIFont systemFontOfSize:13];
        
        [self.rentHouseScroll addSubview:houseLabel];
    
    
    self.animationPicker3 = [[UIPickerView alloc]initWithFrame:CGRectMake(WIDTH5S(148+25), HEIGHT5S(641-10-5+100), WIDTH5S(60), HEIGHT5S(100))];
    
   

    [self.rentHouseScroll addSubview:self.animationPicker3];

    
    _animationTypes = @[
                        @"0",
                        @"1",
                        @"2",
                        @"3",
                        @"4",
                        @"5",
                        @"6",
                        @"7",
                        @"8",
                        @"9"
                        ];
    
    _animationTypes1 = @[
                         @"0",
                        @"1",
                        @"2",
                        @"3",
                        @"4",
                        @"5",
                        @"6",
                        @"7",
                        @"8",
                        @"9"
                        ];

    
    self.animationPicker3.delegate = self;
    self.animationPicker3.dataSource = self;

    
}

//显示多少个列表
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
        if (pickerView == _animationPicker1) {
    
           return  _animationTypes.count;
    
        }else if (pickerView == _animationPicker3){
    
           return  _animationTypes.count;
            
        }else if (pickerView == _animationPicker4){
        
            return _animationTypes1.count;
            
        }else if (pickerView == _housePicker){
        
            return _houseStyleArr.count;
            
        }else{
        
            return _animationTypes2.count;
        }
}

//间距
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    if (pickerView == _animationPicker2) {
        
        return  30;
        
    }else if (pickerView == _animationPicker3){
        
        return 30;
        
    }else if (pickerView == _animationPicker4){
        
        return 30;
        
    }else if (pickerView == _housePicker){
    
        return 30;
        
    }else{
        
        return 20;
    }
}

//宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    
    if (pickerView == _animationPicker2) {

        return  60;
      
    }else if (pickerView == _animationPicker3){
    
        return 60;
        
    }else if (pickerView == _animationPicker4){
    
        return 60;
        
    }else if (pickerView == _housePicker){
        
        return 60;
        
    }else{
    
        return 30;
    }

}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    
    UILabel *label = [[UILabel alloc]init];

    label.textAlignment = NSTextAlignmentCenter;
    
    label.font = [UIFont systemFontOfSize:18];
    
    [label setBackgroundColor:[UIColor clearColor]];
    
    label.textColor = COLOR(243, 197, 1, 1);
    
    if (pickerView == _animationPicker1) {
        
        label.text = _animationTypes[row];
        
    }else if (pickerView == _animationPicker4){
    
        label.text = _animationTypes1[row];
        
    }else if (pickerView == _animationPicker2){
    
        label.text = _animationTypes2[row];
        
    }else if (pickerView == _housePicker){
        
        label.text = _houseStyleArr[row];
        
    }else{
    
        label.text = _animationTypes1[row];
    }
    
    //删除pickerview上下的黑色线
    [[pickerView.subviews objectAtIndex:1] setHidden:TRUE];
    [[pickerView.subviews objectAtIndex:2] setHidden:TRUE];

    return label;
}

//选取到某一行的值
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
        NSInteger shiRow = [self.mutArr[0] selectedRowInComponent:0];
        
        self.roomValue = [_animationTypes1 objectAtIndex:shiRow];

    
    //区域
    NSInteger regionRow = [self.animationPicker2 selectedRowInComponent:0];
    
    self.regionValue = [_animationTypes2 objectAtIndex:regionRow];
    
    //房屋类型
    NSInteger houseStyleRow = [self.housePicker selectedRowInComponent:0];
    
    self.houseStyleValue = [_houseStyleArr objectAtIndex:houseStyleRow];
    
    //楼层x/y
    NSInteger floor = [self.animationPicker3 selectedRowInComponent:0];
    
    self.floorValue = [_animationTypes1 objectAtIndex:floor];
    
    NSInteger totalFloor = [self.animationPicker4 selectedRowInComponent:0];
    
    self.totalFloorValue = [_animationTypes1 objectAtIndex:totalFloor];
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    if (textView == _detaliAdressText) {
        
        [self.rentHouseScroll setContentOffset:CGPointMake(0, HEIGHT5S(180+100)) animated:YES];
        
    }else if (textView == _detaliHouseText){
    
        [self.rentHouseScroll setContentOffset:CGPointMake(0, HEIGHT5S(730+100)) animated:YES];
        
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{

    if (textField == _houseNameText) {
        
        [self.rentHouseScroll setContentOffset:CGPointMake(0, HEIGHT5S(180)) animated:YES];
        
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.view endEditing:YES];
  
}



//UISlider
- (void)test{
    
    long int l = [self.slider value];

    self.sliderLabel.text = [NSString stringWithFormat:@"%ld",l];

    self.sliderLabel.frame = CGRectMake(l+WIDTH5S(30), HEIGHT5S(492+100), WIDTH5S(35), HEIGHT5S(18));

}

//房屋设施
- (void)viewView{
    
    //类名加方法返回一个自定义的view
    UIView *view=[BtnView creatBtn];
    //遍历这个view，对这个view上btn添加相应的事件
    for (UIButton *btn in view.subviews) {
        [btn addTarget:self action:@selector(handleButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.rentHouseScroll addSubview:view];
    
}

/**
 *  btn的相应事件，改变颜色并且添加一个imageView
 *
 */
- (void)handleButton:(UIButton *)button{
    
    NSString *A = @"A";
    
    button.selected = !button.selected;
    if (button.selected) {

        self.u = [NSString stringWithFormat:@"%ld",button.tag-4000];
        button.backgroundColor = COLOR(243, 197, 1, 1);
        
        if (_u.intValue > 9) {
            
            self.u = [NSString stringWithFormat:@"%@",A];
        }
        
        NSString *btnStr = [NSString stringWithFormat:@"%@",_u];
        
        [self.btnMutArr addObject:btnStr];
        
    }else{
 
        self.u = [NSString stringWithFormat:@"%ld",button.tag-4000];
        button.backgroundColor = COLOR(243, 197, 1, 1);
        
        if (_u.intValue > 9) {
            
            self.u = [NSString stringWithFormat:@"%@",A];
        }
        
        NSString *btn1Str = [NSString stringWithFormat:@"%@",_u];
        
        [self.btnMutArr removeObject:btn1Str];

        
        button.backgroundColor = [UIColor whiteColor];

    }
}

//联系方式
- (void)viewTextFiledView{
  
    self.contactview=[TextFiled createTextFiled];

    [self.rentHouseScroll addSubview:self.contactview];
    
    if (_recordDic) {
        
        UITextField *te1 = self.contactview.subviews[8];
        
        te1.text = [_recordDic objectForKey:@"contacts_name"];
        
        UITextField *te2 = self.contactview.subviews[2];
        
        te2.text = [_recordDic objectForKey:@"contacts_phone"];
    }
    
}

//房屋类型
- (void)createHouseStylePicker{
    
    self.houseStyleArr = @[@"公寓",@"宿舍",@"单身汪"];

    self.housePicker = [[UIPickerView alloc]initWithFrame:CGRectMake(WIDTH5S(130), HEIGHT5S(1470+100), WIDTH5S(60), HEIGHT5S(120))];
    
    self.housePicker.delegate = self;
    self.housePicker.dataSource = self;

    [self.rentHouseScroll addSubview:self.housePicker];
}


//出租方式
- (void)createRentWay{

    UIView *rentWayView = [[UIView alloc]initWithFrame:CGRectMake(WIDTH5S(15), HEIGHT5S(1640+100), WIDTH5S(276), HEIGHT5S(40))];
    
    rentWayView.backgroundColor = [UIColor clearColor];
    
    [self.rentHouseScroll addSubview:rentWayView];
    
    self.rentWayBtnLeft = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, WIDTH5S(130), HEIGHT5S(40))];
    
    self.rentWayBtnLeft.backgroundColor = [UIColor whiteColor];
    
    self.rentWayBtnLeft.layer.cornerRadius = 5;
    
    self.rentWayBtnLeft.titleLabel.font = [UIFont systemFontOfSize:13];
    
    [self.rentWayBtnLeft setTitle:@"整租" forState:UIControlStateNormal];
    
    [self.rentWayBtnLeft setTitleColor:COLOR(153, 153, 153, 1) forState:UIControlStateNormal];
    
    self.rentWayBtnLeft.tag = 5500;
    
    [self.rentWayBtnLeft addTarget:self action:@selector(rentWayBtnLeftClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [rentWayView addSubview:self.rentWayBtnLeft];
    
    self.rentWayBtnRight = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(160), 0, WIDTH5S(130), HEIGHT5S(40))];
    
    self.rentWayBtnRight.backgroundColor = [UIColor whiteColor];
    
    self.rentWayBtnRight.layer.cornerRadius = 5;
    
    self.rentWayBtnRight.titleLabel.font = [UIFont systemFontOfSize:13];
    
    [self.rentWayBtnRight setTitle:@"分租" forState:UIControlStateNormal];
    
    [self.rentWayBtnRight setTitleColor:COLOR(153, 153, 153, 1) forState:UIControlStateNormal];
    
    self.rentWayBtnRight.tag = 5501;
    
    [self.rentWayBtnRight addTarget:self action:@selector(rentWayBtnRightClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [rentWayView addSubview:self.rentWayBtnRight];
    
    
    //弹出界面
    self.rentWayBtnRightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    self.rentWayBtnRightView.backgroundColor = [UIColor blackColor];
    
    self.rentWayBtnRightView.alpha = 0.8;
    
    self.rentWayBtnRightView.hidden = YES;
    
    [self.view addSubview:self.rentWayBtnRightView];
    
    self.rentWayBtnRightViewLeftStr = @"主卧室";
    self.rentWayBtnRightViewCenterStr = @"次卧室";
    self.rentWayBtnRightViewRightStr = @"暖心小窝";
    self.rentWayBtnRightViewdownStr = @"带独立卫生间";
    
    //左btn
    self.rentWayBtnRightViewLeft = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(30), HEIGHT5S(240), WIDTH5S(70), HEIGHT5S(40))];
    
    [self.rentWayBtnRightViewLeft setTitle:self.rentWayBtnRightViewLeftStr forState:UIControlStateNormal];
    
    self.rentWayBtnRightViewLeft.layer.cornerRadius = 5;
    
    self.rentWayBtnRightViewLeft.titleLabel.font = [UIFont systemFontOfSize:13];
    
    [self.rentWayBtnRightViewLeft setTitleColor:COLOR(243, 197, 1, 1) forState:UIControlStateNormal];
    
    self.rentWayBtnRightViewLeft.backgroundColor = [UIColor whiteColor];
    
    [self.rentWayBtnRightViewLeft addTarget:self action:@selector(rentWayBtnRightViewLeftClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.rentWayBtnRightView addSubview:self.rentWayBtnRightViewLeft];
    
    //中btn
    self.rentWayBtnRightViewCenter = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(130), HEIGHT5S(240), WIDTH5S(70), HEIGHT5S(40))];
    
    [self.rentWayBtnRightViewCenter setTitle:self.rentWayBtnRightViewCenterStr forState:UIControlStateNormal];
    
    self.rentWayBtnRightViewCenter.layer.cornerRadius = 5;
    
    self.rentWayBtnRightViewCenter.titleLabel.font = [UIFont systemFontOfSize:13];
    
    [self.rentWayBtnRightViewCenter setTitleColor:COLOR(243, 197, 1, 1) forState:UIControlStateNormal];
    
    self.rentWayBtnRightViewCenter.backgroundColor = [UIColor whiteColor];
    
    [self.rentWayBtnRightViewCenter addTarget:self action:@selector(rentWayBtnRightViewCenterClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.rentWayBtnRightView addSubview:self.rentWayBtnRightViewCenter];
    
    //右btn
    self.rentWayBtnRightViewRight = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(230), HEIGHT5S(240), WIDTH5S(70), HEIGHT5S(40))];
    
    [self.rentWayBtnRightViewRight setTitle:self.rentWayBtnRightViewRightStr forState:UIControlStateNormal];
    
    self.rentWayBtnRightViewRight.layer.cornerRadius = 5;
    
    self.rentWayBtnRightViewRight.titleLabel.font = [UIFont systemFontOfSize:13];
    
    [self.rentWayBtnRightViewRight setTitleColor:COLOR(243, 197, 1, 1) forState:UIControlStateNormal];
    
    self.rentWayBtnRightViewRight.backgroundColor = [UIColor whiteColor];
    
    [self.rentWayBtnRightViewRight addTarget:self action:@selector(rentWayBtnRightViewRightClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.rentWayBtnRightView addSubview:self.rentWayBtnRightViewRight];
    
    //下Btn
    self.rentWayBtnRightViewDown = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(30), HEIGHT5S(300), WIDTH5S(70), HEIGHT5S(40))];
    
    [self.rentWayBtnRightViewDown setTitle:self.rentWayBtnRightViewdownStr forState:UIControlStateNormal];
    
    self.rentWayBtnRightViewDown.layer.cornerRadius = 5;
    
    self.rentWayBtnRightViewDown.titleLabel.font = [UIFont systemFontOfSize:10];
    
    [self.rentWayBtnRightViewDown setTitleColor:COLOR(243, 197, 1, 1) forState:UIControlStateNormal];
    
    self.rentWayBtnRightViewDown.backgroundColor = [UIColor whiteColor];
    
    [self.rentWayBtnRightViewDown addTarget:self action:@selector(rentWayBtnRightViewDownClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.rentWayBtnRightView addSubview:self.rentWayBtnRightViewDown];

    
}

- (void)rentWayBtnLeftClick:(UIButton *)sender{

    sender.backgroundColor = COLOR(243, 197, 1, 1);
    
    self.rentWayBtnRight.backgroundColor = [UIColor whiteColor];
    
    [self.rentWayBtnRight setTitle:@"分租" forState:UIControlStateNormal];
    
    self.rentStyleStr = [NSString stringWithFormat:@"%ld",sender.tag-5500];
}
- (void)rentWayBtnRightClick:(UIButton *)sender{
    
    self.rentStyleStr = [NSString stringWithFormat:@"%ld",sender.tag-5500];
    
    sender.backgroundColor = COLOR(243, 197, 1, 1);
    
    self.rentWayBtnLeft.backgroundColor = [UIColor whiteColor];
    
    [UIView animateWithDuration:2 animations:^{
       
        self.rentWayBtnRightView.hidden = NO;
    }];
}

//分租：主卧室、次卧室、暖心小窝
- (void)rentWayBtnRightViewLeftClick:(UIButton *)sender{

    self.rentWayBtnRightView.hidden = YES;
    
    [self.rentWayBtnRight setTitle:self.rentWayBtnRightViewLeftStr forState:UIControlStateNormal];
}
- (void)rentWayBtnRightViewCenterClick:(UIButton *)sender{
    
    self.rentWayBtnRightView.hidden = YES;
    
    [self.rentWayBtnRight setTitle:self.rentWayBtnRightViewCenterStr forState:UIControlStateNormal];
}
- (void)rentWayBtnRightViewRightClick:(UIButton *)sender{
    
    self.rentWayBtnRightView.hidden = YES;
    
    [self.rentWayBtnRight setTitle:self.rentWayBtnRightViewRightStr forState:UIControlStateNormal];
}
- (void)rentWayBtnRightViewDownClick:(UIButton *)sender{
    
    self.rentWayBtnRightView.hidden = YES;
    
    [self.rentWayBtnRight setTitle:self.rentWayBtnRightViewdownStr forState:UIControlStateNormal];
}
//房屋租金
- (void)createRentMoney{

    UIView *rentMoneyView = [[UIView alloc]initWithFrame:CGRectMake(WIDTH5S(15), HEIGHT5S(1770+100), WIDTH5S(290), HEIGHT5S(40))];
    
    rentMoneyView.backgroundColor = [UIColor whiteColor];
    
    [self.rentHouseScroll addSubview:rentMoneyView];
    
    UILabel *lineRentMoneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH5S(47), HEIGHT5S(10), 1, HEIGHT5S(20))];
    
    lineRentMoneyLabel.backgroundColor = COLOR(223, 223, 223, 1);
    
    [rentMoneyView addSubview:lineRentMoneyLabel];
    
    UILabel *MoneyRentMoneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH5S(10), HEIGHT5S(10), WIDTH5S(20), HEIGHT5S(20))];
    
    MoneyRentMoneyLabel.backgroundColor = [UIColor clearColor];
    
    MoneyRentMoneyLabel.text = @"￥";
    
    MoneyRentMoneyLabel.textColor = COLOR(243, 197, 1, 1);
    
    MoneyRentMoneyLabel.font = [UIFont systemFontOfSize:18];
    
    [rentMoneyView addSubview:MoneyRentMoneyLabel];
    
    self.rentMoneyTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(WIDTH5S(48), 0, WIDTH5S(226), HEIGHT5S(40))];
    
    self.rentMoneyTextFiled.layer.borderWidth = 0;
    
    self.rentMoneyTextFiled.placeholder = @"    输入你的月租金";
    
    if (_recordDic) {
        
        self.rentMoneyTextFiled.text = [_recordDic objectForKey:@"houserecord_rent"];
    }
    
    self.rentMoneyTextFiled.font = [UIFont systemFontOfSize:13];
    
    [rentMoneyView addSubview:self.rentMoneyTextFiled];
}

//房屋照片
- (void)createHousePic{

    self.housePicView = [[UIScrollView alloc]initWithFrame:CGRectMake(WIDTH5S(10), HEIGHT5S(1890+100), WIDTH5S(300), HEIGHT5S(80))];
    
    self.housePicView.backgroundColor = [UIColor whiteColor];
    
    self.housePicView.contentSize = CGSizeMake(WIDTH5S(900), HEIGHT5S(80));
    
    self.housePicView.scrollEnabled = NO;

    [self.rentHouseScroll addSubview:self.housePicView];
    
    
    self.housePicBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(15), HEIGHT5S(12.5), WIDTH5S(55), HEIGHT5S(55))];
    
    self.housePicBtn.backgroundColor = COLOR(223, 223, 223, 1);
    
    [self.housePicBtn setTitle:@"＋" forState:UIControlStateNormal];
    
    self.housePicBtn.titleLabel.font = [UIFont systemFontOfSize:30];
    
    [self.housePicBtn setTitleColor:COLOR(243, 197, 1, 1) forState:UIControlStateNormal];
    
    [self.housePicBtn addTarget:self action:@selector(housePicBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.housePicView addSubview:self.housePicBtn];
}
//添加房屋照片点击事件
- (void)housePicBtnClick{

    [self buttonClick];
}

//确认信息按钮
- (void)createConfirmBtn{

    UIButton *confirmBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(22), HEIGHT5S(2015+100), WIDTH5S(276), HEIGHT5S(40))];
    
    confirmBtn.backgroundColor = COLOR(243, 197, 1, 1);
    
    [confirmBtn setTitle:@"确认信息" forState:UIControlStateNormal];
    
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    confirmBtn.layer.cornerRadius = 5;
    
    [self.rentHouseScroll addSubview:confirmBtn];
}

//拍照、从相册选取选择框
- (void)createPhotos{

    //弹出框
    
    self.myview = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    self.myview.backgroundColor = [UIColor blackColor];
    
    self.myview.alpha = 0;
    
    [self.view addSubview:self.myview];
    
    self.bkView = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT5S(568), WIDTH5S(320), HEIGHT5S(205))];
    
    self.bkView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.bkView];
    
    
    
    UIButton *button1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, WIDTH5S(320), HEIGHT5S(367))];
    
    button1.backgroundColor = [UIColor clearColor];

    [button1 addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.myview addSubview:button1];

    
    UIButton *pBoxBtn2 = [[UIButton alloc]initWithFrame:CGRectMake(0, HEIGHT5S(47), WIDTH5S(320), HEIGHT5S(47))];
    [pBoxBtn2 setTitle:@"拍照" forState:UIControlStateNormal];
    [pBoxBtn2 setTitleColor:COLOR(243, 197, 1, 1) forState:UIControlStateNormal];
    pBoxBtn2.backgroundColor = [UIColor whiteColor];
    [pBoxBtn2 addTarget:self action:@selector(ChooseCameraFromIPhone) forControlEvents:UIControlEventTouchUpInside];
    pBoxBtn2.layer.cornerRadius = 5;
    
    UIButton *pBoxBtn3 = [[UIButton alloc]initWithFrame:CGRectMake(0, HEIGHT5S(47*2), WIDTH5S(320), HEIGHT5S(47))];
    [pBoxBtn3 setTitle:@"从手机相册选择" forState:UIControlStateNormal];
    [pBoxBtn3 setTitleColor:COLOR(243, 197, 1, 1) forState:UIControlStateNormal];
    [pBoxBtn3 addTarget:self action:@selector(ChoosePicFromIPhone) forControlEvents:UIControlEventTouchUpInside];
    pBoxBtn3.backgroundColor = [UIColor whiteColor];
    pBoxBtn3.layer.cornerRadius = 5;
    
    UIButton *pBoxBtn4 = [[UIButton alloc]initWithFrame:CGRectMake(0, HEIGHT5S(47*3+6), WIDTH5S(320), HEIGHT5S(47))];
    [pBoxBtn4 setTitle:@"取消" forState:UIControlStateNormal];
    [pBoxBtn4 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    pBoxBtn4.backgroundColor = [UIColor whiteColor];
    pBoxBtn4.layer.cornerRadius = 5;
    [pBoxBtn4 addTarget:self action:@selector(pBox4) forControlEvents:UIControlEventTouchUpInside];
    
//    [self.bkView addSubview:pBoxBtn1];
    [self.bkView addSubview:pBoxBtn2];
    [self.bkView addSubview:pBoxBtn3];
    [self.bkView addSubview:pBoxBtn4];
}


//相机
- (void)ChooseCameraFromIPhone{
    
    self.ima = [[UIImageView alloc]initWithFrame:CGRectMake( _i * WIDTH5S(55), 12.5, 55, 55)];
    [self.housePicView addSubview:_ima];
    
    self.i++;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
  
        UIImagePickerController *ipc = [[UIImagePickerController alloc]init];
        ipc.delegate = self;
        ipc.allowsEditing = YES;
        
        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:ipc animated:YES completion:nil];

    }else{
        
        NSLog(@"233333");
    }
}


////从手机相册选择图片
- (void)ChoosePicFromIPhone{
    
    [self createCollect];

}

//保存图片至沙盒
- (void)saveImage:(UIImage *)currentimage withName:(NSString *)imageName{
    
    NSData *imaData = UIImageJPEGRepresentation(currentimage, 1);
   
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    [imaData writeToFile:fullPath atomically:YES];
}
//选择图片后自动调用该方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    [self buttonClick];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self saveImage:image withName:@"avatar.png"];
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"avatar.png"];
    
    UIImage *savedImage = [[UIImage alloc]initWithContentsOfFile:fullPath];
    [_ima setImage:savedImage];
    
    self.housePicBtn.frame = CGRectMake(_i*WIDTH5S(55), 12.5, 55, 55);
    
    if (self.i == 15) {
        
        self.housePicBtn.hidden = YES;
    }
}


//房屋照片取消按钮
- (void)pBox4{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect frame = self.bkView.frame;
        
        frame.origin.y += self.bkView.frame.size.height;
        
        self.bkView.frame = frame;
        
        self.myview.alpha = 0;
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.isxiaoshi = YES;
    });
    
}
//点击弹出从相册选取/拍照选择框
- (void)buttonClick{
    
    if (_isxiaoshi == YES) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            CGRect frame = self.bkView.frame;
            
            frame.origin.y -= self.bkView.frame.size.height;
            
            self.bkView.frame = frame;
            
            self.myview.alpha = 0.3;
        }];
        
        self.isxiaoshi = NO;
        
    }else if (_isxiaoshi == NO){
        
        [UIView animateWithDuration:0.3 animations:^{
            
            CGRect frame = self.bkView.frame;
            
            frame.origin.y += self.bkView.frame.size.height;
            
            self.bkView.frame = frame;
            
            self.myview.alpha = 0;
        }];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.isxiaoshi = YES;
        });
    }
}

- (void)createCollect{

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(100, 100);
    
    self.collect = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
    
    self.collect.delegate = self;
    self.collect.dataSource = self;
    
    self.collect.backgroundColor = [UIColor whiteColor];
    
    self.collect.allowsMultipleSelection = YES;
    
    self.collect.allowsSelection = YES;
    
    [self.collect registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
    
    [self.view addSubview:self.collect];
    
    
    //创建可变数组,存储资源文件
    self.array = [NSMutableArray arrayWithCapacity:0];
    self.sArr = [NSMutableArray arrayWithCapacity:0];
    self.houArr = [NSMutableArray arrayWithCapacity:0];
    //创建资源库,用于访问相册资源
    library = [[ALAssetsLibrary alloc] init];
    
    //遍历资源库中所有的相册,有多少个相册,usingBlock会调用多少次
    [library enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        
        //如果存在相册,再遍历
        if (group) {
            
            //遍历相册中所有的资源(照片,视频)
            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
   
                if (result) {
                    //将资源存储到数组中
                    [_array addObject:result];

                }
                
            }];
        }
        
        //刷新_collectionView reloadData;
        [_collect reloadData];
        
    } failureBlock:^(NSError *error) {
        
        NSLog(@"访问失败");
    }];


    self.collectBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(15), HEIGHT5S(520), WIDTH5S(290), HEIGHT5S(30))];
    
    [self.collectBtn setTitle:@"确认" forState:UIControlStateNormal];
    
    self.collectBtn.backgroundColor = COLOR(243, 197, 1, 1);
    
    [self.collectBtn addTarget:self action:@selector(collectBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.collectBtn.layer.cornerRadius = 5;
    
    [self.view addSubview:self.collectBtn];
    
    self.collectMutArr = [NSMutableArray arrayWithCapacity:0];
    self.pMutArr = [NSMutableArray arrayWithCapacity:0];
}

- (void)collectBtnClick{
    
    [self.collect removeFromSuperview];
    
    [self buttonClick];
    
    [self.collectBtn removeFromSuperview];
    
    
     self.s = _pMutArr.count + _s;
        self.housePicBtn.frame = CGRectMake(_s*WIDTH5S(55), 12.5, 55, 55);
        
        if (_s == 16) {
            
            self.housePicBtn.hidden = YES;
        }
    
    if (_s <= 5) {
        
        self.housePicView.scrollEnabled = NO;
        
    }else{
    
        self.housePicView.scrollEnabled = YES;
        self.housePicView.contentSize = CGSizeMake(WIDTH5S(_s*WIDTH5S(55)+WIDTH5S(55)), HEIGHT5S(80));
        }
    
//    NSLog(@"%ld",_s);
    
    self.colMutArr = [NSMutableArray arrayWithCapacity:0];
   
        for (int c = 0; c < _pMutArr.count; c++) {
            
            self.ima = [[UIImageView alloc]initWithFrame:CGRectMake(_i*WIDTH5S(55), HEIGHT5S(12.5), WIDTH5S(55), HEIGHT5S(55))];
            
            ALAsset *result =_array[[_pMutArr[c] intValue]];
            
//            获取原图
            CGImageRef cimg = [result aspectRatioThumbnail];
            
            //转换为UIImage
            UIImage *img = [UIImage imageWithCGImage:cimg];
            
            self.ima.image = img;

            
            //删除
            self.btnVV = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, WIDTH5S(30), WIDTH5S(30))];
            
            self.btnVV.backgroundColor = [UIColor purpleColor];
            
            self.btnVV.hidden = YES;
            
            [self.btnVV addTarget:self action:@selector(btnVVClick) forControlEvents:UIControlEventTouchUpInside];
            
            [self.ima addSubview:self.btnVV];
            
            UITapGestureRecognizer *imaTapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imaTapGR)];
            
            [_ima addGestureRecognizer:imaTapGR];
            
            
            self.ima.userInteractionEnabled = YES;
            
            [self.housePicView addSubview:_ima];

            
            self.i ++;
            
            [self.colMutArr addObject:_ima.image];
            
        }
}



//行的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    
    return _array.count;
    
}

//创建UICollectionViewCell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //如果单元格是在故事版中画出来的,不需要注册,需要在单元格中指定标识符
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    
    //取得图片视图
    UIImageView *imgView = [[UIImageView alloc]init];
    
    cell.backgroundView = imgView;
    
    //取出对应的资源数据
    ALAsset *result =_array[indexPath.row];
    
    //获取到缩略图
    CGImageRef cimg = [result thumbnail];
    
    //转换为UIImage
    UIImage *img = [UIImage imageWithCGImage:cimg];
    
    //显示图片
    imgView.image = img;

    
    self.imgView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    
    self.imgView1.image = [UIImage imageNamed:@"对号副本1.png"];

    [imgView addSubview:_imgView1];
    
    [self.collectMutArr addObject:imgView];

    return cell;
}

//单元格大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(100, 100);
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    UIImageView *uiui = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    
    uiui.image = [UIImage imageNamed:@"对号.png"];
    
    [cell.backgroundView addSubview:uiui];

    self.p = (int)indexPath.item;


    NSString *strP = [NSString stringWithFormat:@"%d",_p];
    [self.pMutArr addObject:strP];

    for (int i = 0; i < _pMutArr.count; i ++) {
        NSString *string = _pMutArr[i];
        NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:0];
//        [tempArray addObject:string];
        for (int j = i+1; j < _pMutArr.count; j ++) {
            NSString *jstring = _pMutArr[j];
 
            if ([string isEqualToString:jstring]) {
  
                [tempArray addObject:jstring];
                
            }
        }
        
        if ([tempArray count] >= 1) {
            [_pMutArr removeObjectsInArray:tempArray];
//            i -= 1;    //去除重复数据 新数组开始遍历位置不变
            
        }
    }
    
    return YES;
}


- (void)touchScrollView

{
    
    [self.detaliHouseText resignFirstResponder];
    [self.detaliAdressText resignFirstResponder];
    [self.rentMoneyTextFiled resignFirstResponder];
    [self.houseNameText resignFirstResponder];
    
    for (UITextField *contactText in self.contactview.subviews) {
        
        [contactText resignFirstResponder];
    }
}


//确认信息
- (void)confirmBtnClick{
    
    for (int j = 0; j < _btnMutArr.count; j ++) {
        
        NSString *StrFacility = [NSString stringWithFormat:@"%@",_btnMutArr[j]];
        
        self.jointStr = [NSString stringWithFormat:@"%@%@",self.jointStr,StrFacility];

    }
    
    if ([_rentStyleStr isEqualToString:@"0"]) {
        
        if (self.roomValue.intValue <= 4) {
            
            self.roomStr = _roomValue;
            
        }else{
        
            self.roomStr = @"4";
        }
    }else{
    
        if ([self.rentWayBtnRight.currentTitle isEqualToString:self.rentWayBtnRightViewLeftStr]) {

            self.roomStr = @"5";
            
        }else if ([self.rentWayBtnRight.currentTitle isEqualToString:self.rentWayBtnRightViewCenterStr]){
        
            self.roomStr = @"6";
            
        }else if ([self.rentWayBtnRight.currentTitle isEqualToString:self.rentWayBtnRightViewRightStr]){
        
            self.roomStr = @"7";
            
        }else{
        
            self.roomStr = @"8";
        }
    }
    
    NSString *sliderValue = [NSString stringWithFormat:@"%f",self.slider.value];
    
//    UITextField *contactweixin = self.contactview.subviews[5];
    UITextField *contactPerson = self.contactview.subviews[8];
    UITextField *contactPhone = self.contactview.subviews[2];
   
     NSDictionary *dicUserDefaults = [[NSUserDefaults standardUserDefaults] objectForKey:@"personInfo"];
    
    NSArray *arrUserDefaults = [dicUserDefaults objectForKey:@"result"];
    
    NSDictionary *dic1UserDefaults = arrUserDefaults[0];
    
    NSString *userid = [dic1UserDefaults objectForKey:@"user_id"];
    

    if (userid.length != 0&&self.houseNameText.text.length != 0&&self.detaliAdressText.text.length != 0&&sliderValue.length != 0&&self.floorValue.length != 0&&self.houseStyleValue.length != 0&&self.detaliHouseText.text.length != 0&&self.jointStr.length != 0&&self.rentStyleStr.length != 0&&self.rentMoneyTextFiled.text.length != 0&&self.regionValue.length != 0&&contactPerson.text.length != 0&&contactPhone.text.length != 0) {
        
        self.confirmDic = @{
                            @"userid":userid,
                            @"housename":self.houseNameText.text,
                            @"houseaddress":self.detaliAdressText.text,
                            @"housearea":sliderValue,
                            @"housefloor":self.floorValue,
                            @"houseapartment":self.houseStyleValue,
                            @"housedescription":self.detaliHouseText.text,
                            @"housefacility":_jointStr,
                            @"houserentstyle":self.rentStyleStr,
                            @"houserent":self.rentMoneyTextFiled.text,
                            @"cityname":self.cityNameStr,
                            @"housetypestyle":self.roomStr,
                            @"housedistrictname":self.regionValue,
                            @"contactname":contactPerson.text,
                            @"contactphone":contactPhone.text
                            };
        
        
        
       

    }else{
    
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"message" message:@"phoneNum or password is not correct" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"confirm" style:UIAlertActionStyleDefault handler:nil];
        
        [alert addAction:action];
        
        [self presentViewController:alert animated:YES completion:nil];

    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [RentHouseService rentHouse:_confirmDic andSuccess:^(NSDictionary *dic) {
            
            NSString *houID = [dic objectForKey:@"result"];
            
            int houseID = houID.intValue;
        
            [FavoritesService setImg:_colMutArr andHouseInfoId:houseID andSuccess:^(NSString *str1) {
                
            } andFail:nil];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"prompt" message:@"完成出租！！！" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    RentingPageViewController *rpvc = [[RentingPageViewController alloc]init];
                    
                    [self.navigationController pushViewController:rpvc animated:YES];
                }];
                
                [alert addAction:action];
                
                [self presentViewController:alert animated:YES completion:nil];

            });
            
        }];
        
    });


}


- (void)imaTapGR{

    self.btnVV.hidden = NO;
}

- (void)btnVVClick{

    [self.ima removeFromSuperview];
}

- (void)cityPage{
    
    ChangeCityViewControllers *ccvc = [[ChangeCityViewControllers alloc]init];
    
    ccvc.houseDelegate = self;
    
    [self.navigationController pushViewController:ccvc animated:YES];
    
    
}

- (void)houseCityName:(NSDictionary *)dic{

    
    self.cityNameStr = [dic objectForKey:@"city"];
    
    self.provinceStr = [dic objectForKey:@"province"];

    
    NSString *cityNameStr1 = [NSString stringWithFormat:@"%@▼",_cityNameStr];
    
    [self.rentingBtn setTitle:cityNameStr1 forState:UIControlStateNormal];
}

@end
