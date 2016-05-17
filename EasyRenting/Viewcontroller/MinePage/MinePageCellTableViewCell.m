//
//  MinePageCellTableViewCell.m
//  EasyRenting
//
//  Created by administrator on 16/3/31.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "MinePageCellTableViewCell.h"
#import "Define.h"
@implementation MinePageCellTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.cellLabel = [[UILabel alloc]init];
        
        [self.contentView addSubview:self.cellLabel];
        
        self.cellImageView = [[UIImageView alloc]init];
        
        [self.contentView addSubview:self.cellImageView];
        
        self.cellArrowsImageView = [[UIImageView alloc]init];
        
        [self.contentView addSubview:self.cellArrowsImageView];
    }
    
    return self;
}

- (void)layoutSubviews{

    self.cellLabel.frame = CGRectMake(WIDTH5S(65), HEIGHT5S(12), WIDTH5S(100), HEIGHT5S(21));
    
    self.cellLabel.textColor = SMALLWORD;
    
    self.cellLabel.font = FONT(14);
    
    self.cellImageView.frame = CGRectMake(WIDTH5S(20), HEIGHT5S(8), WIDTH5S(25), WIDTH5S(25));
    
    self.cellArrowsImageView.frame = CGRectMake(WIDTH5S(280), HEIGHT5S(15), WIDTH5S(10), WIDTH5S(18));
}

@end
