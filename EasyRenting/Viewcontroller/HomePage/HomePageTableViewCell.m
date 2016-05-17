//
//  HomePageTableViewCell.m
//  EasyRenting
//
//  Created by administrator on 16/3/28.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "HomePageTableViewCell.h"
#import "Define.h"

@implementation HomePageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.houseImage = [[UIImageView alloc]init];
        
        [self.contentView addSubview:self.houseImage];
        
        self.houseNamelabel = [[UILabel alloc]init];
        
        self.houseNamelabel.font = [UIFont systemFontOfSize:15];
        
        self.houseNamelabel.textColor =COLOR(51, 51, 51, 1);
        
        [self.contentView addSubview:self.houseNamelabel];
        
        self.houseAddresslabel = [[UILabel alloc]init];
        
        self.houseAddresslabel.font = [UIFont systemFontOfSize:13];
        
        self.houseAddresslabel.textColor =COLOR(153, 153, 153, 1);
        
        [self.contentView addSubview:self.houseAddresslabel];
        
        self.houseRentlabel = [[UILabel alloc]init];
        
        self.houseRentlabel.font = [UIFont systemFontOfSize:15];
        
        self.houseRentlabel.textAlignment = NSTextAlignmentRight;
        
        self.houseRentlabel.textColor =COLOR(225, 62, 1, 1);
        
        [self.contentView addSubview:self.houseRentlabel];
        
        self.houseApartmentlabel = [[UILabel alloc]init];
        
        self.houseApartmentlabel.font = [UIFont systemFontOfSize:13];
        
        self.houseApartmentlabel.textColor =COLOR(153, 153, 153, 1);
        
        [self.contentView addSubview:self.houseApartmentlabel];
        
        self.houseStylelabel = [[UILabel alloc]init];
        
        self.houseStylelabel.font = [UIFont systemFontOfSize:15];
        
        self.houseStylelabel.textColor =COLOR(114, 175, 0, 1);
        
        [self.contentView addSubview:self.houseStylelabel];
        
        self.linelabel = [[UILabel alloc]init];
        
        self.linelabel.backgroundColor = COLOR(223, 223, 223, 1);
        
        [self.contentView addSubview:self.linelabel];
        
        
    }
    
    return self;
}

- (void)layoutSubviews{
    
    self.houseImage.frame = CGRectMake(WIDTH5S(15), WIDTH5S(15), WIDTH5S(120), WIDTH5S(90));
    
    self.houseNamelabel.frame = CGRectMake(WIDTH5S(150), WIDTH5S(15), WIDTH5S(155), HEIGHT5S(20));
    
    self.houseAddresslabel.frame = CGRectMake(WIDTH5S(150), WIDTH5S(40), WIDTH5S(80), HEIGHT5S(20));
    
    self.houseRentlabel.frame = CGRectMake(WIDTH5S(230), WIDTH5S(40), WIDTH5S(75), HEIGHT5S(20));
    
    self.houseApartmentlabel.frame = CGRectMake(WIDTH5S(150), WIDTH5S(65), WIDTH5S(155), HEIGHT5S(20));
    
    self.houseStylelabel.frame = CGRectMake(WIDTH5S(150), WIDTH5S(90), WIDTH5S(155), HEIGHT5S(20));
    
    self.linelabel.frame = CGRectMake(WIDTH5S(15), WIDTH5S(120)-1, WIDTH5S(305), 1);
    
}
@end
