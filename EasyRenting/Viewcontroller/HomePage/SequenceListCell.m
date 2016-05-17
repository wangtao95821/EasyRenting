//
//  SequenceListCell.m
//  EasyRenting
//
//  Created by administrator on 16/3/29.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "SequenceListCell.h"
#import "Define.h"
@implementation SequenceListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.contentLabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.contentLabel];
        
        self.lineLabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.lineLabel];
        
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.contentLabel.frame = CGRectMake(WIDTH5S(80), HEIGHT5S(11), WIDTH5S(160), HEIGHT5S(20));
    self.contentLabel.textAlignment = NSTextAlignmentCenter;
    self.contentLabel.font = [UIFont systemFontOfSize:12];
    self.contentLabel.textColor = [UIColor blackColor];
    
    self.lineLabel.frame = CGRectMake(15, WIDTH5S(44)-1, SCREEN_WIDTH-15, 1);
    self.lineLabel.layer.borderWidth = 1;
    self.lineLabel.layer.borderColor = COLOR(223, 223, 223, 1).CGColor;
    
    
}

@end
