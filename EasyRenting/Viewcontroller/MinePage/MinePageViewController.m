//
//  MinePageViewController.m
//  EasyRenting
//
//  Created by administrator on 16/3/28.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "MinePageViewController.h"
#import "Define.h"
#import "TailorPic.h"
#import "MinePageCellTableViewCell.h"
#import "MyNesPageViewController.h"
#import "CollectPageViewController.h"
#import "MakeAppointmentViewController.h"
#import "LoginPageViewController.h"
#import "RegisterPageViewController.h"
#import "FavoritesService.h"
@interface MinePageViewController ()

@property (copy, nonatomic) NSString *code;

@end

@implementation MinePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    self.navigationController.navigationBar.hidden = YES;

    [self tailorPic];
    
    self.isxiaoshi = YES;
    
    [self createPhoto];

}

//裁剪图片创建table和headBC
- (void)tailorPic{
    //裁剪图片
//    UIImage *image =  [TailorPic handleImage:[UIImage imageNamed:@"mine.jpg"] withSize:CGSizeMake(WIDTH5S(320), HEIGHT5S(180))];
    
    //table
    self.mineTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH5S(320), HEIGHT5S(568)) style:UITableViewStyleGrouped];
    
    self.mineTableView.dataSource = self;
    self.mineTableView.delegate = self;
    
    self.mineTableView.backgroundColor = COLOR(241, 241, 241, 1);
    
    self.mineTableView.tableFooterView = [[UIView alloc]init];
    
    self.mineTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.mineTableView.contentInset = UIEdgeInsetsMake(HEIGHT5S(180), 0, 0, 0);
    
    [self.view addSubview:self.mineTableView];
    
    //head背景
    self.mineHeadBCEFFECTImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH5S(320), HEIGHT5S(180))];

    self.mineHeadBCEFFECTImageView.userInteractionEnabled = YES;
    [self.mineTableView addSubview: self.mineHeadBCEFFECTImageView];
    
    self.mineHeadBCEFFECTImageView.contentMode = UIViewContentModeScaleAspectFill;

    //从沙盒获取图片
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"avatar.png"];
    
    UIImage *savedImage = [[UIImage alloc]initWithContentsOfFile:fullPath];
    
    if (savedImage == nil) {
        
        self.mineHeadBCEFFECTImageView.image = [UIImage imageNamed:@"头像.jpg"];
        
    }else{
    
        [self.mineHeadBCEFFECTImageView setImage:savedImage];

    }
    
    self.mineHeadBCEFFECTImageView.image = [TailorPic handleImage:_mineHeadBCEFFECTImageView.image withSize:CGSizeMake(WIDTH5S(320), HEIGHT5S(180))];

//    self.mineHeadBCEFFECTImageView.image = image;

    //  创建需要的毛玻璃特效类型
    
    self.blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    //  毛玻璃view 视图
    
    self.effectView = [[UIVisualEffectView alloc] initWithEffect:_blurEffect];
    
    //添加到要有毛玻璃特效的控件中
    
        self.effectView.frame = self.mineHeadBCEFFECTImageView.bounds;
    
    [self.mineHeadBCEFFECTImageView addSubview:_effectView];
    
    //设置模糊透明度
    
    _effectView.alpha = .5f;
    
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mineHeadBCEFFECTImageViewClick)];

    [self.mineHeadBCEFFECTImageView addGestureRecognizer:tapGR];
    

    
    //头像
    self.mineHeadImageView = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH5S(132), HEIGHT5S(41), WIDTH5S(60), WIDTH5S(60))];
    
    self.mineHeadImageView.layer.cornerRadius = 30;
    
    self.mineHeadImageView.layer.masksToBounds = YES;
    
    self.mineHeadImageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *headTapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mineHeadImageViewClick)];
    
    [self.mineHeadImageView addGestureRecognizer:headTapGR];
    
    [self.mineHeadBCEFFECTImageView addSubview:self.mineHeadImageView];
    
    //登录注册
    self.mineLoginBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(113), HEIGHT5S(115), WIDTH5S(32), HEIGHT5S(22))];
    
    [self.mineLoginBtn setTitle:@"登录" forState:UIControlStateNormal];
    
    [self.mineLoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.mineLoginBtn addTarget:self action:@selector(mineLoginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.mineLoginBtn.titleLabel.font = FONT(15);
    
    [self.mineHeadBCEFFECTImageView addSubview:self.mineLoginBtn];
    
    
    self.mineRegisterBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(170), HEIGHT5S(115), WIDTH5S(32), HEIGHT5S(22))];
    
    [self.mineRegisterBtn setTitle:@"注册" forState:UIControlStateNormal];
    
    [self.mineRegisterBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.mineRegisterBtn addTarget:self action:@selector(mineRegisterBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.mineRegisterBtn.titleLabel.font = FONT(15);
    
    [self.mineHeadBCEFFECTImageView addSubview:self.mineRegisterBtn];
    
    
    self.mineLineLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH5S(157), HEIGHT5S(117), 1, HEIGHT5S(16))];
    
    self.mineLineLabel.backgroundColor = COLOR(222, 222, 222, 222);
    
    [self.mineHeadBCEFFECTImageView addSubview:self.mineLineLabel];
    
    
    self.exitBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, HEIGHT5S(260), WIDTH5S(290), HEIGHT5S(40))];
    
    [self.exitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    
    self.exitBtn.backgroundColor = COLOR(225, 62, 1, 1);
    
    self.exitBtn.titleLabel.font = FONT(15);
    
    self.exitBtn.hidden = YES;
    
    self.exitBtn.layer.cornerRadius = 5;
    
    [self.exitBtn setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    
    [self.exitBtn addTarget:self action:@selector(exitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.mineTableView addSubview:self.exitBtn];
    
    
    
    //登录成功显示名字
    self.loginNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH5S(110), HEIGHT5S(115), WIDTH5S(100), HEIGHT5S(22))];
    
    self.loginNameLabel.hidden = YES;
    
    self.loginNameLabel.textColor = [UIColor purpleColor];
    
    self.loginNameLabel.font = FONT(15);
    
    self.loginNameLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.mineHeadBCEFFECTImageView addSubview:self.loginNameLabel];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *dicUserDefaults = [userDefaults objectForKey:@"personInfo"];
    
//    NSLog(@"login-------------%@",dicUserDefaults);
    
    self.code = [dicUserDefaults objectForKey:@"code"];
    
    if ([_code isEqual:@200]) {
        
        self.exitBtn.hidden = NO;
        
        self.mineLoginBtn.hidden = YES;
        
        self.mineRegisterBtn.hidden = YES;
        
        self.mineLineLabel.hidden = YES;
        
        self.loginNameLabel.hidden = NO;
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSArray *arrUserDefaults = [dicUserDefaults objectForKey:@"result"];
            
            NSDictionary *dic1UserDefaults = arrUserDefaults[0];
            
            self.imaStr = [dic1UserDefaults objectForKey:@"user_headImage"];
            
            self.loginNameLabel.text = [dic1UserDefaults objectForKey:@"user_name"];
            
            self.str5 = [NSString stringWithFormat:@"http://115.159.215.30/Tupian/image/%@",_imaStr];
    
            dispatch_async(dispatch_get_main_queue(), ^{
   
                
                    self.imageMyNes = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_str5]]];
            
                self.mineHeadImageView.image = self.imageMyNes;
            });
        });

    }else{
    
        self.mineHeadImageView.image = [UIImage imageNamed:@"头像.jpg"];
        
        self.exitBtn.hidden = YES;
        
        self.loginNameLabel.hidden = YES;
    }
    
    
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
//    NSLog(@"%lf",offsetY);
    CGFloat offsetH = HEIGHT5S(180) + offsetY;
    if (offsetH < 0) {
        
        CGRect frame = self.mineHeadBCEFFECTImageView.frame;
        frame.size.height = HEIGHT5S(180) - offsetH;
        frame.origin.y = -HEIGHT5S(180) + offsetH;
                
        self.mineHeadBCEFFECTImageView.frame = frame;
        
        self.effectView.frame = self.mineHeadBCEFFECTImageView.bounds;
            
    }else{
    
        self.effectView.frame = self.mineHeadBCEFFECTImageView.bounds;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 43;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 30;
        
    }else{
    
        return 0.8;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    MinePageCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mine"];
    
    if (cell == nil) {
        
        cell = [[MinePageCellTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mine"];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.section == 0) {
        
        cell.cellLabel.text = @"收藏夹";
        
        cell.cellImageView.image = [UIImage imageNamed:@"收藏夹.png"];

    }else if (indexPath.section == 1){
    
        cell.cellLabel.text = @"功能介绍";
        
        cell.cellImageView.image = [UIImage imageNamed:@"约看记录.png"];
        
    }else if (indexPath.section == 2){
        
        cell.cellLabel.text = @"个人设置";
        
        cell.cellImageView.image = [UIImage imageNamed:@"shezhi.png"];
    }
    
    cell.cellArrowsImageView.image = [UIImage imageNamed:@"Arrow_8.5866666666667px_1183511_easyicon.net.png"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MyNesPageViewController *mnvc = [[MyNesPageViewController alloc]init];
    
    CollectPageViewController *cvc = [[CollectPageViewController alloc]init];
    
    MakeAppointmentViewController *mavc= [[MakeAppointmentViewController alloc]init];
    
    if (indexPath.section == 2&&[_code isEqual:@200]) {
        
        mnvc.diccc = _diccc;
        
        mnvc.imageMyNes = _imageMyNes;
        
        [self.navigationController pushViewController:mnvc animated:YES];
        self.tabBarController.hidesBottomBarWhenPushed = YES;
    }
    
    if (indexPath.section == 0) {
        
        [self.navigationController pushViewController:cvc animated:YES];
        self.tabBarController.hidesBottomBarWhenPushed = YES;
    }
    
    if (indexPath.section == 1) {
        
        [self.navigationController pushViewController:mavc animated:YES];
        self.tabBarController.hidesBottomBarWhenPushed = YES;
    }
}


//拍照、从相册选取选择框
- (void)createPhoto{
    
    //弹出框
    
    self.myview = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    self.myview.backgroundColor = [UIColor blackColor];
    
    self.myview.alpha = 0;
    
    [self.view addSubview:self.myview];
    
    self.bkView = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT5S(320+205), WIDTH5S(320), HEIGHT5S(205))];
    
    self.bkView.backgroundColor = [UIColor clearColor];
 
    [self.view addSubview:self.bkView];
    
    
    
    UIButton *button1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, WIDTH5S(320), HEIGHT5S(367))];
    
    button1.backgroundColor = [UIColor clearColor];
    
    [button1 addTarget:self action:@selector(mineHeadBCEFFECTImageViewClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.myview addSubview:button1];
    
    
    UIButton *pBoxBtn2 = [[UIButton alloc]initWithFrame:CGRectMake(0, HEIGHT5S(47), WIDTH5S(320), HEIGHT5S(47))];
    [pBoxBtn2 setTitle:@"拍照" forState:UIControlStateNormal];
    [pBoxBtn2 setTitleColor:COLOR(243, 197, 1, 1) forState:UIControlStateNormal];
    [pBoxBtn2 addTarget:self action:@selector(ChooseCameraFromIPhone) forControlEvents:UIControlEventTouchUpInside];
    
    pBoxBtn2.backgroundColor = [UIColor whiteColor];
    pBoxBtn2.layer.cornerRadius = 5;
    
    UIButton *pBoxBtn3 = [[UIButton alloc]initWithFrame:CGRectMake(0, HEIGHT5S(47*2), WIDTH5S(320), HEIGHT5S(47))];
    [pBoxBtn3 setTitle:@"从手机相册选择" forState:UIControlStateNormal];
    [pBoxBtn3 setTitleColor:COLOR(243, 197, 1, 1) forState:UIControlStateNormal];
    [pBoxBtn3 addTarget:self action:@selector(ChoosePicFromIPhone) forControlEvents:UIControlEventTouchUpInside];
    pBoxBtn3.backgroundColor = [UIColor whiteColor];
    pBoxBtn3.layer.cornerRadius = 5;
    
    UIButton *pBoxBtn4 = [[UIButton alloc]initWithFrame:CGRectMake(0, HEIGHT5S(47*3+6), WIDTH5S(320), HEIGHT5S(47))];
    [pBoxBtn4 setTitle:@"取消" forState:UIControlStateNormal];
    [pBoxBtn4 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    pBoxBtn4.backgroundColor = [UIColor whiteColor];
    pBoxBtn4.layer.cornerRadius = 5;
    [pBoxBtn4 addTarget:self action:@selector(pBox4) forControlEvents:UIControlEventTouchUpInside];
  
    [self.bkView addSubview:pBoxBtn2];
    [self.bkView addSubview:pBoxBtn3];
    [self.bkView addSubview:pBoxBtn4];
}


//相机
- (void)ChooseCameraFromIPhone{
    
    self.ima = [[UIImageView alloc]init];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        
        
        UIImagePickerController *ipc = [[UIImagePickerController alloc]init];
        ipc.delegate = self;
        ipc.allowsEditing = YES;
        
        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:ipc animated:YES completion:nil];

    }else{
        
        NSLog(@"233333");
    }
}


////从手机相册选择图片
- (void)ChoosePicFromIPhone{
    
    self.ima = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH5S(320), HEIGHT5S(180))];

    UIImagePickerController *ipc = [[UIImagePickerController alloc]init];
    ipc.delegate = self;
    ipc.allowsEditing = YES;
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:ipc animated:YES completion:nil];

}

//保存图片至沙盒
- (void)saveImage:(UIImage *)currentimage withName:(NSString *)imageName{
    
    NSData *imaData = UIImageJPEGRepresentation(currentimage, 1);
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    [imaData writeToFile:fullPath atomically:YES];
    
}
//选择图片后自动调用该方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    [self mineHeadBCEFFECTImageViewClick];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self saveImage:image withName:@"avatar.png"];
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"avatar.png"];
    
    UIImage *savedImage = [[UIImage alloc]initWithContentsOfFile:fullPath];
    [_ima setImage:savedImage];
    
    self.mineHeadBCEFFECTImageView.image = [TailorPic handleImage:_ima.image withSize:CGSizeMake(WIDTH5S(320), HEIGHT5S(180))];

}

//房屋照片取消按钮
- (void)pBox4{
    
    self.tabBarController.hidesBottomBarWhenPushed = NO;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect frame = self.bkView.frame;
        
        frame.origin.y += self.bkView.frame.size.height;
        
        self.bkView.frame = frame;
        
        self.myview.alpha = 0;
    }];

        self.isxiaoshi = YES;
}
//点击弹出从相册选取/拍照选择框
- (void)mineHeadBCEFFECTImageViewClick{
    
    if (_isxiaoshi == YES) {
     
        self.tabBarController.hidesBottomBarWhenPushed = YES;
        
        [UIView animateWithDuration:0.3 animations:^{
     
            self.bkView.frame = CGRectMake(0, HEIGHT5S(320+50), WIDTH5S(320), HEIGHT5S(205));
            
            self.myview.alpha = 0.3;
        }];
        
        self.isxiaoshi = NO;
        
    }else if (_isxiaoshi == NO){
 
        self.tabBarController.hidesBottomBarWhenPushed = NO;
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.bkView.frame = CGRectMake(0, HEIGHT5S(320+205), WIDTH5S(320), HEIGHT5S(205));
            
            self.myview.alpha = 0;
        }];

        self.isxiaoshi = YES;

    }
}

- (void)mineLoginBtnClick{

    self.tabBarController.hidesBottomBarWhenPushed = YES;
    
    LoginPageViewController *lvc= [[LoginPageViewController alloc]init];
    
    [self.navigationController pushViewController:lvc animated:YES];
}

- (void)mineRegisterBtnClick{
    
    self.tabBarController.hidesBottomBarWhenPushed = YES;
    
    RegisterPageViewController *rgvc= [[RegisterPageViewController alloc]init];
    
    [self.navigationController pushViewController:rgvc animated:YES];
}

- (void)exitBtnClick{

    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"personInfo"];
    
    self.mineLineLabel.hidden = NO;
    self.mineLoginBtn.hidden = NO;
    self.mineRegisterBtn.hidden = NO;
    
    self.exitBtn.hidden = YES;
    
    self.loginNameLabel.hidden = YES;
    
    self.mineHeadImageView.image = [UIImage imageNamed:@"头像.jpg"];
    
    [self.mineTableView reloadData];
}

//头像手势--没有作用
- (void)mineHeadImageViewClick{

    
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    self.tabBarController.hidesBottomBarWhenPushed = NO;
}

@end
