//
//  RentingPageUnletCellTableViewCell.h
//  EasyRenting
//
//  Created by administrator on 16/4/19.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RentingPageUnletCellTableViewCell : UITableViewCell

@property (strong, nonatomic) UIImageView *cellImageView;//图片

@property (strong, nonatomic) UILabel *cellDescriptionLabel;//房屋描述Label

@property (strong, nonatomic) UILabel *cellAdressLabel;//房屋地址Label

@property (strong, nonatomic) UILabel *cellApartmentLabel;//房屋类型Label

@property (strong, nonatomic) UILabel *cellPriceLabel;//房屋价格Label

@property (strong, nonatomic) UILabel *cellLineLabel;//线

@end
