//
//  HouseInfoViewController.m
//  EasyRenting
//
//  Created by administrator on 16/3/29.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "HouseInfoViewController.h"
#import "Define.h"
#import "HomePageTableViewCell.h"
#import "MyHouseInfoScrollView.h"
#import "MapViewController.h"
#import "MyAnimatedAnnotationView.h"
#import "ChatForSomeOneService.h"
#import "GetCityHouseInfoService.h"
#import "CollectHouseInfoService.h"
#import "MBProgressHUD.h"
#import "FavoritesService.h"
#import "UIImageView+WebCache.h"
#import "GetCityAllHouseInfoService.h"
#import "MBProgressHUD.h"
#import "LoginPageViewController.h"

@interface HouseInfoViewController ()<UIPickerViewDelegate,BMKMapViewDelegate,BMKPoiSearchDelegate>

@property (strong, nonatomic)UIView *NavigationView;

@property (strong, nonatomic)UITableView *HouseInfoTableView;

@property (strong, nonatomic)UIView *headView;

@property (strong, nonatomic)UILabel *outlineLabel;

@property (strong, nonatomic)UIView *besoeakView;

@property (strong, nonatomic)UITextField *nameText;

@property (strong, nonatomic)UITextField *contactText;

@property (strong, nonatomic)UIDatePicker *datePickerView;

@property (strong, nonatomic)UILabel *timeLabel;

@property (strong, nonatomic)MyHouseInfoScrollView *scrollView;

@property (strong, nonatomic)BMKMapView *mapView;

@property (strong, nonatomic)BMKPoiSearch *poisearch;

@property (copy, nonatomic)NSString *phone;

@property (strong, nonatomic)UILabel *titleLabel;

@property (strong, nonatomic)UIView *rentingView;

@property (strong, nonatomic)NSMutableArray *cityArr;

@property (strong, nonatomic)NSMutableArray *likeHouseArr;

@property (strong, nonatomic)NSMutableArray *housePicNameArr;

@property (strong, nonatomic)NSMutableArray *imaUrlArr;

@property (strong, nonatomic) MBProgressHUD *hud;

@property (strong, nonatomic)NSString *userid;
@end

@implementation HouseInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSLog(@"%@",self.houseinfoDic);
    
    self.hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    self.imaUrlArr = [NSMutableArray arrayWithCapacity:0];
    
//    self.likeHouseArr = [NSMutableArray arrayWithCapacity:0];
    
    //自定义的顶部导航
    self.NavigationView  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    
    self.NavigationView.backgroundColor = NAVIGATIONCOLOR;
    
    [self.view addSubview:self.NavigationView];
    
     //导航栏上的返回键
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 60, 44)];
    
//    [backBtn setBackgroundImage:[UIImage imageNamed:@"back_select@2x"] forState:UIControlStateNormal];
    
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    [self.NavigationView addSubview:backBtn];
    
    UIImageView *backIma = [[UIImageView alloc]initWithFrame:CGRectMake(2, 10, 25, 25)];
    backIma.image = [UIImage imageNamed:@"back_select@2x"];
    [backBtn addSubview:backIma];
    
    UIButton *collectBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(270), 14, 50, 50)];
    
    
    
    [collectBtn addTarget:self action:@selector(collect) forControlEvents:UIControlEventTouchUpInside];
    
    [self.NavigationView addSubview:collectBtn];
    
    UIImageView *collectIma = [[UIImageView alloc]initWithFrame:CGRectMake(15,20, 20, 20)];
    
    collectIma.image = [UIImage imageNamed:@"shouchang"];
    
    [collectBtn addSubview:collectIma];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 20, 120, 44)];
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    
    self.titleLabel.text = self.houseinfoDic[@"houseinfo_name"];
    
    self.titleLabel.textColor = COLOR(255, 253, 193, 1);
    
    [self.NavigationView addSubview:self.titleLabel];

     //房屋信息的主tableview
    self.HouseInfoTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 113)];
    
    [self.view addSubview:self.HouseInfoTableView];
    
    self.HouseInfoTableView.delegate =self;
    
    self.HouseInfoTableView.dataSource = self;
     
     //取消tableview中原有的cell分割线
    self.HouseInfoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
     
     self.HouseInfoTableView.showsVerticalScrollIndicator = NO;
    //定义一个view
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT5S(1075))];
     
    self.HouseInfoTableView.tableHeaderView = self.headView;
    
     
    
     //房屋信息大纲
    self.outlineLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, HEIGHT5S(200), HEIGHT5S(290), 40)];
    
    int jiage = [self.houseinfoDic[@"houseinfo_rent"] intValue];
    
    self.outlineLabel.text = [NSString stringWithFormat:@"%@及附近房屋房出租，价格%d到%d不等，有钥匙",self.houseinfoDic[@"houseinfo_name"],jiage/2,jiage * 2] ;
     
     self.outlineLabel.font = [UIFont systemFontOfSize:15];
     
     self.outlineLabel.numberOfLines = 0;
    
    [self.headView addSubview:self.outlineLabel];
    
     //第一条分割横线
    UILabel *lineLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT5S(257), SCREEN_WIDTH, 1)];
    
    lineLabel1.backgroundColor = LINECOLOR;
    
    [self.headView addSubview:lineLabel1];
    
     //房间配置
    UILabel *houseFacilityLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, HEIGHT5S(264), WIDTH5S(65), WIDTH5S(18))];
    
    houseFacilityLabel.textColor = SMALLWORD;
    
    houseFacilityLabel.text = @"房间配置";
    
    houseFacilityLabel.font = [UIFont systemFontOfSize:13];
    
    [self.headView addSubview:houseFacilityLabel];
    
     //第二条分割横线
    UILabel *lineLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT5S(287), SCREEN_WIDTH, 1)];
    
    lineLabel2.backgroundColor = LINECOLOR;
    
    [self.headView addSubview:lineLabel2];
    
     
     //定义数组 有哪些电器
    
    NSMutableArray *mutArr1 = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *mutArr2 = [NSMutableArray arrayWithCapacity:0];
    NSArray *arr = @[@"电视机",@"电冰箱",@"洗衣机",@"宽带",@"桌子",@"空调",@"热水器",@"阳台",@"床",@"衣柜",@"卫生间"];
    
    
    NSArray *imaarr = @[@"tv",@"bingxiang",@"xiyiji",@"wifi",@"zhuozi",@"kongtiao",@"re",@"yangtai",@"chuang",@"yigui",@"matong"];
    
    NSString *facilityStr = self.houseinfoDic[@"houseinfo_facility"];
    
    for(int i =0; i < [facilityStr length]; i++)
    {
        NSString *temp = [facilityStr substringWithRange:NSMakeRange(i, 1)];
        if ([temp isEqualToString:@"N"]) {
            
        }else if ([temp isEqualToString:@"A"]) {
            [mutArr1 addObject:arr[10]];
            [mutArr2 addObject:imaarr[10]];
        }else{
            [mutArr1 addObject:arr[[temp intValue]]];
            [mutArr2 addObject:imaarr[[temp intValue]]];
        }
        
    }

     //画出电器的图像 和 名字
     for (int i = 0; i < mutArr1.count / 3 + 1; i++) {
         
          for (int j = 0; j < 3; j++) {
             
               if ((i * 3 + j) < mutArr1.count ) {
                  
                    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(15 + j * WIDTH5S(105), HEIGHT5S(300) + i * HEIGHT5S(50), WIDTH5S(80), HEIGHT5S(40))];
                  
//                    view1.backgroundColor = [UIColor orangeColor];
                  
                    [self.headView addSubview:view1];
                  
                    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, WIDTH5S(10), WIDTH5S(20), WIDTH5S(20))];
                    image.image = [UIImage imageNamed:mutArr2[3 * i + j]];
                  
                    [view1 addSubview:image];
                  
                    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH5S(25), WIDTH5S(10), WIDTH5S(65), WIDTH5S(20))];
                  
                    nameLabel.font = [UIFont systemFontOfSize:13];
                  
                    nameLabel.text = mutArr1[3 * i + j];
                  
                    [view1 addSubview:nameLabel];
                  
               }

          }
         
     }
    
     int nn = (int)mutArr1.count / 3 ;
     
     if ((mutArr1.count % 3) == 0) {
          
          nn--;
          
     }
     //第三条分割横线
     UILabel *lineLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT5S(357) + nn * 50, SCREEN_WIDTH, 1)];
    
     lineLabel3.backgroundColor = LINECOLOR;
    
     [self.headView addSubview:lineLabel3];
     
     //定义个view装下面的控件  这样上面改变label 的大小下面只要改变view大小和坐标就行了
     UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT5S(357) + nn * 50, SCREEN_WIDTH, HEIGHT5S(625))];
     
//     view1.backgroundColor = [UIColor blueColor];
     
     [self.headView addSubview:view1];
    
     self.headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT5S(980)+ nn * 50);
     
     //房屋的基本信息
     self.HouseInfoTableView.tableHeaderView = self.headView;
     
     UILabel *houseInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, HEIGHT5S(15), HEIGHT5S(175), HEIGHT5S(75))];
     
     NSString *price = self.houseinfoDic[@"houseinfo_rent"];
     
     NSString *str = self.houseinfoDic[@"housetype_name"];
     
     NSString *area = self.houseinfoDic[@"houseinfo_area"];
     
     NSString *loucen = self.houseinfoDic[@"houseinfo_floor"];
     
     houseInfoLabel.font = [UIFont systemFontOfSize:13];
     
     NSString *str1 = [NSString stringWithFormat:@"租金：%@/月\n房型：%@\n面积：%@m²\n楼层：%@层",price , str, area,loucen];
     
     NSRange range = [str1 rangeOfString:[NSString stringWithFormat:@"%@/月",price]];
     
     NSRange range1 = [str1 rangeOfString:[NSString stringWithFormat:@"%@m²",area]];
     
     NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc]initWithString:str1];
     
     [attribute addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:range];
     
     [attribute addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:range1];
     
     houseInfoLabel.text = str1;
     
     houseInfoLabel.attributedText = attribute;

     
     houseInfoLabel.numberOfLines = houseInfoLabel.text.length;
     
     [view1 addSubview:houseInfoLabel];
     
//     NSString *direction = @"南";
    
    NSString *houseApartment = self.houseinfoDic[@"house_apartment"];
    
     UILabel *houseInfoLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH5S(190), HEIGHT5S(38), HEIGHT5S(175), HEIGHT5S(75))];
     houseInfoLabel1.font = [UIFont systemFontOfSize:13];
     houseInfoLabel1.text = [NSString stringWithFormat:@"类型：%@", houseApartment];
     
     houseInfoLabel1.numberOfLines = houseInfoLabel1.text.length;
     
     [view1 addSubview:houseInfoLabel1];
     
     //房屋的详细说明
     UILabel *houseDescriptionLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, HEIGHT5S(110), WIDTH5S(290), HEIGHT5S(100))];
     
//     houseDescriptionLabel.backgroundColor = [UIColor orangeColor];
     
     houseDescriptionLabel.text = self.houseinfoDic[@"houseinfo_description"];
     
     houseDescriptionLabel.textColor = SMALLWORD;
     
     houseDescriptionLabel.font = FONT(13);
     
     houseDescriptionLabel.numberOfLines = 0;
     
     [view1 addSubview:houseDescriptionLabel];
     
     //view 同上个view 效果一样
     UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT5S(210), SCREEN_WIDTH, HEIGHT5S(415))];
     
     [view1 addSubview:view2];
     
     //联系人和联系方式
     UILabel *contactsLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, HEIGHT5S(10), SCREEN_WIDTH - 30, WIDTH5S(50))];
     
    NSString *name = self.houseinfoDic[@"contacts_name"];
     
     self.phone = self.houseinfoDic[@"contacts_phone"];
     
     contactsLabel.font = [UIFont systemFontOfSize:13];
     
     contactsLabel.textColor = SMALLWORD;
     
     NSString *contactStr = [NSString stringWithFormat:@"详情欢迎联系看房   %@ \n\n电话：%@ ",name, _phone];
     
     contactsLabel.numberOfLines = contactsLabel.text.length;
     
     NSRange phoneRange = [contactStr rangeOfString:[NSString stringWithFormat:@"%@",_phone]];
     
     NSMutableAttributedString *contactAttribute = [[NSMutableAttributedString alloc]initWithString:contactStr];
     
    [contactAttribute addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:phoneRange];
    
     contactsLabel.text = contactStr;
     
     contactsLabel.attributedText = contactAttribute;
     
     contactsLabel.numberOfLines = contactsLabel.text.length;
     
     [view2 addSubview:contactsLabel];
     
     UILabel *backgroundLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT5S(85), SCREEN_WIDTH, WIDTH5S(20))];
     
     backgroundLabel.backgroundColor = BACKGROUNDCOLOR;
     
     [view2 addSubview:backgroundLabel];
     
     UILabel *aroungLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, HEIGHT5S(110), WIDTH5S(150), WIDTH5S(20))];
     
     aroungLabel.font = [UIFont systemFontOfSize:13];
     
     aroungLabel.textColor = SMALLWORD;
     
     aroungLabel.text = @"位置及周边";
     
     [view2 addSubview:aroungLabel];
     
     UILabel *lineLabel4 = [[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT5S(135), SCREEN_WIDTH, 1)];
     
     lineLabel4.backgroundColor = LINECOLOR;
     
     [view2 addSubview:lineLabel4];

     UILabel *aroundLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, HEIGHT5S(335), SCREEN_WIDTH-30, HEIGHT5S(20))];
     
     aroundLabel.text = @"地铁、公交、周边医院";
     
     aroundLabel.font = [UIFont systemFontOfSize:13];
     
     [view2 addSubview:aroundLabel];
     
     //地图
     self.mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(15, HEIGHT5S(145+30), SCREEN_WIDTH - 30, HEIGHT5S(150))];
     
     [view2 addSubview:_mapView];
     
     self.poisearch = [[BMKPoiSearch alloc]init];
     
     [_mapView setZoomLevel:15];
     
     _mapView.isSelectedAnnotationViewFront = YES;
     

     UIImageView *mapIma = [[UIImageView alloc]initWithFrame:CGRectMake(15, HEIGHT5S(145+30), SCREEN_WIDTH - 30, HEIGHT5S(150))];
     
//     mapIma.image = [UIImage imageNamed:@"ditu"];
     
     mapIma.userInteractionEnabled = YES;
     
     [view2 addSubview:mapIma];
     
     UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTest)];
     
     [mapIma addGestureRecognizer:tap];

     
     UILabel *addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, HEIGHT5S(145), SCREEN_WIDTH, WIDTH5S(20))];
    
    NSString *adressStr = self.houseinfoDic[@"houseinfo_address"];
    
     addressLabel.text = [NSString stringWithFormat:@"地址：%@",adressStr];
     
     addressLabel.font = [UIFont systemFontOfSize:13];
     
     [view2 addSubview:addressLabel];
     
     UILabel *backgroundLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT5S(365), SCREEN_WIDTH, WIDTH5S(20))];
     
     backgroundLabel1.backgroundColor = BACKGROUNDCOLOR;
     
     [view2 addSubview:backgroundLabel1];
     
     UILabel *likeLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, HEIGHT5S(390), SCREEN_WIDTH - 15 , WIDTH5S(20))];
     
     likeLabel.text = @"猜你喜欢";
     
     likeLabel.font = [UIFont systemFontOfSize:13];
     
     likeLabel.textColor = SMALLWORD;
     
     [view2 addSubview:likeLabel];

     
     UILabel *lineLabel5 = [[UILabel alloc]initWithFrame:CGRectMake(0, WIDTH5S(414), SCREEN_WIDTH, 1)];
     
     lineLabel5.backgroundColor = LINECOLOR;
     
     [view2 addSubview:lineLabel5];
     
     
     UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 49, SCREEN_WIDTH, 49)];
     
     bottomView.backgroundColor = BACKGROUNDCOLOR;
     
     [self.view addSubview:bottomView];
    
    UILabel *botlinelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0.5, SCREEN_WIDTH, 0.5)];
    
    botlinelabel.backgroundColor = LINECOLOR;
    
    [bottomView addSubview:botlinelabel];
    
    UILabel *botlinelabelV = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 0, 0.5, 49)];
    
    botlinelabelV.backgroundColor = LINECOLOR;
    
    [bottomView addSubview:botlinelabelV];
    
     UIButton *phoneBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, WIDTH5S(160), 49)];
     
     [phoneBtn addTarget:self action:@selector(phoneCall) forControlEvents:UIControlEventTouchUpInside];
    
     [bottomView addSubview:phoneBtn];
     
     UIImageView *phongIma = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH5S(70), 7, WIDTH5S(20), 20)];
     
     phongIma.image = [UIImage imageNamed:@"电话"];
     
     [phoneBtn addSubview:phongIma];
     
     UILabel *phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH5S(68), 30, WIDTH5S(30),20)];
     
     phoneLabel.text = @"电话";
     
     phoneLabel.font = [UIFont systemFontOfSize:10];
     
     phoneLabel.textColor = NAVIGATIONCOLOR;
     
     [phoneBtn addSubview:phoneLabel];
     
     UIButton *MicroChatBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(160), 0, WIDTH5S(160), 49)];
    
     [MicroChatBtn addTarget:self action:@selector(MicroChat) forControlEvents:UIControlEventTouchUpInside];
    
     [bottomView addSubview:MicroChatBtn];
     
     UIImageView *MicroChartIma = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH5S(70), 7, WIDTH5S(20), 20)];
     
     MicroChartIma.image = [UIImage imageNamed:@"发消息"];
     
     [MicroChatBtn addSubview:MicroChartIma];
     
     UILabel *MicroChartLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH5S(70), 37, WIDTH5S(30), 20)];
     
     MicroChartLabel.text = @"微聊";
     
     MicroChartLabel.font = [UIFont systemFontOfSize:10];
     
     MicroChartLabel.textColor = NAVIGATIONCOLOR;
     
     [MicroChatBtn addSubview:MicroChartLabel];


    GetCityAllHouseInfoService *ghs = [[GetCityAllHouseInfoService alloc]init];
    
    self.cityArr = [NSMutableArray arrayWithCapacity:0];

    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
        [ghs CityName:self.houseinfoDic[@"city_name"] andSuccessWith:^(NSMutableArray *arr) {
            dispatch_async(dispatch_get_main_queue(), ^{
                            if (arr.count > 3) {
                                while (self.cityArr.count < 3) {
                                    int n = ARC(arr.count );
                                    if ([self.cityArr containsObject:arr[n]] == NO) {
                                        [self.cityArr addObject:arr[n]];
                                    }
                                }
                            }else{
                [self.cityArr setArray:arr];
                            }
                [self imaUrl];
                [self.HouseInfoTableView reloadData];
            });
        }];
    });
    FetchPicService *fps = [[FetchPicService alloc]init];
    [fps houseInfoId:[self.houseinfoDic[@"houseinfo_id"] intValue]  successWith:^(NSDictionary *dic) {
        self.housePicNameArr  = [NSMutableArray arrayWithCapacity:0];
        NSArray *arr = dic[@"result"];
        __block long n = arr.count;
        if (n == 0) {
            [self.hud hideAnimated:YES];
            UIImageView *imaView = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH5S(60), HEIGHT5S(50), WIDTH5S(200), HEIGHT5S(120))];
            imaView.image = [UIImage imageNamed:@"wutu.png"];
            [self.headView addSubview:imaView];
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT5S(40), SCREEN_WIDTH, HEIGHT5S(30))];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = FONT(15);
            label.text = @"没有相关图片！";
            [self.headView addSubview:label];
            
        }
        for (int i = 0; i < arr.count; i++) {
            NSString *picName = arr[i][@"houseimage_name"];
            NSString *newPicName = [NSString stringWithFormat:@"http://115.159.215.30/Tupian/image/%@",picName];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                UIImage *ima =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:newPicName]]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (ima != nil) {
                        [self.housePicNameArr addObject:ima];
                    }else{
                        n--;
                    }
                    if (self.housePicNameArr.count == n) {
                        [self scroolViewCreat];
                        
                        [self.hud hideAnimated:YES];
                    }
                });
            });
        }
    }];
    
    
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    
    NSDictionary *dic1 = [userDefaults objectForKey:@"personInfo"];
    self.userid = dic1[@"result"][0][@"user_id"];

     // Do any additional setup after loading the view.
}


- (void)scroolViewCreat{
    self.scrollView = [[MyHouseInfoScrollView alloc]init];
    
    self.scrollView.frame = CGRectMake(0, 0, WIDTH5S(320), HEIGHT5S(180));
    
    self.scrollView.imageArr = self.housePicNameArr;
    
    
    self.scrollView.MyPage.currentPageIndicatorTintColor = [UIColor orangeColor];
    
    self.scrollView.MyPage.pageIndicatorTintColor = [UIColor whiteColor];
    
    [self.headView addSubview: self.scrollView];
    

}

- (void)collect{
    
    CollectHouseInfoService *chis = [[CollectHouseInfoService alloc]init];
    
    
    [chis userId:self.userid andHouseInfoId:self.houseinfoDic[@"houseinfo_id"] andSuccessWith:^(NSDictionary *dic) {
      
//        NSLog(@"----------------%@",dic);
        if ([dic[@"code"] isEqual:@0]) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            
            // Set the annular determinate mode to show task progress.
            hud.mode = MBProgressHUDModeText;
            hud.label.text = NSLocalizedString(@"收藏成功!", @"HUD message title");
            hud.label.textColor = NAVIGATIONCOLOR;
            // Move to bottm center.
//            hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
            hud.offset = CGPointMake(0.f, 100.f);

            
            [hud hideAnimated:YES afterDelay:2.f];
        }else if([dic[@"code"] isEqual:@1]){
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            
            // Set the annular determinate mode to show task progress.
            hud.mode = MBProgressHUDModeText;
            hud.label.text = NSLocalizedString(@"收藏失败!", @"HUD message title");
            
            hud.label.textColor = NAVIGATIONCOLOR;
            // Move to bottm center.
            hud.offset = CGPointMake(0.f, 100.f);
            
            [hud hideAnimated:YES afterDelay:2.f];
        }else{
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            
            // Set the annular determinate mode to show task progress.
            hud.mode = MBProgressHUDModeText;
            hud.label.text = NSLocalizedString(@"你已经收藏过了!", @"HUD message title");
            
            hud.label.textColor = NAVIGATIONCOLOR;
            // Move to bottm center.
            hud.offset = CGPointMake(0.f, 100.f);
            
            [hud hideAnimated:YES afterDelay:2.f];
        }
        
    }];
    

}

- (void)phoneCall{
     
    NSString *str = _phone;
    
     UIWebView *callWebView = [[UIWebView alloc]init];
     
     [callWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
     
     [self.view addSubview:callWebView];
     
}

- (void)imaUrl{
    FetchPicService *fps = [[FetchPicService alloc]init];
    self.imaUrlArr = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < self.cityArr.count; i++) {
        [fps houseInfoId:[self.cityArr[i][@"houseinfo_id"] intValue]  successWith:^(NSDictionary *dic) {
            NSArray *arr = dic[@"result"];
            NSString *picName = arr[0][@"houseimage_name"];
            NSString *newPicName = [NSString stringWithFormat:@"http://115.159.215.30/Tupian/image/%@",picName];
            
            [self.imaUrlArr addObject:newPicName];
            
            [self.HouseInfoTableView reloadData];
        }];
        
    }
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.cityArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"cell";
    
    HomePageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        
        cell = [[HomePageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    if (self.imaUrlArr.count == self.cityArr.count) {
        [cell.houseImage sd_setImageWithURL:[NSURL URLWithString:self.imaUrlArr[indexPath.row]] placeholderImage:[UIImage imageNamed:@"house.jpg"]];
        
    }

    
    cell.houseNamelabel.text = self.cityArr[indexPath.row][@"houseinfo_name"];
    
    cell.houseAddresslabel.text = self.cityArr[indexPath.row][@"district_name"];
    
    cell.houseRentlabel.text = self.cityArr[indexPath.row][@"houseinfo_rent"];
    
    cell.houseApartmentlabel.text = self.cityArr[indexPath.row][@"housetype_name"];
    
    if ([(self.cityArr[indexPath.row][@"houseinfo_rentstyle"]) isEqual: @"0"] ) {
        cell.houseStylelabel.text = @"整租";
    }else{
        cell.houseStylelabel.text = @"分租";
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return WIDTH5S(120);
     
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
     
     HouseInfoViewController *hvc = [[HouseInfoViewController alloc]init];
    
    hvc.houseinfoDic = self.cityArr[indexPath.row];
    
     [self.navigationController pushViewController:hvc animated:YES];
}

- (void)MicroChat{
    
    ChatForSomeOneService *cs = [[ChatForSomeOneService alloc]init];
    
    if (_userid != nil) {
        [cs userId:self.houseinfoDic[@"t_user_user_id"] andsuccessWith:^(ChatPageViewController *rvc) {
            
            rvc.isOnePage = NO;
            
            [self.navigationController pushViewController:rvc animated:YES];
            
        }];

    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户没有登录，请去个人中心进行登录！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:action];
       
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    
    
}



- (void)test{
     BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc]init];
     citySearchOption.pageIndex = 0;
     citySearchOption.pageCapacity = 10;
     citySearchOption.city= self.houseinfoDic[@"city_name"];
     citySearchOption.keyword = self.houseinfoDic[@"houseinfo_name"];
     BOOL flag = [_poisearch poiSearchInCity:citySearchOption];
     if(flag)
     {
          NSLog(@"城市内检索发送成功");
     }
     else
     {
          
          NSLog(@"城市内检索发送失败");
     }
     
}



- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
     [_mapView viewWillAppear];
     
     _mapView.delegate = self;
     
     _poisearch.delegate = self;
     
     [self test];
     
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
     [_mapView viewWillDisappear];
     
     _mapView.delegate = nil;
     
     _poisearch.delegate = nil;
}

#pragma mark -
#pragma mark implement BMKSearchDelegate
- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult*)result errorCode:(BMKSearchErrorCode)error
{
     // 清楚屏幕中所有的annotation
     NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
     [_mapView removeAnnotations:array];
     
     if (error == BMK_SEARCH_NO_ERROR) {
          NSMutableArray *annotations = [NSMutableArray array];
//          for (int i = 0; i < result.poiInfoList.count; i++) {
               BMKPoiInfo* poi = [result.poiInfoList objectAtIndex:0];
               BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
               item.coordinate = poi.pt;
               item.title = poi.name;
               [annotations addObject:item];
//          }
          [_mapView addAnnotations:annotations];
          [_mapView showAnnotations:annotations animated:YES];
     } else if (error == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR){
          NSLog(@"起始点有歧义");
     } else {
          
     }
}

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation{
    NSString *AnnotationViewID = @"AnimatedAnnotation";
    MyAnimatedAnnotationView *annotationView = nil;
    if (annotationView == nil) {
        annotationView = [[MyAnimatedAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
    }
    NSMutableArray *images = [NSMutableArray array];
    for (int i = 1; i < 4; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"poi%d.png", i]];
        [images addObject:image];
    }
    annotationView.annotationImages = images;
    
    return annotationView;
}

- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    [mapView bringSubviewToFront:view];
    [mapView setNeedsDisplay];
}
- (void)mapView:(BMKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    NSLog(@"didAddAnnotationViews");
}


- (void)tapTest{
     
     MapViewController *mapView = [[MapViewController alloc]init];
     
    mapView.mapTitleName = self.houseinfoDic[@"houseinfo_name"];
    
    mapView.mapCityName = self.houseinfoDic[@"city_name"];
    
     [self.navigationController pushViewController:mapView animated:YES];
     
}


- (void)back{

    if (_isOnePage == YES) {
        [self.navigationController popViewControllerAnimated:YES];
        self.tabBarController.hidesBottomBarWhenPushed = NO;
    }else{
        
        [self.navigationController popViewControllerAnimated:YES];
        self.tabBarController.hidesBottomBarWhenPushed = YES;
    }

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
