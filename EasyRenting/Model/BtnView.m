
#import "BtnView.h"
#import "Define.h"
@implementation BtnView

+(UIView *)creatBtn{
    
    UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(22, HEIGHT5S(942+10+100), WIDTH5S(278), HEIGHT5S(134+72))];
    
    view1.backgroundColor = [UIColor clearColor];
    
    NSArray *titleArr = @[@"电视机",@"电冰箱",@"洗衣机",@"宽带",@"桌子",@"空调",@"热水器",@"阳台",@"床",@"衣柜",@"卫生间"];
    
    NSArray *btnViewArrX = @[@"0",@"72",@"144",@"216",@"0",@"72",@"144",@"216",@"0",@"72",@"144"];
    NSArray *btnViewArrY = @[@"0",@"0",@"0",@"0",@"72",@"72",@"72",@"72",@"144",@"144",@"144"];
    
    //创建button
    for (int i = 0; i < titleArr.count; i++) {
        
        NSString *strVX = btnViewArrX[i];
        NSString *strVY = btnViewArrY[i];
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(strVX.intValue, strVY.intValue, 62, 62)];
        
        button.tag = 4000 + i;
        
        [button setBackgroundColor:[UIColor whiteColor]];
        
        [view1 addSubview:button];
        
        UILabel *btnLabel = [[UILabel alloc]initWithFrame:CGRectMake(11, 42, 40, 18)];
        
        btnLabel.text = titleArr[i];
        
        btnLabel.textColor = COLOR(153, 153, 153, 1);
        
        btnLabel.font = [UIFont systemFontOfSize:11];
        
        btnLabel.textAlignment = NSTextAlignmentCenter;
        
        [button addSubview:btnLabel];
        
        UIImageView *btnImageView = [[UIImageView alloc]initWithFrame:CGRectMake(16, 8, 30, 30)];
        
        btnImageView.image = [UIImage imageNamed:@"150818kongtiao-_you@3x.png"];
        
        [button addSubview:btnImageView];
        
    }
    
    return view1;
}
@end