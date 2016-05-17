//
//  RentingPageUnletCellTableViewCell.m
//  EasyRenting
//
//  Created by administrator on 16/4/19.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "RentingPageUnletCellTableViewCell.h"
#import "Define.h"
@implementation RentingPageUnletCellTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.cellImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:self.cellImageView];
        
        self.cellDescriptionLabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.cellDescriptionLabel];
        
        self.cellAdressLabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.cellAdressLabel];
        
        self.cellApartmentLabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.cellApartmentLabel];
        
        self.cellPriceLabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.cellPriceLabel];
        
        self.cellLineLabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.cellLineLabel];
        
    }
    
    return self;
}

- (void)layoutSubviews{
    
    self.cellImageView.frame = CGRectMake(WIDTH5S(15), HEIGHT5S(15), WIDTH5S(107), HEIGHT5S(90));
    
    self.cellDescriptionLabel.frame = CGRectMake(WIDTH5S(132), HEIGHT5S(15), WIDTH5S(173), HEIGHT5S(40));
    
    self.cellDescriptionLabel.numberOfLines = 0;
    
    self.cellDescriptionLabel.font = [UIFont systemFontOfSize:15];
    
    self.cellAdressLabel.frame = CGRectMake(WIDTH5S(132), HEIGHT5S(60), WIDTH5S(127), HEIGHT5S(18));
    
    self.cellAdressLabel.textColor = COLOR(153, 153, 153, 1);
    
    self.cellAdressLabel.font = [UIFont systemFontOfSize:13];
    
    self.cellApartmentLabel.frame = CGRectMake(WIDTH5S(132), HEIGHT5S(85), WIDTH5S(77), HEIGHT5S(18));
    
    self.cellApartmentLabel.textColor = COLOR(153, 153, 153, 1);
    
    self.cellApartmentLabel.font = [UIFont systemFontOfSize:13];
    
    self.cellPriceLabel.frame = CGRectMake(WIDTH5S(230), HEIGHT5S(85), WIDTH5S(70), HEIGHT5S(18));
    
    self.cellPriceLabel.textColor = COLOR(225, 62, 1, 1);
    
    self.cellPriceLabel.font = [UIFont systemFontOfSize:13];
    
    self.cellLineLabel.frame = CGRectMake(WIDTH5S(15), HEIGHT5S(120)-1, WIDTH5S(305), 1);
    
    self.cellLineLabel.backgroundColor = COLOR(223, 223, 223, 1);

}

@end
