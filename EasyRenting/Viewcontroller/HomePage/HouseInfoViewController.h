//
//  HouseInfoViewController.h
//  EasyRenting
//
//  Created by administrator on 16/3/29.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FetchPicService.h"
@interface HouseInfoViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (assign, nonatomic) BOOL isOnePage;


@property (strong, nonatomic)NSDictionary *houseinfoDic;

@end
