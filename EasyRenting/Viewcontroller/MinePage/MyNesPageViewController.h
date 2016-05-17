//
//  MyNesPageViewController.h
//  EasyRenting
//
//  Created by administrator on 16/4/5.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyNesPageViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (strong, nonatomic) UITableView *myNesTable;

@property (strong, nonatomic) UIButton *btn;

//@property (strong, nonatomic) UITextField *myNesText;

@property (strong, nonatomic) NSArray *labelArr;

@property (strong, nonatomic) NSArray *label1Arr;

@property (strong, nonatomic) NSMutableArray *labelArr1;

@property (strong, nonatomic) NSMutableArray *fakeArr;


@property (strong, nonatomic) UIView *nameView;
@property (strong, nonatomic) UIView *sexView;
@property (strong, nonatomic) UIView *pwdView;


@property (strong, nonatomic) UITextField *nameTextFiled;

@property (strong, nonatomic) UITextField *oPwdTextFiled;

@property (strong, nonatomic) UITextField *nPwdTextFiled;


@property (strong, nonatomic) UIView *myview;
@property (strong, nonatomic) UIView *bkView;
@property (assign, nonatomic) BOOL isxiaoshi;

@property (strong, nonatomic) UIButton *housePicBtn;
@property (strong, nonatomic) UIImageView *ima;


@property (copy, nonatomic) NSString *imaStr;
@property (copy, nonatomic) NSString *imaStr1;

//@property (copy, nonatomic) NSString *str5;
//@property (copy, nonatomic) NSString *str6;

@property (copy, nonatomic) NSString *str7;

//@property (copy, nonatomic) NSString *str71;
@property (strong, nonatomic) UIImage *imageMyNes;

@property (strong, nonatomic) NSDictionary *diccc;



@property (strong, nonatomic) NSDictionary *myNesDic;

@property (strong, nonatomic) NSDictionary *hudDic;

@end
