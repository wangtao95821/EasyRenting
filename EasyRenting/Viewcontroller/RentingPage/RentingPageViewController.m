//
//  RentingPageViewController.m
//  EasyRenting
//
//  Created by administrator on 16/3/28.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "RentingPageViewController.h"
#import "Define.h"
#import "RentingPageCellTableViewCell.h"
#import "RentingPageUnletCellTableViewCell.h"
#import "RentRecordViewController.h"
#import "MyScrollView.h"
#import "MJRefresh.h"
#import "houseService.h"
#import "RentHouseService.h"
#import <CoreImage/CoreImage.h>
#import <AVFoundation/AVFoundation.h>
#import "ScanPageViewController.h"
#import "UIImageView+WebCache.h"
#import "FetchPicService.h"
#import "MBProgressHUD.h"
@interface RentingPageViewController ()<AVCaptureMetadataOutputObjectsDelegate,AVCaptureMetadataOutputObjectsDelegate>

@property (assign, nonatomic) int currentPage;

@property (strong, nonatomic) MyScrollView *scrollView;

@property (strong, nonatomic) NSMutableArray *arrHouseService;

@property (strong, nonatomic) NSMutableArray *arr1HouseService;

@property (strong, nonatomic) UIImageView *imagView;

@property (strong, nonatomic) UIButton *btn1;

@property (assign, nonatomic) BOOL isFinish;

@property (strong ,nonatomic) NSMutableArray *imaUrlArr;

@property (strong ,nonatomic) NSMutableArray *imaUrlFinishArr;

@property (copy, nonatomic) NSString *userID;

@property (strong, nonatomic) MBProgressHUD *hud;

@end

@implementation RentingPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.c = 0;
    self.m = 0;
    
    self.view.backgroundColor = COLOR(245, 245, 245, 1);
    
    self.hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    self.arrHouseService = [NSMutableArray arrayWithCapacity:0];
    self.arr1HouseService = [NSMutableArray arrayWithCapacity:0];
    
    self.imageArr = @[@"888.jpg",@"888.jpg",@"888.jpg",@"888.jpg",@"888.jpg",@"888.jpg",@"888.jpg",@"888.jpg",@"888.jpg"];
    
    self.imageArrY = @[@"7777.jpg",@"7777.jpg",@"7777.jpg",@"7777.jpg",@"7777.jpg",@"7777.jpg"];
    
    self.navigationController.navigationBar.hidden = YES;
    
    UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    
    navView.backgroundColor = NAVIGATIONCOLOR;
    
    [self.view addSubview:navView];
    
    UILabel *navTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH5S(100), 20, WIDTH5S(120), 44)];
    
    navTitleLabel.text = @"出租";
    
    navTitleLabel.font = FONT(20);
    
    navTitleLabel.textColor = COLOR(255, 253, 193, 1);
    
    navTitleLabel.textAlignment = NSTextAlignmentCenter;
    
    [navView addSubview:navTitleLabel];

    
    UIButton *rentBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(280), 30, WIDTH5S(30), 30)];
    
    [rentBtn setTitle:@"出租" forState:UIControlStateNormal];
    
    [rentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    rentBtn.titleLabel.font = FONT(15);
    
    [rentBtn addTarget:self action:@selector(rentBtnCilck) forControlEvents:UIControlEventTouchUpInside];
    
    [navView addSubview:rentBtn];
    
    
    [self createPage];
    
    self.rentTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
  
    //二维码生成
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
    
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device
                                                                        error:&error];
    if (input) {
        [session addInput:input];
    } else {
        NSLog(@"Error: %@", error);
    }
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
    //    [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code]];
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [session addOutput:output];
    [session startRunning];
    
    
    self.hudLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-300, SCREEN_WIDTH, 30)];
    
    self.hudLabel1.text = @"未找到房屋信息!!!";
    
    self.hudLabel1.textColor = SMALLWORD;
    
    self.hudLabel1.textAlignment = NSTextAlignmentCenter;
    
    self.hudLabel1.hidden = YES;
    
    self.hudLabel1.font = FONT(15);
    
    [self.rentTableF addSubview:self.hudLabel1];
    
    
    
    self.hudLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-300, SCREEN_WIDTH, 30)];
    
    self.hudLabel2.text = @"未找到房屋历史记录!!!";
    
    self.hudLabel2.textColor = SMALLWORD;
    
    self.hudLabel2.textAlignment = NSTextAlignmentCenter;
    
//    self.hudLabel2.hidden = YES;
    
    self.hudLabel2.font = FONT(15);
    
    [self.rentTableY addSubview:self.hudLabel2];

}

- (void)captureOutput:(AVCaptureOutput *)captureOutput
didOutputMetadataObjects:(NSArray *)metadataObjects
       fromConnection:(AVCaptureConnection *)connection
{
    NSString *QRCode = nil;
    for (AVMetadataObject *metadata in metadataObjects) {
        if ([metadata.type isEqualToString:AVMetadataObjectTypeQRCode]) {
            // This will never happen; nobody has ever scanned a QR code... ever
            QRCode = [(AVMetadataMachineReadableCodeObject *)metadata stringValue];
            break;
        }
    }
    
    NSLog(@"QR Code: %@", QRCode);
}


- (void)loadNewData{
  
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [houseService houseInfoManager:_userID andSuccess:^(NSMutableArray *arr) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.arrHouseService = arr;
                
                [self imaUrl];
                
                self.rentTableF.frame = CGRectMake(0, HEIGHT5S(260), SCREEN_WIDTH, HEIGHT5S(160)*_arrHouseService.count);
                
                
                self.rentTableHeadView.frame = CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT5S(260) + HEIGHT5S(160)*_arrHouseService.count);
                
                self.rentTable.tableHeaderView = self.rentTableHeadView;
                
                [self.rentTableF reloadData];
                
                [self.rentTable reloadData];
                
                [self.rentTable.mj_header endRefreshing];
            });
        }];
    });



    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
        [houseService houseRecord:_userID andSuccess:^(NSMutableArray *arr) {
        
            dispatch_async(dispatch_get_main_queue(), ^{
            
                self.arr1HouseService = arr;
            
                [self imaUrlFinish];
            
                self.rentTableY.frame = CGRectMake(0, HEIGHT5S(260), SCREEN_WIDTH, HEIGHT5S(160)*_arr1HouseService.count);
            
                self.rentTableHeadView.frame = CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT5S(260) + HEIGHT5S(120)*_arr1HouseService.count);
            
                self.rentTable.tableHeaderView = self.rentTableHeadView;
            
                [self.rentTableY reloadData];
                
                [self.rentTable reloadData];
                
                [self.rentTable.mj_header endRefreshing];
            });
        }];
    });
}


- (void)createPage{
    
    self.l = 0;
    self.currentPage = 0;
    
    self.rentTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, HEIGHT5S(568-113)) style:UITableViewStylePlain];
    
    self.rentTable.dataSource = self;
    self.rentTable.delegate = self;
    
//    self.rentTable.showsHorizontalScrollIndicator = NO;
    self.rentTable.showsVerticalScrollIndicator = NO;
    
    self.rentTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.rentTable.backgroundColor = COLOR(245, 245, 245, 1);
    
    [self.view addSubview:self.rentTable];
    
    
    self.rentTableHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT5S(260))];

    
    self.rentTableHeadView.backgroundColor = [UIColor clearColor];
    
    self.rentTable.tableHeaderView = self.rentTableHeadView;
    
    
    self.scrollView = [[MyScrollView alloc]init];
    
    self.scrollView.frame = CGRectMake(0, 0, WIDTH5S(320), HEIGHT5S(180));
    
    self.scrollView.imageArr = @[
                                 [UIImage imageNamed:@"888.jpg"],
                                 [UIImage imageNamed:@"1102.jpg"],
                                 [UIImage imageNamed:@"7777.jpg"],
                                 [UIImage imageNamed:@"house.jpg"]
                                 ];
    
    
    self.scrollView.MyPage.currentPageIndicatorTintColor = [UIColor orangeColor];
    
    self.scrollView.MyPage.pageIndicatorTintColor = [UIColor whiteColor];
    
    [self.rentTableHeadView addSubview: self.scrollView];
    
    
    
    self.btnView = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT5S(199), SCREEN_WIDTH, HEIGHT5S(40))];
    
    self.btnView.backgroundColor = [UIColor whiteColor];
    
    [self.rentTableHeadView addSubview:self.btnView];
    
    
    self.line1Label = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH5S(159), HEIGHT5S(10), WIDTH5S(1), HEIGHT5S(20))];
    
    self.line1Label.backgroundColor = COLOR(223, 223, 223, 1);
    
    [self.btnView addSubview:self.line1Label];


    self.notRentBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, WIDTH5S(158), HEIGHT5S(40))];
    
    self.notRentBtn.backgroundColor = [UIColor whiteColor];
    
    [self.notRentBtn setTitle:@"未出租" forState:UIControlStateNormal];
    
    [self.notRentBtn setTitleColor:COLOR(200, 152, 220, 1) forState:UIControlStateNormal];
    
    [self.notRentBtn setTitleColor:COLOR(200, 152, 220, 1) forState:UIControlStateHighlighted];
    
    self.notRentBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.notRentBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [self.notRentBtn addTarget:self action:@selector(notRentBtnCilck) forControlEvents:UIControlEventTouchUpInside];
    
    [self.btnView addSubview:self.notRentBtn];

    
    
    self.manageBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(160), 0, WIDTH5S(159), HEIGHT5S(40))];
    
    self.manageBtn.backgroundColor = [UIColor whiteColor];
    
    [self.manageBtn setTitle:@"已出租" forState:UIControlStateNormal];
    
    [self.manageBtn setTitleColor:COLOR(52, 152, 220, 1) forState:UIControlStateNormal];
    
    [self.manageBtn setTitleColor:COLOR(200, 152, 220, 1) forState:UIControlStateHighlighted];
    
    self.manageBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.manageBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [self.manageBtn addTarget:self action:@selector(manageBtnCilck) forControlEvents:UIControlEventTouchUpInside];
    
    [self.btnView addSubview:self.manageBtn];

    
    self.rentTableF = [[UITableView alloc]init];
    
    self.rentTableF.delegate = self;
    self.rentTableF.dataSource = self;
    
    self.rentTableF.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.rentTableHeadView addSubview:self.rentTableF];
    
    
    self.rentTableY = [[UITableView alloc]init];
    
    self.rentTableY.delegate = self;
    self.rentTableY.dataSource = self;
    
    self.rentTableY.hidden = YES;
    
    self.rentTableY.separatorStyle = UITableViewCellSeparatorStyleNone;
    //修改过的
    [self.rentTableHeadView addSubview:self.rentTableY];
    
    NSDictionary *dicUserDefaults = [[NSUserDefaults standardUserDefaults] objectForKey:@"personInfo"];
    
    NSString *code = [dicUserDefaults objectForKey:@"code"];
    
    if ([code isEqual:@200]) {
        
        NSArray *arrUserDefaults = [dicUserDefaults objectForKey:@"result"];
        
        NSDictionary *dic1UserDefaults = arrUserDefaults[0];
        
        self.userID = [dic1UserDefaults objectForKey:@"user_id"];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            [houseService houseInfoManager:_userID andSuccess:^(NSMutableArray *arr) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    self.arrHouseService = arr;
                    
                    [self imaUrl];
                    
                    if (_arrHouseService.count > 0) {
                        
                        [self.hud hideAnimated:YES];
                        
                    }else{
                        
                        sleep(5.);
                        
                        [self.hud hideAnimated:YES];
                        
                        self.hudLabel1.hidden = NO;
                    }

                    
                    self.rentTableF.frame = CGRectMake(0, HEIGHT5S(260), SCREEN_WIDTH, HEIGHT5S(160)*_arrHouseService.count);
                 

                    self.rentTableHeadView.frame = CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT5S(260) + HEIGHT5S(160)*_arrHouseService.count);
                    
                    self.rentTable.tableHeaderView = self.rentTableHeadView;
                    
                    [self.rentTableF reloadData];
                    
                    [self.rentTable reloadData];
                });
            }];
        });
    }
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       
        [houseService houseRecord:_userID andSuccess:^(NSMutableArray *arr) {
           
            dispatch_async(dispatch_get_main_queue(), ^{
               
                self.arr1HouseService = arr;
                
                [self imaUrlFinish];
                
                if (_arr1HouseService.count > 0) {
                    
                    [self.hud hideAnimated:YES];
                    
                }else{
                    
                    sleep(5.);
                    
                    [self.hud hideAnimated:YES];
                    
                    self.hudLabel2.hidden = NO;
                }

                
                self.rentTableY.frame = CGRectMake(0, HEIGHT5S(260), SCREEN_WIDTH, HEIGHT5S(160)*_arr1HouseService.count);
                
                self.rentTableHeadView.frame = CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT5S(260) + HEIGHT5S(120)*_arr1HouseService.count);
                
                self.rentTable.tableHeaderView = self.rentTableHeadView;
                
                [self.rentTableY reloadData];
                
                [self.rentTable reloadData];
            });
        }];
    });
}

//image点击
- (void)detail{

    
}

//button点击
- (void)rentBtnCilck{
    
    self.tabBarController.hidesBottomBarWhenPushed = YES;

    RentRecordViewController *rvc = [[RentRecordViewController alloc]init];

    rvc.gggggg = _arr1HouseService;
    
    [self.navigationController pushViewController:rvc animated:YES];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == _rentTableF) {

        return _arrHouseService.count;
 
    }else if (tableView == _rentTableY){

        return _arr1HouseService.count;
    }
    
    else{
        
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (tableView == _rentTableF) {
    
        RentingPageCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        if (cell == nil) {
            
            cell = [[RentingPageCellTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        
        NSString *str = [self.arrHouseService[indexPath.row] objectForKey:@"houseinfo_id"];
        if (str.length != 0) {
            //初始化
            CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
            NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
            [filter setValue:data forKey:@"inputMessage"];
            [filter setValue:@"M" forKey:@"inputCorrectionLevel"];
            CIImage *outImage = [filter outputImage];
            
            CGRect extent = CGRectIntegral(outImage.extent);
            CGFloat scale = MIN(160/CGRectGetWidth(extent), 160/CGRectGetHeight(extent));
            size_t height = CGRectGetHeight(extent) * scale;
            size_t width = CGRectGetWidth(extent) * scale;
            
            CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
            CGContextRef contextRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
            CIContext *context = [CIContext contextWithOptions:nil];
            CGImageRef imageRef = [context createCGImage:outImage fromRect:extent];
            CGContextSetInterpolationQuality(contextRef, kCGInterpolationNone);
            CGContextScaleCTM(contextRef, scale, scale);
            CGContextDrawImage(contextRef, extent, imageRef);
            CGImageRef imageRef2 = CGBitmapContextCreateImage(contextRef);
            UIImage *image = [UIImage imageWithCGImage:imageRef2];
            
//            cell.cellEWMImage.image = image;
            
            UIButton *btnCell = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(132), HEIGHT5S(115), WIDTH5S(30), WIDTH5S(30))];
            
            [btnCell setBackgroundImage:image forState:UIControlStateNormal];
            
            [btnCell addTarget:self action:@selector(btnCellClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.contentView addSubview:btnCell];
            
            CGContextRelease(contextRef);
            CGColorSpaceRelease(cs);
            CGImageRelease(imageRef);
            CGImageRelease(imageRef2);
            
        }
        
        if (self.imaUrlArr.count == self.arrHouseService.count) {
            
            [cell.cellImageView sd_setImageWithURL:[NSURL URLWithString:self.imaUrlArr[indexPath.row]] placeholderImage:[UIImage imageNamed:@"house.jpg"]];
            
        }
        
        cell.cellDescriptionLabel.text = [self.arrHouseService[indexPath.row] objectForKey:@"houseinfo_description"];
   
        
        cell.cellAdressLabel.text = [self.arrHouseService[indexPath.row] objectForKey:@"houseinfo_address"];
        
        cell.cellApartmentLabel.text = [self.arrHouseService[indexPath.row] objectForKey:@"house_apartment"];
        
        cell.cellPriceLabel.text = [NSString stringWithFormat:@"%@/月",[self.arrHouseService[indexPath.row] objectForKey:@"houseinfo_rent"]];
        
        [cell.cellFinishBtn addTarget:self action:@selector(cellFinishBtnClick:) forControlEvents:UIControlEventTouchUpInside];
      
        return cell;
        
    }else{
        
        RentingPageUnletCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
        
        if (cell == nil) {
            
            cell = [[RentingPageUnletCellTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellid"];
        }
    
        if (self.imaUrlFinishArr.count == self.arr1HouseService.count) {
            
            [cell.cellImageView sd_setImageWithURL:[NSURL URLWithString:self.imaUrlFinishArr[indexPath.row]] placeholderImage:[UIImage imageNamed:@"house.jpg"]];
            
        }
        
        cell.cellDescriptionLabel.text = [self.arr1HouseService[indexPath.row] objectForKey:@"houserecord_description"];
        
        
        cell.cellAdressLabel.text = [self.arr1HouseService[indexPath.row] objectForKey:@"houserecord_address"];
        
        cell.cellApartmentLabel.text = [self.arr1HouseService[indexPath.row] objectForKey:@"house_apartment"];
        
        cell.cellPriceLabel.text = [NSString stringWithFormat:@"%@/月",[self.arr1HouseService[indexPath.row] objectForKey:@"houserecord_rent"]];

        return cell;
    }

}

//未出租
- (void)imaUrl{
    
    FetchPicService *fps = [[FetchPicService alloc]init];
    self.imaUrlArr = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < self.arrHouseService.count; i++) {
        [fps houseInfoId:[self.arrHouseService[i][@"houseinfo_id"] intValue]  successWith:^(NSDictionary *dic) {
            NSArray *arr = dic[@"result"];
            NSString *picName = arr[0][@"houseimage_name"];
            NSString *newPicName = [NSString stringWithFormat:@"http://115.159.215.30/Tupian/image/%@",picName];
            
            [self.imaUrlArr addObject:newPicName];
            
            
            [self.rentTable reloadData];
        }];
        
    }
}

//已出租
- (void)imaUrlFinish{
    
    FetchPicService *fps = [[FetchPicService alloc]init];
    self.imaUrlFinishArr = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < self.arr1HouseService.count; i++) {
        [fps houseInfoId:[self.arr1HouseService[i][@"t_houseinfo_houseinfo_id"] intValue]  successWith:^(NSDictionary *dic) {
            NSArray *arr = dic[@"result"];
            NSString *picName = arr[0][@"houseimage_name"];
            NSString *newPicName = [NSString stringWithFormat:@"http://115.159.215.30/Tupian/image/%@",picName];
            
            [self.imaUrlFinishArr addObject:newPicName];
            
            
            [self.rentTable reloadData];
        }];
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (tableView == _rentTableF) {
        
        return 160;
        
    }else{
    
        return 120;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{

    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{

    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{

    if (tableView == _rentTableF) {
        
        NSString *strRentTableF = [_arrHouseService[indexPath.row] objectForKey:@"houseinfo_id"];
        
        [self.arrHouseService removeObjectAtIndex:indexPath.row];
        
        [_rentTableF deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [RentHouseService finishRent:strRentTableF andSuccess:nil];
    }
    
    if (tableView == _rentTableY) {
        
        NSString *strRentTableY = [_arr1HouseService[indexPath.row] objectForKey:@"houserecord_id"];
        
        [self.arr1HouseService removeObjectAtIndex:indexPath.row];
        
        [_rentTableY deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [RentHouseService finishRentRecord:strRentTableY andSuccess:nil];
    }
}

//二维码放大
- (void)btnCellClick:(UIButton *)sender{
    
    if (self.isFinish == NO) {
        
        CGFloat scaleX = 160 / sender.frame.size.width;
        CGFloat scaleY = scaleX;
        
        [UIView animateWithDuration:1.0 animations:^{
            
            //缩放
            sender.transform = CGAffineTransformMakeScale(scaleX, scaleY);
            sender.transform = CGAffineTransformTranslate(sender.transform, 0, 0);
        }];
        
        self.isFinish = YES;
        
//        [self.view addSubview:sender];
        
//        self.tabBarController.hidesBottomBarWhenPushed = YES;
        
    }else
    {
        // 图片还原
        [UIView animateWithDuration:1.0 animations:^{
            sender.transform = CGAffineTransformIdentity;
            
            self.isFinish = NO;
        }];
        
//        self.tabBarController.hidesBottomBarWhenPushed = NO;
    }
    
}

//完成出租按钮
- (void)cellFinishBtnClick:(UIButton *)sender{
    
    UITableViewCell *cell = (UITableViewCell *)[[sender superview]superview];
    
    NSIndexPath *path = [self.rentTableF indexPathForCell:cell];
    
    ScanPageViewController *svc = [[ScanPageViewController alloc]init];
    
    svc.strScan = [self.arrHouseService[path.row] objectForKey:@"houseinfo_id"];
    
    [self.navigationController pushViewController:svc animated:YES];
    
}


- (void)notRentBtnCilck{

    self.rentTableY.hidden = YES;
    
    self.rentTableF.hidden = NO;
    
    [self.manageBtn setTitleColor:COLOR(52, 152, 220, 1) forState:UIControlStateNormal];
    
    [self.notRentBtn setTitleColor:COLOR(200, 152, 220, 1) forState:UIControlStateNormal];
    
    self.rentTableF.scrollsToTop = YES;
    
    self.rentTableF.frame = CGRectMake(0, HEIGHT5S(260), SCREEN_WIDTH, HEIGHT5S(160)*_arrHouseService.count);
    
    
    self.rentTableHeadView.frame = CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT5S(260) + HEIGHT5S(160)*_arrHouseService.count);
    
    self.rentTable.tableHeaderView = self.rentTableHeadView;
    
    [self.rentTableF reloadData];
    
    [self.rentTable reloadData];
}

- (void)manageBtnCilck{

    self.rentTableF.hidden = YES;
    self.rentTableY.hidden = NO;
    
    [self.manageBtn setTitleColor:COLOR(200, 152, 220, 1) forState:UIControlStateNormal];
    
    [self.notRentBtn setTitleColor:COLOR(52, 152, 220, 1) forState:UIControlStateNormal];
    
    self.rentTableY.scrollsToTop = YES;
    
    self.rentTableHeadView.frame = CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT5S(260) + HEIGHT5S(120)*_arr1HouseService.count);
    
    self.rentTableY.frame = CGRectMake(0, HEIGHT5S(260), SCREEN_WIDTH, HEIGHT5S(120)*_arr1HouseService.count);
    
    self.rentTable.tableHeaderView = self.rentTableHeadView;
    
    [self.rentTableY reloadData];
    
    [self.rentTable reloadData];
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    self.tabBarController.hidesBottomBarWhenPushed = NO;
}


@end
