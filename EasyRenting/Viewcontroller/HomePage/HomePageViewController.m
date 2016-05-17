//
//  HomePageViewController.m
//  EasyRenting
//
//  Created by administrator on 16/3/28.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "HomePageViewController.h"
#import "Define.h"
#import <AVFoundation/AVFoundation.h>
#import "HomePageTableViewCell.h"
#import "MyScrollView.h"
#import "HouseStyleViewController.h"
#import "HouseInfoViewController.h"
#import "ChangeCityViewControllers.h"
#import <CoreLocation/CoreLocation.h>
#import "MJRefresh.h"
#import "CityDistrictService.h"
#import "GetCityHouseInfoService.h"
#import "ScanPageViewController.h"
#import "UIImageView+WebCache.h"
#import "Quantity.h"
#import "MBProgressHUD.h"
@interface HomePageViewController ()<CLLocationManagerDelegate,AVCaptureMetadataOutputObjectsDelegate>

@property (assign, nonatomic)int i;
@property (assign, nonatomic)int j;
@property (assign, nonatomic)BOOL isName;
@property (assign, nonatomic)float alpha;

@property (strong, nonatomic)UILabel *titleLabel;

@property (strong, nonatomic)UIButton *searchBtn;
@property (strong, nonatomic)UIButton *cityBtn;

@property (strong, nonatomic)UIPageControl *page;

@property (strong, nonatomic)NSTimer *timer;

@property (strong, nonatomic)UIView *headView;
@property (strong, nonatomic)UIView *headView1;
@property (strong, nonatomic)UIView *boxView;

@property (strong, nonatomic)CLLocationManager *locationManager;

@property (strong, nonatomic)NSString *cityNameStr;
@property (strong, nonatomic)NSString *provinceStr;

@property (strong, nonatomic)MyScrollView *scrollView;
@property (strong, nonatomic)MyScrollView *myscroll;

@property (strong, nonatomic)NSMutableArray *housePicNameArr;
@property (strong, nonatomic)NSMutableArray *cityHeadArr;
@property (strong, nonatomic)NSMutableArray *imaUrlArr;
@property (strong, nonatomic)NSMutableArray *cityArr;

@property (strong, nonatomic)AVCaptureSession *session;
@property (strong, nonatomic)AVCaptureVideoPreviewLayer *previewLayer;

@property (strong, nonatomic) MBProgressHUD *hud;

@property (strong, nonatomic)Quantity *amount;
@end

@implementation HomePageViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.tabBarController.hidesBottomBarWhenPushed = YES;
    
    self.amount = [Quantity addInstance];
    
    NSDictionary *dics = @{
                           @"江苏省":@"苏州市"
                           };
    
    [self.amount setValue:dics forKey:@"cityDic"];
    
    self.isName = NO;
    self.j = 1;
    //首页tableview的初始化
    self.HomePageTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -20, WIDTH5S(320), HEIGHT5S(588))];
    [self.view addSubview:self.HomePageTableView];
    self.HomePageTableView.delegate = self;
    self.HomePageTableView.dataSource = self;
    self.HomePageTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.HomePageTableView.tableFooterView = [[UIView alloc]init];
    
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH5S(320), HEIGHT5S(425))];
    
    self.HomePageTableView.tableHeaderView = self.headView;
    
    self.HomePageTableView.showsVerticalScrollIndicator = NO;
    
    //顶部scollview的初始化
    self.scrollView = [[MyScrollView alloc]init];

    
    //给scollview添加点击事件
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTest)];
    [self.scrollView addGestureRecognizer:tap];
    
    
    
    self.headView1 = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT5S(180), SCREEN_WIDTH, HEIGHT5S(245))];
    [self.headView addSubview:_headView1];
    
    NSArray *arr = @[@"实惠一居",@"经典两居",@"舒适三居",@"豪华生活",@"阳光主卧",@"舒适次卧",@"暖心小窝",@"独立卫生间"];
    self.arr1 = @[@"实惠一居",@"经典两居",@"舒适三居",@"豪华生活",@"阳光主卧",@"舒适次卧",@"暖心小窝",@"独立卫生间"];
    NSArray *houseType = @[@"hpic1.jpg",@"hpic2.jpg",@"hpic3.jpg",@"hpic4.jpg",@"hpic5.jpg",@"hpic6.jpg",@"hpic7.jpg",@"hpic8.jpg"];
    
    for (int i = 0; i < 2; i++) {
        
        for (int j = 0; j < 4; j++) {
            
            UIButton *houseStylebtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(30) + j * WIDTH5S(75), HEIGHT5S(25) + i * HEIGHT5S(90), WIDTH5S(45), WIDTH5S(45))];
            
            houseStylebtn.layer.cornerRadius = 22.5;
            
            houseStylebtn.clipsToBounds = YES;
            
            [houseStylebtn setImage:[UIImage imageNamed:houseType[i * 4 + j]]forState:UIControlStateNormal];
            
            houseStylebtn.tag = 2000 + i * 4 + j;
            
            [houseStylebtn addTarget:self action:@selector(houseStyle:) forControlEvents:UIControlEventTouchUpInside];
            
            [_headView1 addSubview:houseStylebtn];
            
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake( WIDTH5S(20) + j * WIDTH5S(75), HEIGHT5S(65) + i * HEIGHT5S(90), WIDTH5S(60), WIDTH5S(45))];
            
            lab.textAlignment = NSTextAlignmentCenter;
            
            lab.font = [UIFont systemFontOfSize:12];
            
            lab.textColor = COLOR(153, 153, 153, 1);
            
            lab.text = arr[i * 4 + j];
            
            [_headView1 addSubview:lab];
        }
    }
    
    
    
    UILabel *backgroundLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT5S(200), WIDTH5S(320), HEIGHT5S(15))];
    
    backgroundLabel.backgroundColor = COLOR(244, 244, 244, 1);
    
    [_headView1 addSubview:backgroundLabel];
    
    UILabel *backgroundLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT5S(215), WIDTH5S(5), HEIGHT5S(30))];
    
    backgroundLabel1.backgroundColor = COLOR(106, 174, 25, 1);
    
    [_headView1 addSubview:backgroundLabel1];
    
    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT5S(245)-1, WIDTH5S(320), 1)];
    
    lineLabel.backgroundColor = COLOR(223, 223, 223, 1);
    
    [_headView1 addSubview:lineLabel];

    UILabel *likeLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH5S(10), HEIGHT5S(220), WIDTH5S(55), WIDTH5S(20))];
    
    likeLabel.textColor = COLOR(153, 153, 153, 1);
    
    likeLabel.font = [UIFont systemFontOfSize:13];
    
    likeLabel.text = @"最新房屋";
    
    [_headView1 addSubview:likeLabel];
    
    self.alpha = 0;
    
    self.NavigationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH5S(320), 64)];
    
    self.NavigationView.backgroundColor = COLOR(243, 197, 0, _alpha);
    
    [self.view addSubview:self.NavigationView];
    
    self.cityBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 32, 60, 20)];
    
    [_cityBtn setTitle:@"苏州市▼" forState:UIControlStateNormal];
    
    _cityBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [_cityBtn addTarget:self action:@selector(cityPage) forControlEvents:UIControlEventTouchUpInside];
    
    [_cityBtn setTitleColor:COLOR(255, 253, 193, 1) forState:UIControlStateNormal];
    
    [self.NavigationView addSubview:_cityBtn];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 20, 120, 44)];
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.titleLabel.font = [UIFont systemFontOfSize:20];
    
    self.titleLabel.text = @"首页";
    
    self.titleLabel.alpha = _alpha;
    
    self.titleLabel.textColor = COLOR(255, 253, 193, 1);
    
    [self.NavigationView addSubview:self.titleLabel];
    
    //搜索
    self.searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(285), 20, 44, 44)];
    
    [self.searchBtn addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    
    self.searchBtn.alpha = 1;
    
    [self.NavigationView addSubview:self.searchBtn];
    
    UIImageView *searchIma = [[UIImageView alloc]initWithFrame:CGRectMake(0, 14, 20, 20)];
    searchIma.image = [UIImage imageNamed:@"扫一扫.png"];
    [self.searchBtn addSubview:searchIma];
    
    self.cityNameStr = @"苏州市";
    self.provinceStr = @"江苏省";
    
    //定位管理
    self.locationManager = [[CLLocationManager alloc]init];
    
    _locationManager.delegate = self;
    //开启定位
    [_locationManager requestAlwaysAuthorization];
    
    //运行定位方法
    [self locate];
    
    //加载数据动画
    self.hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];

    //请求数据
    [self houseinfo];
    
    //下拉刷新
    self.HomePageTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    //上拉刷新
    
    self.HomePageTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        self.j++;
        
        GetCityHouseInfoService *ghs1 = [[GetCityHouseInfoService alloc]init];
        
        [ghs1 CityName:self.cityNameStr WithPageIndex:self.j andSuccessWith:^(NSMutableArray *arr) {
            
            for (int i = 0; i < arr.count; i++) {
                [self.cityArr addObject:arr[i]];
            }
            [self.HomePageTableView.mj_footer endRefreshing];
            [self imaUrl];
            [self.HomePageTableView reloadData];
        }];
        
        
    }];
    

}

- (void)houseinfo{
    self.cityHeadArr = [NSMutableArray arrayWithCapacity:0];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        GetCityHouseInfoService *ghs = [[GetCityHouseInfoService alloc]init];
        
        [ghs CityName:self.cityNameStr WithPageIndex:self.j andSuccessWith:^(NSMutableArray *arr) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.cityArr = arr;
                
                if (arr.count > 0) {
                   
                    [self imaUrl];
                    [self.HomePageTableView reloadData];
                    if (arr.count > 5) {
                        while (self.cityHeadArr.count < 5) {
                            int n = ARC(arr.count );
                            if ([self.cityHeadArr containsObject:arr[n]] == NO) {
                                [self.cityHeadArr addObject:arr[n]];
                            }
                        }
                    }else{
                        [self.cityHeadArr setArray:arr];
                    }
                    [self requestPic];
                    [self.HomePageTableView reloadData];
                }else{
                    
                    sleep(10.);
                    
                    [self.hud hideAnimated:YES];
                    
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"网络有问题，请检查你的网络！" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                    }];
                    [alert addAction:action];
                    [self presentViewController:alert animated:YES completion:nil];
                    
                }
                
            });
            
        }];
        
    });

}

- (void)imaUrl{
    FetchPicService *fps = [[FetchPicService alloc]init];
    self.imaUrlArr = [NSMutableArray arrayWithCapacity:0];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 0; i < self.cityArr.count; i++) {
            [fps houseInfoId:[self.cityArr[i][@"houseinfo_id"] intValue]  successWith:^(NSDictionary *dic) {
                NSArray *arr = dic[@"result"];
                NSString *picName = arr[0][@"houseimage_name"];
                NSString *newPicName = [NSString stringWithFormat:@"http://115.159.215.30/Tupian/image/%@",picName];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.imaUrlArr addObject:newPicName];
                    [self.HomePageTableView reloadData];
 
                });
            }];
            
        }

    });
    

}

- (void)requestPic{
    FetchPicService *fps = [[FetchPicService alloc]init];
     self.housePicNameArr  = [NSMutableArray arrayWithCapacity:0];
    __block long n = self.cityHeadArr.count;
    for (int i = 0; i < self.cityHeadArr.count; i++) {
        [fps houseInfoId:[self.cityHeadArr[i][@"houseinfo_id"] intValue]  successWith:^(NSDictionary *dic) {
            
            NSArray *arr = dic[@"result"];
            
            NSString *picName = arr[0][@"houseimage_name"];
            
           
            NSString *newPicName = [NSString stringWithFormat:@"http://115.159.215.30/Tupian/image/%@",picName];
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                UIImage *ima =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:newPicName]]];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if (ima != nil) {
                        [self.housePicNameArr addObject:ima];
                    }else{
                        n--;
                    }
                    
                    NSLog(@"++++%ld----%ld",self.housePicNameArr.count,n);
                    
                    if (self.housePicNameArr.count == n) {
                        
                        [self scroolViewCreat];
                        
                        [self.hud hideAnimated:YES];
                        
                        self.tabBarController.hidesBottomBarWhenPushed = NO;
                    }
 
                });
                
            });
            
        }];
       
    }

}

- (void)scroolViewCreat{
    
    self.scrollView.frame = CGRectMake(0, 0, WIDTH5S(320), HEIGHT5S(180));
    
    if (self.housePicNameArr.count == 0) {
        self.scrollView.imageArr = @[[UIImage imageNamed:@"house.jpg"]];
    }else{
        self.scrollView.imageArr = self.housePicNameArr;
    }
    
    
    
    self.scrollView.MyPage.currentPageIndicatorTintColor = [UIColor orangeColor];
    
    self.scrollView.MyPage.pageIndicatorTintColor = [UIColor whiteColor];
    
    [self.headView addSubview: self.scrollView];
}

//测试用的搜索方法
- (void)search{
    
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    
    
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc]init];
    
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    output.rectOfInterest = CGRectMake((124)/SCREEN_HEIGHT,((SCREEN_WIDTH-220)/2)/SCREEN_WIDTH,220/SCREEN_HEIGHT,220/SCREEN_WIDTH)
    ;
    
    AVCaptureSession *session = [[AVCaptureSession alloc]init];
    
    [session addInput:input];
    
    [session addOutput:output];
    
    [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    
    self.session = session;
    
    AVCaptureVideoPreviewLayer *preview = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    
    preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    preview.frame = self.view.bounds;
    
    [self.view.layer insertSublayer:preview atIndex:100];
    
    self.previewLayer = preview;
    
    [_session startRunning];
    
    
    _boxView = [[UIView alloc] initWithFrame:CGRectMake(60,124,220,220)];
    _boxView.layer.borderColor = [UIColor purpleColor].CGColor;
    _boxView.layer.borderWidth = 1.0f;
    [_previewLayer addSublayer:_boxView.layer];
    
    
    
    
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    [self.session stopRunning];
    
    [self.previewLayer removeFromSuperlayer];
    
    if (metadataObjects.count > 0) {
        
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        
        NSLog(@"%@",obj.stringValue);
        
        ScanPageViewController *spvc = [[ScanPageViewController alloc]init];
        
        spvc.strScan = obj.stringValue;
        
        [self.navigationController pushViewController:spvc animated:YES];
    }
}

//点击手势触发时间
- (void)tapTest{
    
//    NSLog(@"%ld",self.scrollView.MyPage.currentPage);
    
    HouseInfoViewController *hivc = [[HouseInfoViewController alloc]init];
    
    hivc.isOnePage = YES;
    
    hivc.houseinfoDic = self.cityHeadArr[self.scrollView.MyPage.currentPage];
    
    [self.tabBarController setHidesBottomBarWhenPushed:YES];
    
    [self.navigationController pushViewController:hivc animated:YES];

    
}

- (void)loadNewData{
    self.j=1;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        GetCityHouseInfoService *ghs = [[GetCityHouseInfoService alloc]init];
        
        [ghs CityName:self.cityNameStr WithPageIndex:self.j andSuccessWith:^(NSMutableArray *arr) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.cityArr = arr;
                [self imaUrl];
                if (arr.count > 0) {
                    [self imaUrl];
                    [self.HomePageTableView reloadData];
                    if (arr.count > 5) {
                        while (self.cityHeadArr.count < 5) {
                            int n = ARC(arr.count );
                            if ([self.cityHeadArr containsObject:arr[n]] == NO) {
                                [self.cityHeadArr addObject:arr[n]];
                            }
                        }
                    }else{
                        [self.cityHeadArr setArray:arr];
                    }
                }
                [self requestPic];
                [self.HomePageTableView reloadData];
                [self.HomePageTableView.mj_header endRefreshing];
            });
            
        }];
        
    });

}


- (void)cityPage{
    
    ChangeCityViewControllers *ccvc = [[ChangeCityViewControllers alloc]init];
    ccvc.cityDelegate = self;
    
    [self.navigationController pushViewController:ccvc animated:YES];
    
    
}
//主页tableview返回的行数
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
    
    NSString *rent = [NSString stringWithFormat:@"%@/月",self.cityArr[indexPath.row][@"houseinfo_rent"]];
    cell.houseRentlabel.text = rent;
    
    cell.houseApartmentlabel.text =self.cityArr[indexPath.row][@"housetype_name"];
    
    if ([(self.cityArr[indexPath.row][@"houseinfo_rentstyle"]) isEqualToString: @"0"] ) {
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
    
    HouseInfoViewController *hivc = [[HouseInfoViewController alloc]init];
    
    hivc.isOnePage = YES;
    
    hivc.houseinfoDic = self.cityArr[indexPath.row];
    
    [self.tabBarController setHidesBottomBarWhenPushed:YES];
    
    [self.navigationController pushViewController:hivc animated:YES];
    
     
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    float y = self.HomePageTableView.contentOffset.y;
    
    self.alpha = y / 116;
    
    self.NavigationView.backgroundColor = COLOR(243, 197, 0, _alpha);
    
    self.titleLabel.alpha = _alpha;
       
}


- (void)houseStyle:(UIButton *)sender{
    
    long int t = sender.tag;
    
//    NSLog(@"%@",_arr1[t - 2000]);
    
    HouseStyleViewController *houseVC = [[HouseStyleViewController alloc]init];
    
    houseVC.titleStr = _arr1[t - 2000];
    
    houseVC.cityName = self.cityNameStr;
    
    houseVC.provinceName = self.provinceStr;
    
    houseVC.houseStyle = [NSString stringWithFormat:@"%ld",t - 2000 + 1];
    
    self.tabBarController.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:houseVC animated:YES];
    
}

//自动定位
- (void)locate{
    
    if ([CLLocationManager locationServicesEnabled]) {
        
        
        //开始定位
        [_locationManager startUpdatingLocation];
    }else{
        
        NSLog(@"未开启定位");
        
    }
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    //开启线程
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        CLLocation *currentLocation = [locations lastObject];
        
        CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
        
        [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            
            
            if (placemarks.count > 0) {
                CLPlacemark *placemark = placemarks[0];
                
                NSString *currentCity = placemark.locality;
                
                if (!currentCity) {
                    //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                    currentCity = placemark.administrativeArea;
                }
                //获取到的城市
//                NSLog(@"%@",currentCity);
                self.cityNameStr = currentCity;
                
                self.provinceStr = placemark.administrativeArea;
                
                NSString *cityNameStr1 = [NSString stringWithFormat:@"%@▼",currentCity];
                
                [self.cityBtn setTitle:cityNameStr1 forState:UIControlStateNormal];
                
            }else if (error==nil&&placemarks.count==0){
                NSLog(@"NO location and error returned");
            }else if(error){
                NSLog(@"error:%@",error);
            }
            
        }];
        //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
        [manager stopUpdatingHeading];
    });
}


- (void)showCityName:(NSDictionary *)dic{
    
    
    self.isName = YES;
    
    self.cityNameStr = [dic objectForKey:@"city"];
    
    self.provinceStr = [dic objectForKey:@"province"];
    
    NSDictionary *dics = @{
                           self.provinceStr:_cityNameStr
                           };
    
    [self.amount setValue:dics forKey:@"cityDic"];
    
    NSString *cityNameStr1 = [NSString stringWithFormat:@"%@▼",_cityNameStr];
    
    [self.cityBtn setTitle:cityNameStr1 forState:UIControlStateNormal];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (_isName) {
        self.j = 1;
        self.hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            GetCityHouseInfoService *ghs = [[GetCityHouseInfoService alloc]init];
            
            [ghs CityName:self.cityNameStr WithPageIndex:self.j andSuccessWith:^(NSMutableArray *arr) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.cityArr = arr;
                    
                    [self.hud hideAnimated:YES];
                    
                    [self.HomePageTableView reloadData];
                });
                
            }];
            
        }); 

    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
