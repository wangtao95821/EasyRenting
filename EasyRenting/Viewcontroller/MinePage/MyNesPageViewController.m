//
//  MyNesPageViewController.m
//  EasyRenting
//
//  Created by administrator on 16/4/5.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "MyNesPageViewController.h"
#import "Define.h"
#import "MyNesCellTableViewCell.h"
#import "FavoritesService.h"
#import "MinePageViewController.h"
#import "MBProgressHUD.h"
@interface MyNesPageViewController ()

@property (copy, nonatomic) NSString *strNameUserDefaults;

@property (copy, nonatomic) NSString *strSexUserDefaults;

@property (copy, nonatomic) NSString *strPasswordUserDefaults;

@property (copy, nonatomic) NSString *strUserIdUserDefaults;

@property (strong, nonatomic) MBProgressHUD *hud;

@end

@implementation MyNesPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.hidden = YES;
    
    UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    
    navView.backgroundColor = NAVIGATIONCOLOR;
    
    [self.view addSubview:navView];
    
    UILabel *navTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 20, 120, 44)];
    
    navTitleLabel.text = @"个人设置";
    
    navTitleLabel.font = FONT(15);
    
    navTitleLabel.textColor = COLOR(255, 253, 193, 1);
    
    navTitleLabel.textAlignment = NSTextAlignmentCenter;
    
    [navView addSubview:navTitleLabel];
    
    //导航栏上的返回键
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 60, 44)];
    
    [backBtn addTarget:self action:@selector(BACK) forControlEvents:UIControlEventTouchUpInside];
    
    [navView addSubview:backBtn];
    
    UIImageView *backIma = [[UIImageView alloc]initWithFrame:CGRectMake(2, 10, 25, 25)];
    backIma.image = [UIImage imageNamed:@"back_select@2x"];
    [backBtn addSubview:backIma];
    
    [self createTable];

    self.isxiaoshi = YES;
    
    [self createPhotos];
    
    //弹出界面
    self.nameView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    self.nameView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.8];

    self.nameView.hidden = YES;
    
    [self.view addSubview:self.nameView];
    
    self.nameTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(15, HEIGHT5S(240), WIDTH5S(290), HEIGHT5S(40))];
    
    self.nameTextFiled.backgroundColor = [UIColor whiteColor];
    
    self.nameTextFiled.layer.cornerRadius = 10;

    self.nameTextFiled.placeholder = @"新的姓名";
    
    self.nameTextFiled.textAlignment = NSTextAlignmentCenter;
    
    self.nameTextFiled.font = FONT(15);
    
    [self.nameView addSubview:self.nameTextFiled];
    
    UIButton *view1Btn1 = [[UIButton alloc]initWithFrame:CGRectMake(15, HEIGHT5S(400), WIDTH5S(290), HEIGHT5S(40))];
    
    view1Btn1.backgroundColor = COLOR(241, 197, 1, 1);
    
    [view1Btn1 setTitle:@"确定" forState:UIControlStateNormal];
    
    [view1Btn1 addTarget:self action:@selector(view1Btn1Click) forControlEvents:UIControlEventTouchUpInside];
    
    view1Btn1.layer.cornerRadius = 10;
    
    [self.nameView addSubview:view1Btn1];
    
    //弹出界面
    self.sexView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    self.sexView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.8];
    
    self.sexView.hidden = YES;
    
    [self.view addSubview:self.sexView];
    
    UIButton *manBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, HEIGHT5S(240), WIDTH5S(140), HEIGHT5S(40))];
    
    [manBtn setTitle:@"男" forState:UIControlStateNormal];
    
    manBtn.backgroundColor = COLOR(241, 197, 1, 1);
    
    manBtn.layer.cornerRadius = 5;
    
    [manBtn addTarget:self action:@selector(manClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.sexView addSubview:manBtn];
    
    UIButton *womanBtn = [[UIButton alloc]initWithFrame:CGRectMake(165, HEIGHT5S(240), WIDTH5S(140), HEIGHT5S(40))];
    
    [womanBtn setTitle:@"女" forState:UIControlStateNormal];
    
    womanBtn.backgroundColor = COLOR(241, 197, 1, 1);
    
    womanBtn.layer.cornerRadius = 5;
    
    [womanBtn addTarget:self action:@selector(manClick:) forControlEvents:UIControlEventTouchUpInside];

    [self.sexView addSubview:womanBtn];
    
    //弹出界面
    self.pwdView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    self.pwdView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.8];
    
    self.pwdView.hidden = YES;
    
    [self.view addSubview:self.pwdView];
    
    self.oPwdTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(15, HEIGHT5S(240), WIDTH5S(290), HEIGHT5S(40))];
    
    self.oPwdTextFiled.backgroundColor = [UIColor whiteColor];
    
    self.oPwdTextFiled.layer.cornerRadius = 10;
    
    self.oPwdTextFiled.placeholder = @"旧的密码";
    
    self.oPwdTextFiled.textAlignment = NSTextAlignmentCenter;
    
    self.oPwdTextFiled.font = FONT(15);
    
    [self.pwdView addSubview:self.oPwdTextFiled];
    
    
    self.nPwdTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(15, HEIGHT5S(340), WIDTH5S(290), HEIGHT5S(40))];
    
    self.nPwdTextFiled.backgroundColor = [UIColor whiteColor];
    
    self.nPwdTextFiled.layer.cornerRadius = 10;
    
    self.nPwdTextFiled.placeholder = @"新的密码";
    
    self.nPwdTextFiled.textAlignment = NSTextAlignmentCenter;
    
    self.nPwdTextFiled.font = FONT(15);
    
    [self.pwdView addSubview:self.nPwdTextFiled];
    
    
    UIButton *view3Btn3 = [[UIButton alloc]initWithFrame:CGRectMake(15, HEIGHT5S(400), WIDTH5S(290), HEIGHT5S(40))];
    
    view3Btn3.backgroundColor = COLOR(241, 197, 1, 1);
    
    [view3Btn3 setTitle:@"确定" forState:UIControlStateNormal];
    
    view3Btn3.layer.cornerRadius = 10;
    
    [view3Btn3 addTarget:self action:@selector(view3Btn3Click) forControlEvents:UIControlEventTouchUpInside];
    
    [self.pwdView addSubview:view3Btn3];

    self.labelArr1 = [NSMutableArray arrayWithCapacity:0];
    
    self.fakeArr = [NSMutableArray arrayWithCapacity:0];
    
    self.labelArr = @[@"名字",@"性别"];
    
    self.label1Arr = @[@"手机号",@"用户密码"];
   
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *dicUserDefaults = [userDefaults objectForKey:@"personInfo"];
    
    NSString *code = [dicUserDefaults objectForKey:@"code"];

    self.labelArr1 = [dicUserDefaults objectForKey:@"result"];
    
    self.diccc = _labelArr1[0];
    
    self.strNameUserDefaults = [self.diccc objectForKey:@"user_name"];
    
    self.strSexUserDefaults = [self.diccc objectForKey:@"user_sex"];
    
    self.strPasswordUserDefaults = [self.diccc objectForKey:@"user_password"];
    
    self.strUserIdUserDefaults = [self.diccc objectForKey:@"user_id"];
    
    
    NSLog(@"userid===============%@",_strUserIdUserDefaults);
    
    [self.fakeArr addObject:self.strNameUserDefaults];
    
    [self.fakeArr addObject:self.strSexUserDefaults];
    
    [self.fakeArr addObject:self.strPasswordUserDefaults];
    
    if ([code isEqual:@200]) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
                self.imaStr = [self.diccc objectForKey:@"user_headImage"];
                
                self.str7 = [NSString stringWithFormat:@"http://115.159.215.30/Tupian/image/%@",_imaStr];
                
                self.imageMyNes = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_str7]]];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self.myNesTable reloadData];
                    
                });
        });
    }
}

- (void)createTable{

    self.myNesTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, WIDTH5S(320), HEIGHT5S(568+49+49)) style:UITableViewStyleGrouped];
    
    self.myNesTable.delegate = self;
    self.myNesTable.dataSource = self;
    
    self.myNesTable.backgroundColor = COLOR(241, 241, 241, 1);
    
    self.myNesTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.myNesTable];
    
    self.btn = [[UIButton alloc]initWithFrame:CGRectMake(15, HEIGHT5S(370), WIDTH5S(290), HEIGHT5S(40))];
    
    [self.btn setTitle:@"提交信息" forState:UIControlStateNormal];
    
    [self.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    [self.btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.btn.titleLabel.font = FONT(15);
    
    self.btn.backgroundColor = COLOR(241, 197, 1, 1);
    
    self.btn.layer.cornerRadius = 5;
    
    [self.myNesTable addSubview:self.btn];
 
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section == 0) {
        
        return 1;
        
    }else{
    
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    MyNesCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"nesCell"];
    
    if (cell == nil) {
        
        cell = [[MyNesCellTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"nesCell"];
    }
    
    if (indexPath.section == 1) {
        
        cell.cellLabel1.text = _labelArr[indexPath.row];
        
    }else if (indexPath.section == 2){
    
        cell.cellLabel1.text = _label1Arr[indexPath.row];
    }
    
    if (_diccc == nil) {
        
        cell.cellLabel2.text = @"";
        
    }else{
    
        if (indexPath.section == 1) {
    
            if (indexPath.row == 0) {
                
                cell.cellLabel2.text = self.fakeArr[0];
                
            }else if (indexPath.row == 1){
                
                if ([self.fakeArr[1] isEqualToString:@"0"]) {
                    
                    cell.cellLabel2.text = @"男";
                    
                }else{
                    
                    cell.cellLabel2.text = @"女";
                }
            }
        }
        
        if (indexPath.section == 2) {
       
            if (indexPath.row == 0) {
                
                cell.cellLabel2.text = [self.diccc objectForKey:@"user_phone"];
                
            }else if (indexPath.row == 1){
                
                cell.cellLabel2.text = self.fakeArr[2];
            }
        }

    }
    

    if (indexPath.section == 0) {
        
        cell.cellLabel.text = @"头像设置";
        
        if (_ima) {

            cell.cellHeadImage.image = self.ima.image;

        }else{

            cell.cellHeadImage.image = self.imageMyNes;
        }
        
        cell.cellLineLabel.hidden = YES;
    }
    
    if (indexPath.section == 2&&indexPath.row == 1) {
        
        cell.cellLineLabel.hidden = YES;
    }
    
    if (indexPath.section == 1&&indexPath.row == 1) {
        
        cell.cellLineLabel.hidden = YES;
    }

    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        
        return 84;
        
    }else{
    
        return 45;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        
        return 20;
    }
    else{
    
        return 0.8;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1&&indexPath.row == 0) {
        
        [UIView animateWithDuration:1 animations:^{
           
            self.nameView.hidden = NO;
        }];
        
        self.sexView.hidden = YES;
        self.pwdView.hidden = YES;
    }
    
    if (indexPath.section == 1&&indexPath.row == 1) {
        
        [UIView animateWithDuration:1 animations:^{
            
            self.sexView.hidden = NO;
        }];
        
        self.nameView.hidden = YES;
        self.pwdView.hidden = YES;
    }

    if (indexPath.section == 2&&indexPath.row == 1) {
        
        [UIView animateWithDuration:1 animations:^{
            
            self.pwdView.hidden = NO;
        }];
        
        self.nameView.hidden = YES;
        self.sexView.hidden = YES;
    }

    if (indexPath.section == 0) {

        [self mineHeadBCEFFECTImageViewClick];
    }
}

- (void)BACK{

    MinePageViewController *minvc= [[MinePageViewController alloc]init];
 
    [self.navigationController pushViewController:minvc animated:NO];

    self.tabBarController.hidesBottomBarWhenPushed = NO;
}

- (void)view1Btn1Click{
    
    if (self.nameTextFiled.text.length == 0) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"prompt" message:@"Phone number already exists" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"confirm" style:UIAlertActionStyleDefault handler:nil];
        
        [alert addAction:action];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }else{
    
        [self.fakeArr replaceObjectAtIndex:0 withObject:self.nameTextFiled.text];
        
        self.nameView.hidden = YES;
        
        [self.myNesTable reloadData];
    }
}

- (void)view3Btn3Click{
    
    if (self.oPwdTextFiled.text.length == 0||self.nPwdTextFiled.text.length == 0) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"prompt" message:@"Phone number already exists" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"confirm" style:UIAlertActionStyleDefault handler:nil];
        
        [alert addAction:action];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }else{
    
        [self.fakeArr replaceObjectAtIndex:2 withObject:self.nPwdTextFiled.text];
        
        self.pwdView.hidden = YES;
        
        [self.myNesTable reloadData];
    }
}

- (void)manClick:(UIButton *)sender{
    
    if ([sender.titleLabel.text isEqualToString:@"男"]) {
        
        [self.fakeArr replaceObjectAtIndex:1 withObject:@"0"];
        
    }else if ([sender.titleLabel.text isEqualToString:@"女"]){
    
        [self.fakeArr replaceObjectAtIndex:1 withObject:@"1"];
    }

    self.sexView.hidden = YES;
    
    [self.myNesTable reloadData];
}



//拍照、从相册选取选择框
- (void)createPhotos{
    
    //弹出框
    
    self.myview = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    self.myview.backgroundColor = [UIColor blackColor];
    
    self.myview.alpha = 0;
    
    [self.view addSubview:self.myview];
    
    self.bkView = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT5S(370+205), WIDTH5S(320), HEIGHT5S(205))];
    
//    self.bkView.alpha = 0;
    
    self.bkView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.bkView];
    
    
    
    UIButton *button1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, WIDTH5S(320), HEIGHT5S(367))];
    
    button1.backgroundColor = [UIColor clearColor];
    
    [button1 addTarget:self action:@selector(mineHeadBCEFFECTImageViewClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.myview addSubview:button1];
    
    
    UIButton *pBoxBtn2 = [[UIButton alloc]initWithFrame:CGRectMake(0, HEIGHT5S(47), WIDTH5S(320), HEIGHT5S(47))];
    [pBoxBtn2 setTitle:@"拍照" forState:UIControlStateNormal];
    [pBoxBtn2 setTitleColor:COLOR(243, 197, 1, 1) forState:UIControlStateNormal];
    pBoxBtn2.backgroundColor = [UIColor whiteColor];
    pBoxBtn2.layer.cornerRadius = 5;
    
    [pBoxBtn2 addTarget:self action:@selector(ChooseCameraFromIPhone) forControlEvents:UIControlEventTouchUpInside];
    
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
    
    self.ima = [[UIImageView alloc]init];
    
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
    
    [self.myNesTable reloadData];
    
    
}

//房屋照片取消按钮
- (void)pBox4{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect frame = self.bkView.frame;
        
        frame.origin.y += self.bkView.frame.size.height;
        
        self.bkView.frame = frame;
        
        self.myview.alpha = 0;
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.isxiaoshi = YES;
    });
    
}
//点击弹出从相册选取/拍照选择框
- (void)mineHeadBCEFFECTImageViewClick{
    
    if (_isxiaoshi == YES) {

        
        [UIView animateWithDuration:0.3 animations:^{

            self.bkView.frame = CGRectMake(0, HEIGHT5S(370), WIDTH5S(320), HEIGHT5S(205));
            
            self.myview.alpha = 0.3;
        }];
        
        self.isxiaoshi = NO;
        
    }else if (_isxiaoshi == NO){
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.bkView.frame = CGRectMake(0, HEIGHT5S(370+205), WIDTH5S(320), HEIGHT5S(205));
            
            self.myview.alpha = 0;
        }];

        self.isxiaoshi = YES;
    }
}

//提交信息
- (void)btnClick{
    
    self.hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];

    //更换头像
    if (_ima) {
        
        [FavoritesService setHeadImg:_ima.image andUserId:_strUserIdUserDefaults.intValue andSuccess:^(NSString *str1) {
 
        } andFail:nil];

    }
    
    [FavoritesService userUpdataPassword:self.strUserIdUserDefaults andOldPassword:self.oPwdTextFiled.text andNewPassword:self.nPwdTextFiled.text andSuccess:^(NSDictionary *dic) {
        
        [FavoritesService userInfo:self.strUserIdUserDefaults andSuccess:^(NSDictionary *dic) {
            
            [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"personInfo"];
            
            [NSUserDefaults resetStandardUserDefaults];

        }];
        
    }];

    
    //更新个人信息//得等到显示请求个人信息成功才能返回，否则信息没有请求到
    if ([self.strNameUserDefaults isEqualToString:self.fakeArr[0]]&&[self.strSexUserDefaults isEqualToString:self.fakeArr[1]]&&!_ima) {
        
        
    }else{
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
            [FavoritesService userUpdataInfo:self.strUserIdUserDefaults andName:self.fakeArr[0] andSex:self.fakeArr[1] andSuccess:^(NSDictionary *dicUser) {
                
                [FavoritesService userInfo:self.strUserIdUserDefaults andSuccess:^(NSDictionary *dic) {
                    
                    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"personInfo"];
                    
                    [NSUserDefaults resetStandardUserDefaults];
                    
                    NSLog(@"......................%@",dic);
                    
                    self.hudDic = dic;
                    
                    if (_hudDic.count != 0) {
                        
                        [_hud hideAnimated:YES];
                        
                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"prompt" message:@"信息更换成功！！！" preferredStyle:UIAlertControllerStyleAlert];
                        
                        UIAlertAction *action = [UIAlertAction actionWithTitle:@"confirm" style:UIAlertActionStyleDefault handler:nil];
                        
                        [alert addAction:action];
                        
                        [self presentViewController:alert animated:YES completion:nil];

                    }else{
                    
                        sleep(6.);
                        
                        [self.hud hideAnimated:YES];
                        
                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"prompt" message:@"信息更换失败！！！" preferredStyle:UIAlertControllerStyleAlert];
                        
                        UIAlertAction *action = [UIAlertAction actionWithTitle:@"confirm" style:UIAlertActionStyleDefault handler:nil];
                        
                        [alert addAction:action];
                        
                        [self presentViewController:alert animated:YES completion:nil];

                    }
                    
                }];
            }];
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
            });
        });
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.view endEditing:YES];
}

@end
