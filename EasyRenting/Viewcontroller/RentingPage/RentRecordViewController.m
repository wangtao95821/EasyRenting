//
//  RentRecordViewController.m
//  EasyRenting
//
//  Created by administrator on 16/4/11.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "RentRecordViewController.h"
#import "Define.h"
#import "RentRecordCellTableViewCell.h"
#import "RentingHouseViewController.h"
#import "houseService.h"
#import "RentHouseService.h"
#import "RentRecordSecondCellTableViewCell.h"
#import "FetchPicService.h"
#import "UIImageView+WebCache.h"
@interface RentRecordViewController ()

@property (strong, nonatomic) NSMutableArray *editMutArr;

@property (strong, nonatomic) NSMutableArray *uneditMutArr;

//@property (assign, nonatomic) int timer;

@property (copy, nonatomic) NSString *isedit;

@property (strong ,nonatomic) NSMutableArray *imaUrlFinishArr;
@end

@implementation RentRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.view.backgroundColor = COLOR(253, 253, 253, 1);
    
    self.navigationController.navigationBar.hidden = YES;
    
    UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    
    navView.backgroundColor = NAVIGATIONCOLOR;
    
    [self.view addSubview:navView];
    
    UILabel *navTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH5S(100), 20, WIDTH5S(120), 44)];
    
    navTitleLabel.text = @"出租记录";
    
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
    
    
    UIButton *rentBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(280), 30, WIDTH5S(30), 30)];
    
    [rentBtn setTitle:@"出租" forState:UIControlStateNormal];
    
    [rentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    rentBtn.titleLabel.font = FONT(15);
    
    [rentBtn addTarget:self action:@selector(rentBtnCilck) forControlEvents:UIControlEventTouchUpInside];
    
    [navView addSubview:rentBtn];
  
    self.recordArr = [NSMutableArray arrayWithCapacity:0];
    
    self.editMutArr = [NSMutableArray arrayWithCapacity:0];
    
    self.uneditMutArr = [NSMutableArray arrayWithCapacity:0];
    
    self.manageTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, HEIGHT5S(568-64)) style:UITableViewStylePlain];
    
    self.manageTable.delegate = self;
    self.manageTable.dataSource = self;
    
    self.manageTable.showsVerticalScrollIndicator = NO;
    
    self.manageTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.manageTable];
    
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT/3, SCREEN_WIDTH, 100)];
    
    self.label.text = @"没有出租记录\n点击右上角添加房屋信息，完成出租！";
    
    self.label.hidden = YES;
    
    self.label.font = FONT(15);

    self.label.numberOfLines = self.label.text.length;
    
    self.label.textAlignment = NSTextAlignmentCenter;
    
    self.label.textColor = SMALLWORD;
    
    [self.view addSubview:self.label];
    
 
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        
        [self.recordArr setArray:_gggggg];
        
        if (_recordArr.count == 0) {
            
            self.label.hidden = NO;
        }
        
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            dateFormatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
            NSString *dateString =[dateFormatter stringFromDate:[NSDate date]];
            
            NSString *YStrDate = [dateString substringWithRange:NSMakeRange(0, 4)];
            
            NSString *MStrDate = [dateString substringWithRange:NSMakeRange(5, 2)];
            
            NSString *DStrDate = [dateString substringWithRange:NSMakeRange(7, 2)];
        
            
            for (int t = 0; t < _recordArr.count; t ++) {
                
                NSString *date1 = [_recordArr[t] objectForKey:@"houserecord_date"];
                
                NSString *YStrDate1 = [date1 substringWithRange:NSMakeRange(0, 4)];
                
                NSString *MStrDate1 = [date1 substringWithRange:NSMakeRange(5, 2)];
                
                NSString *DStrDate1 = [date1 substringWithRange:NSMakeRange(5, 2)];
                
                
                if (YStrDate.intValue > YStrDate1.intValue) {
                    
                    self.isedit = @"0";
                    
                    [self.editMutArr addObject:_isedit];
                    
                }else if (YStrDate.intValue > YStrDate1.intValue&&MStrDate.intValue > MStrDate1.intValue){
                    
                    self.isedit = @"0";
                    
                    [self.editMutArr addObject:_isedit];
                    
                }else if (YStrDate.intValue > YStrDate1.intValue&&MStrDate.intValue > MStrDate1.intValue&&DStrDate.intValue > DStrDate1.intValue){
                    
                    self.isedit = @"0";
                    
                    [self.editMutArr addObject:_isedit];
                    
                }else{
                    
                    self.isedit = @"1";
                    
                    [self.editMutArr addObject:_isedit];
                }
                
            }

        [self imaUrlFinish];
            
            dispatch_async(dispatch_get_main_queue(), ^{
               
                
                [self.manageTable reloadData];
            });
//        }];
    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _recordArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([_editMutArr[indexPath.row] isEqualToString:@"0"]) {
        
        RentRecordCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"manage"];
        
        if (cell == nil) {
            
            cell = [[RentRecordCellTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"manage"];
        }
        
        if (self.imaUrlFinishArr.count == self.recordArr.count) {
            
            [cell.manageImageView sd_setImageWithURL:[NSURL URLWithString:self.imaUrlFinishArr[indexPath.row]] placeholderImage:[UIImage imageNamed:@"house.jpg"]];
            
        }
        
//        cell.manageImageView.image = [UIImage imageNamed:@"15145651.jpg"];
        cell.manageDescriptionLabel.text = [self.recordArr[indexPath.row] objectForKey:@"houserecord_description"];
        cell.manageAdressLabel.text = [self.recordArr[indexPath.row] objectForKey:@"houserecord_address"];
        cell.manageApartmentLabel.text = [self.recordArr[indexPath.row] objectForKey:@"house_apartment"];
        cell.managePriceLabel.text = [self.recordArr[indexPath.row] objectForKey:@"houserecord_rent"];
        
        [cell.manageBtn addTarget:self action:@selector(manageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.editBtn addTarget:self action:@selector(editBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;

    }else{
        
        RentRecordSecondCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"manageid"];
        
        if (cell == nil) {
            
            cell = [[RentRecordSecondCellTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"manageid"];
        }

        if (self.imaUrlFinishArr.count == self.recordArr.count) {
            
            [cell.manageImageView sd_setImageWithURL:[NSURL URLWithString:self.imaUrlFinishArr[indexPath.row]] placeholderImage:[UIImage imageNamed:@"house.jpg"]];
            
        }
    
//        cell.manageImageView.image = [UIImage imageNamed:@"15145651.jpg"];
        cell.manageDescriptionLabel.text = [self.recordArr[indexPath.row] objectForKey:@"houserecord_description"];
        cell.manageAdressLabel.text = [self.recordArr[indexPath.row] objectForKey:@"houserecord_address"];
        cell.manageApartmentLabel.text = [self.recordArr[indexPath.row] objectForKey:@"house_apartment"];
        cell.managePriceLabel.text = [self.recordArr[indexPath.row] objectForKey:@"houserecord_rent"];
        
        return cell;
    }
 
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
    if ([_editMutArr[indexPath.row] isEqualToString:@"0"]) {
    
        return 150;
        
    }else{
//
        return 120;
    }
    
    
}

//已出租
- (void)imaUrlFinish{
    
    FetchPicService *fps = [[FetchPicService alloc]init];
    self.imaUrlFinishArr = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < self.recordArr.count; i++) {
        [fps houseInfoId:[self.recordArr[i][@"t_houseinfo_houseinfo_id"] intValue]  successWith:^(NSDictionary *dic) {
            NSArray *arr = dic[@"result"];
            NSString *picName = arr[0][@"houseimage_name"];
            NSString *newPicName = [NSString stringWithFormat:@"http://115.159.215.30/Tupian/image/%@",picName];
            
            [self.imaUrlFinishArr addObject:newPicName];
            
            
            [self.manageTable reloadData];
        }];
        
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{

    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{

    [self.recordArr removeObjectAtIndex:indexPath.row];
        
    [self.manageTable deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
}

- (void)BACK{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    self.tabBarController.hidesBottomBarWhenPushed = NO;
}

- (void)rentBtnCilck{

    RentingHouseViewController *rhvc = [[RentingHouseViewController alloc]init];
    
    [self.navigationController pushViewController:rhvc animated:YES];
}

- (void)manageBtnClick:(UIButton *)sender{

    UITableViewCell *cell = (UITableViewCell *)[[sender superview] superview];
    
    NSIndexPath *path = [self.manageTable indexPathForCell:cell];
    
//    NSLog(@"*********++++++++++++++%ld",path.row);
    
    NSDictionary *dicHouseInfo = _recordArr[path.row];
    
    NSMutableDictionary *recordMutDic = [NSMutableDictionary dictionaryWithCapacity:0];
    
    [recordMutDic setObject:[dicHouseInfo objectForKey:@"t_user_user_id"] forKey:@"userid"];
    [recordMutDic setObject:[dicHouseInfo objectForKey:@"houserecord_name"] forKey:@"housename"];
    [recordMutDic setObject:[dicHouseInfo objectForKey:@"houserecord_address"] forKey:@"houseaddress"];
    [recordMutDic setObject:[dicHouseInfo objectForKey:@"houserecord_area"] forKey:@"housearea"];
    [recordMutDic setObject:[dicHouseInfo objectForKey:@"houserecord_floor"] forKey:@"housefloor"];
    [recordMutDic setObject:[dicHouseInfo objectForKey:@"house_apartment"] forKey:@"houseapartment"];
    [recordMutDic setObject:[dicHouseInfo objectForKey:@"houserecord_description"] forKey:@"housedescription"];
    [recordMutDic setObject:[dicHouseInfo objectForKey:@"houserecord_facility"] forKey:@"housefacility"];
    [recordMutDic setObject:[dicHouseInfo objectForKey:@"houserecord_rentstyle"] forKey:@"houserentstyle"];
    [recordMutDic setObject:[dicHouseInfo objectForKey:@"houserecord_rent"] forKey:@"houserent"];
    [recordMutDic setObject:[dicHouseInfo objectForKey:@"city_name"] forKey:@"cityname"];
    [recordMutDic setObject:[dicHouseInfo objectForKey:@"housetype_style"] forKey:@"housetypestyle"];
    [recordMutDic setObject:[dicHouseInfo objectForKey:@"district_name"] forKey:@"housedistrictname"];
    [recordMutDic setObject:[dicHouseInfo objectForKey:@"contacts_name"] forKey:@"contactname"];
    [recordMutDic setObject:[dicHouseInfo objectForKey:@"contacts_phone"] forKey:@"contactphone"];
//    [recordMutDic setObject:[dicHouseInfo objectForKey:@"t_houseinfo_houseinfo_id"] forKey:@"houseinfoid"];
    
    [RentHouseService rentHouse:recordMutDic andSuccess:^(NSDictionary *dic) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Prompt" message:@"已完成重新出租！" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"confirm" style:UIAlertActionStyleDefault handler:nil];
        
        [alert addAction:action];
        
        [self presentViewController:alert animated:YES completion:nil];
    }];
    
    

}

- (void)editBtnClick:(UIButton *)sender{
    
    UITableViewCell *cell = (UITableViewCell *)[[sender superview] superview];
    
    NSIndexPath *path = [self.manageTable indexPathForCell:cell];
    
    NSDictionary *dicHouseInfo = _recordArr[path.row];
    
    RentingHouseViewController *rtvc = [[RentingHouseViewController alloc]init];
    
    rtvc.recordDic = dicHouseInfo;
    
    [self.navigationController pushViewController:rtvc animated:YES];
    
    
}

@end
