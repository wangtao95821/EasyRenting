//
//  MyNesCellTableViewCell.m
//  EasyRenting
//
//  Created by administrator on 16/4/5.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "MyNesCellTableViewCell.h"
#import "Define.h"
@implementation MyNesCellTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.cellHeadImage = [[UIImageView alloc]init];
        
        [self.contentView addSubview:self.cellHeadImage];
        
        self.cellLabel = [[UILabel alloc]init];
        
        [self.contentView addSubview:self.cellLabel];
        
        self.cellLabel1 = [[UILabel alloc]init];
        
        [self.contentView addSubview:self.cellLabel1];
        
        self.cellLineLabel = [[UILabel alloc]init];
        
        [self.contentView addSubview:self.cellLineLabel];
        
        self.cellLabel2 = [[UILabel alloc]init];
        
        [self.contentView addSubview:self.cellLabel2];
    }
    
    return self;
}

- (void)layoutSubviews{

    self.cellHeadImage.frame = CGRectMake(SCREEN_WIDTH-15-WIDTH5S(64), HEIGHT5S(10), WIDTH5S(64), WIDTH5S(64));
    
    self.cellHeadImage.layer.cornerRadius = 32;
    
    self.cellHeadImage.layer.masksToBounds = YES;
    
    self.cellLabel.frame = CGRectMake(15, HEIGHT5S(32), WIDTH5S(60), HEIGHT5S(21));
    
    self.cellLabel.font = FONT(15);
    
    self.cellLabel.textColor = COLOR(111, 111, 111, 1);
    
    self.cellLabel1.frame = CGRectMake(15, HEIGHT5S(12), WIDTH5S(60), HEIGHT5S(21));
    
    self.cellLabel1.font = FONT(15);
    
    self.cellLabel1.textColor = COLOR(111, 111, 111, 1);
    
    self.cellLabel2.frame = CGRectMake(100, HEIGHT5S(12), WIDTH5S(210), HEIGHT5S(21));
    
    self.cellLabel2.font = FONT(15);
    
    self.cellLabel2.textAlignment = NSTextAlignmentRight;
    
    self.cellLabel2.textColor = COLOR(111, 111, 111, 1);
    
    self.cellLineLabel.frame = CGRectMake(15, HEIGHT5S(45), WIDTH5S(305), 1);
    
    self.cellLineLabel.backgroundColor = COLOR(223, 223, 223, 1);

}

@end
