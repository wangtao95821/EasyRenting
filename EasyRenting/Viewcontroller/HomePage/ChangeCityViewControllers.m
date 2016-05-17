//
//  ChangeCityViewController.m
//  jmportal_iphone_grid
//
//  Created by yaojun on 14-5-28.
//
//

#import "ChangeCityViewControllers.h"
#import "Define.h"
#import "SelectCityService.h"
#import "MBProgressHUD.h"
#pragma mark- 常规宏定义
#define WIDTH_SCREEN    [UIScreen mainScreen].bounds.size.width   //屏幕宽度
#define HEIGHT_SCREEN   [UIScreen mainScreen].bounds.size.height  //屏幕高度



//获取RGB颜色
#define RGBAA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#define RGB(r,g,b) RGBAA(r,g,b,1.0f)


@interface ChangeCityViewControllers ()

@property (strong, nonatomic)UIView *NavigationView;
@property (strong, nonatomic)UILabel *titleLabel;

@property (strong, nonatomic) MBProgressHUD *hud;

@end

@implementation ChangeCityViewControllers
@synthesize citydataSource;
@synthesize contactTableView;
@synthesize delegate;
@synthesize cityArray;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.tabBarController.hidesBottomBarWhenPushed = YES;
    
    self.hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    //自定义的顶部导航
    self.NavigationView  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    
    self.NavigationView.backgroundColor = NAVIGATIONCOLOR;
    
    [self.view addSubview:self.NavigationView];
    
    //导航栏上的返回键
    //导航栏上的返回键
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 60, 44)];
    
    //    [backBtn setBackgroundImage:[UIImage imageNamed:@"back_select@2x"] forState:UIControlStateNormal];
    
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    [self.NavigationView addSubview:backBtn];
    
    UIImageView *backIma = [[UIImageView alloc]initWithFrame:CGRectMake(2, 10, 25, 25)];
    backIma.image = [UIImage imageNamed:@"back_select@2x"];
    [backBtn addSubview:backIma];

    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 20, 120, 44)];
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    
    self.titleLabel.text = @"选择城市";
    
    self.titleLabel.textColor = COLOR(255, 253, 193, 1);
    
    [self.NavigationView addSubview:self.titleLabel];

    [self createTableView];
    
    self.cityArray = [NSMutableArray arrayWithCapacity:0];
    [SelectCityService selectCity:^(NSArray *arr) {
        
        [self.cityArray setArray:arr];
        
        [self.hud hideAnimated:YES];
       
        [contactTableView reloadData];
    }];
    
}

-(void)createTableView
{
    contactTableView = [[BATableView alloc] initWithFrame:CGRectMake(0,64, WIDTH_SCREEN, HEIGHT_SCREEN-64)];
    contactTableView.delegate = self;
    [self.view addSubview:self.contactTableView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)backToHomeViewController
//{
//    [self.navigationController popViewControllerAnimated:YES];
//}

#pragma mark - UITableViewDataSource
- (NSArray *) sectionIndexTitlesForABELTableView:(BATableView *)tableView {
    NSMutableArray * indexTitles = [NSMutableArray array];
    for (NSDictionary * sectionDictionary in self.cityArray) {
        [indexTitles addObject:sectionDictionary[@"province"]];
    }
    return indexTitles;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return self.cityArray.count;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = [self.cityArray[section]objectForKey:@"city"];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * cellName = @"UITableViewCell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    cell.textLabel.text = [[self.cityArray[indexPath.section]objectForKey:@"city"][indexPath.row]objectForKey:@"city"];
   
    cell.textLabel.font = FONT(15);
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView  *titleView=[[UIView  alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    titleView.backgroundColor=RGBAA(244, 244, 244, 1);
    UILabel *titleLable=[[UILabel    alloc]initWithFrame:CGRectMake(10, 5, 100, 20)];
    titleLable.text=self.cityArray[section][@"province"];
    titleLable.textColor=RGBAA(245, 198, 0, 1);
    titleLable.font=FONT(17);
    
    [titleView addSubview:titleLable];
    
    return titleView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_cityDelegate != nil && [_cityDelegate respondsToSelector:@selector(showCityName:)]) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[self.cityArray[indexPath.section]objectForKey:@"city"][indexPath.row]];
        [dic setObject:self.cityArray[indexPath.section][@"province"] forKey:@"province"];
        [_cityDelegate showCityName:dic];
        [self.navigationController popViewControllerAnimated:YES];
        self.tabBarController.hidesBottomBarWhenPushed = NO;

    }
    if (_houseDelegate != nil && [_houseDelegate respondsToSelector:@selector(houseCityName:)]) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[self.cityArray[indexPath.section]objectForKey:@"city"][indexPath.row]];
        [dic setObject:self.cityArray[indexPath.section][@"province"] forKey:@"province"];
        [_houseDelegate houseCityName:dic];
        [self.navigationController popViewControllerAnimated:YES];
        self.tabBarController.hidesBottomBarWhenPushed = NO;
        
    }
    

}

- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
     self.tabBarController.hidesBottomBarWhenPushed = NO;
}

@end
