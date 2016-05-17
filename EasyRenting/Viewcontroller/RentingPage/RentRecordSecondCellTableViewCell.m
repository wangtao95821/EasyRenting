//
//  RentRecordSecondCellTableViewCell.m
//  EasyRenting
//
//  Created by administrator on 16/4/23.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "RentRecordSecondCellTableViewCell.h"
#import "Define.h"
@implementation RentRecordSecondCellTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.manageImageView = [[UIImageView alloc]init];
        
        [self.contentView addSubview:self.manageImageView];
        
        self.manageDescriptionLabel = [[UILabel alloc]init];
        
        [self.contentView addSubview:self.manageDescriptionLabel];
        
        self.manageAdressLabel = [[UILabel alloc]init];
        
        [self.contentView addSubview:self.manageAdressLabel];
        
        self.manageApartmentLabel = [[UILabel alloc]init];
        
        [self.contentView addSubview:self.manageApartmentLabel];
        
        self.managePriceLabel = [[UILabel alloc]init];
        
        [self.contentView addSubview:self.managePriceLabel];
        
        self.lineLabel = [[UILabel alloc]init];
        
        [self.contentView addSubview:self.lineLabel];
       
    }
    
    return self;
}

- (void)layoutSubviews{
    
    self.manageImageView.frame = CGRectMake(15, HEIGHT5S(15), WIDTH5S(107), HEIGHT5S(80));
    
    self.manageImageView.layer.cornerRadius = 5;
    
    self.manageDescriptionLabel.frame = CGRectMake(132, HEIGHT5S(15), WIDTH5S(173), HEIGHT5S(40));
    
    self.manageDescriptionLabel.font = FONT(15);
    
    self.manageDescriptionLabel.numberOfLines = 0;
    
    self.manageAdressLabel.frame = CGRectMake(132, HEIGHT5S(55), WIDTH5S(117), HEIGHT5S(18));
    
    self.manageAdressLabel.font = FONT(12);
    
    self.manageAdressLabel.textColor = SMALLWORD;
    
    self.manageApartmentLabel.frame = CGRectMake(132, HEIGHT5S(77), WIDTH5S(67), HEIGHT5S(18));
    
    self.manageApartmentLabel.font = FONT(12);
    
    self.manageApartmentLabel.textColor = SMALLWORD;
    
    self.managePriceLabel.frame = CGRectMake(228, HEIGHT5S(77), WIDTH5S(67), HEIGHT5S(18));
    
    self.managePriceLabel.font = FONT(12);
    
    self.managePriceLabel.textColor = COLOR(225, 62, 44, 1);

    
    self.lineLabel.frame = CGRectMake(15, HEIGHT5S(120)-1, WIDTH5S(305), 1);
    
    self.lineLabel.backgroundColor = LINECOLOR;

}

@end
