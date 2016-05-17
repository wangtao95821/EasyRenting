//
//  RentRecordCellTableViewCell.m
//  EasyRenting
//
//  Created by administrator on 16/4/11.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "RentRecordCellTableViewCell.h"
#import "Define.h"
@implementation RentRecordCellTableViewCell

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
        
        self.manageBtn = [[UIButton alloc]init];
        
        [self.contentView addSubview:self.manageBtn];
        
        self.lineLabel = [[UILabel alloc]init];
        
        [self.contentView addSubview:self.lineLabel];
        
        self.editBtn = [[UIButton alloc]init];
        
        [self.contentView addSubview:self.editBtn];
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
    
    self.manageBtn.frame = CGRectMake(250, HEIGHT5S(119), WIDTH5S(60), HEIGHT5S(25));
    
    [self.manageBtn setTitle:@"重新出租" forState:UIControlStateNormal];
    
    self.manageBtn.backgroundColor = COLOR(244, 244, 244, 1);
    
    self.manageBtn.titleLabel.font = FONT(12);
    
    self.manageBtn.layer.cornerRadius = 5;
    
    self.manageBtn.layer.borderWidth = 0.5;
    
    [self.manageBtn setTitleColor:COLOR(50, 100, 1, 1) forState:UIControlStateHighlighted];
    
    self.manageBtn.layer.borderColor = COLOR(223, 223, 223, 1).CGColor;
    
    [self.manageBtn setTitleColor:COLOR(243, 197, 1, 1) forState:UIControlStateNormal];
    
    self.lineLabel.frame = CGRectMake(15, HEIGHT5S(150)-1, WIDTH5S(305), 1);
    
    self.lineLabel.backgroundColor = LINECOLOR;
    
    
    self.editBtn.frame = CGRectMake(10, HEIGHT5S(119), WIDTH5S(60), HEIGHT5S(25));
    
    [self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    
    self.editBtn.backgroundColor = COLOR(244, 244, 244, 1);
    
    self.editBtn.titleLabel.font = FONT(12);
    
    self.editBtn.layer.cornerRadius = 5;
    
    self.editBtn.layer.borderWidth = 0.5;
    
    [self.editBtn setTitleColor:COLOR(50, 100, 1, 1) forState:UIControlStateHighlighted];
    
    self.editBtn.layer.borderColor = COLOR(223, 223, 223, 1).CGColor;
    
    [self.editBtn setTitleColor:COLOR(243, 197, 1, 1) forState:UIControlStateNormal];
}

@end
