//
//  MapViewController.m
//  EasyRenting
//
//  Created by administrator on 16/4/5.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "MapViewController.h"
#import "Define.h"
#import "MyAnimatedAnnotationView.h"

@interface MapViewController ()<BMKMapViewDelegate,BMKPoiSearchDelegate,BMKDistrictSearchDelegate>

@property (strong, nonatomic)BMKMapView *mapView;

@property (strong, nonatomic)UIView *NavigationView;

@property (strong, nonatomic)BMKPoiSearch *poisearch;

@property (strong, nonatomic)BMKPoiInfo *poi;

@property (strong, nonatomic)NSMutableArray *poiMutArr;

@property (strong, nonatomic)UIButton *bankBtn,*supermarketBtn,*foodBtn,

*hospitalBtn,*schoolBtn,*transitBtn;

@property (assign, nonatomic)int i;

@property (strong, nonatomic)BMKPointAnnotation *item;

@property (strong, nonatomic)NSMutableArray *annotations;

@property (strong, nonatomic)BMKDistrictSearch *districtSearch;

@property (strong, nonatomic)UILabel *titleLabel;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH , SCREEN_HEIGHT-64)];

    self.view = _mapView;
    
    self.NavigationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH5S(320), 64)];
    
    self.NavigationView.backgroundColor = COLOR(243, 197, 0, 1);
    
    [self.view addSubview:self.NavigationView];
    
    //导航栏上的返回键
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 60, 44)];
    
    //    [backBtn setBackgroundImage:[UIImage imageNamed:@"back_select@2x"] forState:UIControlStateNormal];
    
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    [self.NavigationView addSubview:backBtn];
    
    UIImageView *backIma = [[UIImageView alloc]initWithFrame:CGRectMake(2, 10, 25, 25)];
    backIma.image = [UIImage imageNamed:@"back_select@2x"];
    [backBtn addSubview:backIma];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 20, 120, 44)];
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    
    self.titleLabel.text = self.mapTitleName;
    
    self.titleLabel.textColor = COLOR(255, 253, 193, 1);
    
    [self.NavigationView addSubview:self.titleLabel];

    
    NSArray *nameArr= @[@"银行",@"医院",@"学校",@"超市",@"美食",@"公交"];
    
    NSArray *imaArr = @[@"bank",@"hospital",@"school",@"supermarket",@"food",@"transit"];
    
    for (int i = 0; i < nameArr.count ; i++) {
        
        long int n = nameArr.count;
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / n * i, SCREEN_HEIGHT - 49, SCREEN_WIDTH/n, 49)];
        [btn addTarget:self action:@selector(oclick:) forControlEvents:UIControlEventTouchUpInside];
        
        btn.tag = 2010 + i;
    
        btn.backgroundColor = BACKGROUNDCOLOR;
        
        [self.view addSubview:btn];
        
        UIImageView *ima = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / n /4, 5, SCREEN_WIDTH / n / 2, 24)];
        ima.image = [UIImage imageNamed:imaArr[i]];
        
        [btn addSubview:ima];
        
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/n/6, 34, SCREEN_WIDTH / n / 6 * 4, 10)];
        
        label.text = nameArr[i];
        
        label.textAlignment = NSTextAlignmentCenter;
        
        label.font = FONT(10);
        
        [btn addSubview:label];
        

    }
    
    
    
    self.poisearch = [[BMKPoiSearch alloc]init];

    [_mapView setZoomLevel:15];
  
    _mapView.isSelectedAnnotationViewFront = YES;
    

    self.poiMutArr = [NSMutableArray arrayWithCapacity:0];
    
//    self.i = 0;
//    [_mapView setTrafficEnabled:YES];
        // Do any additional setup after loading the view.
}

- (void)oclick:(UIButton *)sender{

    self.i = 1;
    
    long int n = sender.tag - 2010;
    
    NSArray *nameArr= @[@"银行",@"医院",@"学校",@"超市",@"餐馆",@"公交"];
    
    for (int j = 0; j < nameArr.count; j++) {
        if (j == n) {
            UIButton *btn = (UIButton *)[self.view viewWithTag:2010 + j];
            btn.backgroundColor = NAVIGATIONCOLOR;
            
            [self.view addSubview:btn];
        }else{
            UIButton *btn = (UIButton *)[self.view viewWithTag:2010 + j];
            btn.backgroundColor = BACKGROUNDCOLOR;
            
            [self.view addSubview:btn];
        }
    }
    
    
    
    BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc]init];
    
    option.pageIndex = 0;
    
    option.pageCapacity = 10;
    
    
    for (int i = 0; i < _poiMutArr.count; i++) {
        self.poi = _poiMutArr[i];
    
        option.location = self.poi.pt;
        
        option.keyword = nameArr[n];
        
        BOOL flag = [_poisearch poiSearchNearBy:option];
        if(flag)
        {
            NSLog(@"范围内检索发送成功");
        }
        else
        {
            
            NSLog(@"范围内检索发送失败");
        }

    }
    
   
    
}

- (void)test{
    
    self.i = 0;
    
    BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc]init];
    citySearchOption.pageIndex = 0;
    citySearchOption.pageCapacity = 10;
    citySearchOption.city= self.mapCityName;
    citySearchOption.keyword = self.mapTitleName;
    BOOL flag = [_poisearch poiSearchInCity:citySearchOption];
    
    
    if(flag)
    {
        NSLog(@"城市内检索发送成功");
    }
    else
    {
        
        NSLog(@"城市内检索发送失败");
    }

    
    
//    //初始化检索对象
//    _districtSearch = [[BMKDistrictSearch alloc] init];
//    //设置delegate，用于接收检索结果
//        //构造行政区域检索信息类
//    BMKDistrictSearchOption *option = [[BMKDistrictSearchOption alloc] init];
//    option.city = @"北京";
//    option.district = @"海淀";
//    //发起检索
//    BOOL flag = [_districtSearch districtSearch:option];
//    if (flag) {
//        NSLog(@"district检索发送成功");
//    } else {
//        NSLog(@"district检索发送失败");
//    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [_mapView viewWillAppear];
    
    _mapView.delegate = self;
    
    _poisearch.delegate = self;
    
//    _districtSearch.delegate = self;

    
    [self test];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:YES];
    [_mapView viewWillDisappear];
    
    _mapView.delegate = nil;
    
    _poisearch.delegate = nil;
    
//    _districtSearch.delegate = nil;

}

- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
    // 生成重用标示identifier
    if ([_annotations containsObject:annotation] ) {
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

    }else{
        NSString *AnnotationViewID = @"xidanMark";
        
        // 检查是否有重用的缓存
        BMKAnnotationView* annotationView = [view dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
        
        // 缓存没有命中，自己构造一个，一般首次添加annotation代码会运行到此处
        if (annotationView == nil) {
            annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
            ((BMKPinAnnotationView*)annotationView).pinColor = BMKPinAnnotationColorRed;
            // 设置重天上掉下的效果(annotation)
            ((BMKPinAnnotationView*)annotationView).animatesDrop = YES;
        }
        
        // 设置位置
        annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height * 0.5));
        annotationView.annotation = annotation;
        // 单击弹出泡泡，弹出泡泡前提annotation必须实现title属性
        annotationView.canShowCallout = YES;
        // 设置是否可以拖拽
        annotationView.draggable = NO;
        
        return annotationView;

    }
    
    
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


#pragma mark -
#pragma mark implement BMKSearchDelegate
- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult*)result errorCode:(BMKSearchErrorCode)error
{
    // 清楚屏幕中所有的annotation
    
    if (_i == 0) {
        NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
        [_mapView removeAnnotations:array];
        
        if (error == BMK_SEARCH_NO_ERROR) {
            self.annotations = [NSMutableArray array];
//            for (int i = 0; i < result.poiInfoList.count; i++) {
                self.poi = [result.poiInfoList objectAtIndex:0];
                self.item = [[BMKPointAnnotation alloc]init];
                _item.coordinate = _poi.pt;
                _item.title = _poi.name;
                [_annotations addObject:_item];
                [self.poiMutArr addObject:_poi];
//            }
            [_mapView addAnnotations:_annotations];
            [_mapView showAnnotations:_annotations animated:YES];
        } else if (error == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR){
            NSLog(@"起始点有歧义");
        } else {
            
        }


    }else{
        NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
        [_mapView removeAnnotations:array];
        NSMutableArray *annotations = [NSMutableArray array];
        
        if (error == BMK_SEARCH_NO_ERROR) {
            for (int i = 0; i < result.poiInfoList.count; i++) {
                self.poi = [result.poiInfoList objectAtIndex:i];
                BMKPointAnnotation* item1 = [[BMKPointAnnotation alloc]init];
                item1.coordinate = _poi.pt;
                item1.title = _poi.name;
                
                [annotations addObject:item1];
                [self.poiMutArr addObject:_poi];
                [_mapView addAnnotations:annotations];
                [_mapView showAnnotations:annotations animated:YES];
                [_mapView addAnnotations:_annotations];
                [_mapView showAnnotations:_annotations animated:YES];
            }
        } else if (error == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR){
            NSLog(@"起始点有歧义");
        } else {
            
        }

    }

}

- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}




@end
