//
//  SearchPageCell.m
//  EasyRenting
//
//  Created by administrator on 16/3/28.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "SearchPageCell.h"
#import "Define.h"
@implementation SearchPageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        //房子图片
        self.houseImage = [[UIImageView alloc]init];
        [self.contentView addSubview:self.houseImage];
        //房子名字
        self.houseNameLabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.houseNameLabel];
        //房子地址
        self.houseAddressLabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.houseAddressLabel];
        //房子户型
        self.houseApartmentLabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.houseApartmentLabel];
        //房子租金
        self.houseRentLabel = [[UILabel alloc]init];
        self.houseRentLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.houseRentLabel];
        //房子租赁形式
        self.houseStyleLabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.houseStyleLabel];
        //分割线
        self.lineLabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.lineLabel];
        
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.houseImage.frame = CGRectMake(WIDTH5S(15), HEIGHT5S(15), WIDTH5S(120), HEIGHT5S(90));
    
    self.houseNameLabel.frame = CGRectMake(WIDTH5S(150), HEIGHT5S(15), WIDTH5S(133), HEIGHT5S(20));
    self.houseNameLabel.font = [UIFont systemFontOfSize:15];
    self.houseNameLabel.textColor = [UIColor blackColor];
    
    self.houseAddressLabel.frame = CGRectMake(WIDTH5S(150), HEIGHT5S(40), WIDTH5S(62), HEIGHT5S(20));
    self.houseAddressLabel.font = [UIFont systemFontOfSize:13];
    self.houseAddressLabel.textColor = COLOR(153, 153, 153, 1);
    
    self.houseRentLabel.frame = CGRectMake(WIDTH5S(230), HEIGHT5S(40), WIDTH5S(75), HEIGHT5S(20));
    self.houseRentLabel.font = [UIFont systemFontOfSize:15];
    self.houseRentLabel.textColor = COLOR(225, 62, 1, 1);
 
    self.houseApartmentLabel.frame = CGRectMake(WIDTH5S(150), HEIGHT5S(65), WIDTH5S(133), HEIGHT5S(20));
    self.houseApartmentLabel.font = [UIFont systemFontOfSize:13];
    self.houseApartmentLabel.textColor = COLOR(153, 153, 153, 1);
    
    self.houseStyleLabel.frame = CGRectMake(WIDTH5S(150), HEIGHT5S(90), WIDTH5S(133), HEIGHT5S(20));
    self.houseStyleLabel.font = [UIFont systemFontOfSize:15];
    self.houseStyleLabel.textColor = COLOR(114, 175, 0, 1);
    
    self.lineLabel.frame = CGRectMake(15, HEIGHT5S(120)-1, SCREEN_WIDTH-15, 1);
    self.lineLabel.layer.borderWidth = 1;
    self.lineLabel.layer.borderColor = COLOR(223, 223, 223, 1).CGColor;
    
}

@end
