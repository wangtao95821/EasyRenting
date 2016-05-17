//
//  CollectCellTableViewCell.m
//  EasyRenting
//
//  Created by administrator on 16/4/5.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "CollectCellTableViewCell.h"
#import "Define.h"
@implementation CollectCellTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.collectHouseImage = [[UIImageView alloc]init];
        
        [self.contentView addSubview:self.collectHouseImage];
        
        self.collectHouseNamelabel = [[UILabel alloc]init];
        
        self.collectHouseNamelabel.font = [UIFont systemFontOfSize:15];
        
        self.collectHouseNamelabel.textColor =COLOR(51, 51, 51, 1);
        
        [self.contentView addSubview:self.collectHouseNamelabel];
        
        self.collectHouseAddresslabel = [[UILabel alloc]init];
        
        self.collectHouseAddresslabel.font = [UIFont systemFontOfSize:13];
        
        self.collectHouseAddresslabel.textColor =COLOR(153, 153, 153, 1);
        
        [self.contentView addSubview:self.collectHouseAddresslabel];
        
        self.collectHouseRentlabel = [[UILabel alloc]init];
        
        self.collectHouseRentlabel.font = [UIFont systemFontOfSize:15];
        
        self.collectHouseRentlabel.textColor =COLOR(225, 62, 1, 1);
        
        self.collectHouseRentlabel.textAlignment = NSTextAlignmentRight;
        
        [self.contentView addSubview:self.collectHouseRentlabel];
        
        self.collectHouseApartmentlabel = [[UILabel alloc]init];
        
        self.collectHouseApartmentlabel.font = [UIFont systemFontOfSize:13];
        
        self.collectHouseApartmentlabel.textColor =COLOR(153, 153, 153, 1);
        
        [self.contentView addSubview:self.collectHouseApartmentlabel];
        
        self.collectHouseStylelabel = [[UILabel alloc]init];
        
        self.collectHouseStylelabel.font = [UIFont systemFontOfSize:15];
        
        self.collectHouseStylelabel.textColor =COLOR(114, 175, 0, 1);
        
        [self.contentView addSubview:self.collectHouseStylelabel];
        
        self.collectLinelabel = [[UILabel alloc]init];
        
        self.collectLinelabel.backgroundColor = COLOR(223, 223, 223, 1);
        
        [self.contentView addSubview:self.collectLinelabel];
    }
    
    return self;
}

- (void)layoutSubviews{
    
    self.collectHouseImage.frame = CGRectMake(WIDTH5S(15), WIDTH5S(15), WIDTH5S(120), WIDTH5S(90));
    
    self.collectHouseNamelabel.frame = CGRectMake(WIDTH5S(150), WIDTH5S(15), WIDTH5S(155), HEIGHT5S(20));
    
    self.collectHouseAddresslabel.frame = CGRectMake(WIDTH5S(150), WIDTH5S(40), WIDTH5S(80), HEIGHT5S(20));
    
    self.collectHouseRentlabel.frame = CGRectMake(WIDTH5S(230), WIDTH5S(40), WIDTH5S(75), HEIGHT5S(20));
    
    self.collectHouseApartmentlabel.frame = CGRectMake(WIDTH5S(150), WIDTH5S(65), WIDTH5S(155), HEIGHT5S(20));
    
    self.collectHouseStylelabel.frame = CGRectMake(WIDTH5S(150), WIDTH5S(90), WIDTH5S(155), HEIGHT5S(20));
    
    self.collectLinelabel.frame = CGRectMake(WIDTH5S(15), WIDTH5S(120)-1, WIDTH5S(305), 1);
    
}


@end
