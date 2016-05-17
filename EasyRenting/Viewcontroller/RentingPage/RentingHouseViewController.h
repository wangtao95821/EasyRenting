//
//  RentingHouseViewController.h
//  EasyRenting
//
//  Created by administrator on 16/3/28.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Define.h"
@protocol HouseCityDelegate <NSObject>

- (void)houseCityName:(NSDictionary *)dic;

@end

@interface RentingHouseViewController : UIViewController<UIScrollViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITextViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITextFieldDelegate,HouseCityDelegate>

@property (strong, nonatomic) UIScrollView *rentHouseScroll;

@property (strong, nonatomic) UIView *pView;

@property (strong, nonatomic) UILabel *lineLabel;//线

@property (strong, nonatomic) UIButton *Round1Label;//圆

@property (strong, nonatomic) UIButton *Round2Label;//圆

@property (strong, nonatomic) UIButton *Round3Label;//圆

@property (strong, nonatomic) UILabel *textLabel;//文字

@property (strong, nonatomic) UIPickerView *animationPicker1;

@property (strong, nonatomic) UIPickerView *animationPicker2;

@property (strong, nonatomic) UIPickerView *animationPicker3;

@property (strong, nonatomic) UIPickerView *animationPicker4;


@property (strong, nonatomic) UIPickerView *housePicker;

@property (copy, nonatomic) NSString *roomValue;  //XX室
//@property (copy, nonatomic) NSString *tingValue;  //XX厅
@property (copy, nonatomic) NSString *roomStr;

@property (strong, nonatomic) NSMutableArray *roomArr;  //XX室

@property (copy, nonatomic) NSString *regionValue;  //区域
@property (copy, nonatomic) NSString *houseStyleValue;   //房屋类型
@property (copy, nonatomic) NSString *totalFloorValue;    //总楼层
@property (copy, nonatomic) NSString *floorValue;    //当前楼层

@property (nonatomic,strong) NSArray * animationTypes;//室厅厨卫
@property (nonatomic,strong) NSArray * animationTypes1;
@property (nonatomic,strong) NSMutableArray * animationTypes2;//区域

@property (nonatomic,strong) NSArray * houseStyleArr;//房屋类型

@property (strong, nonatomic) UITextView *detaliAdressText;//详细地址

@property (strong, nonatomic) UITextView *detaliHouseText;//房源描述


@property (strong, nonatomic) UILabel *houseNameLabel;//房屋姓名
@property (strong, nonatomic) UITextField *houseNameText;


@property (strong, nonatomic) UIButton *rentWayBtnLeft;//出租方式
@property (strong, nonatomic) UIButton *rentWayBtnRight;
@property (strong, nonatomic) UIView *rentWayBtnRightView;

@property (strong, nonatomic) UIButton *rentWayBtnRightViewLeft;//分租方式btn
@property (strong, nonatomic) UIButton *rentWayBtnRightViewCenter;
@property (strong, nonatomic) UIButton *rentWayBtnRightViewRight;
@property (strong, nonatomic) UIButton *rentWayBtnRightViewDown;

@property (copy, nonatomic) NSString *rentWayBtnRightViewLeftStr;//分租方式str
@property (copy, nonatomic) NSString *rentWayBtnRightViewCenterStr;
@property (copy, nonatomic) NSString *rentWayBtnRightViewRightStr;
@property (copy, nonatomic) NSString *rentWayBtnRightViewdownStr;


@property (strong, nonatomic) UITextField *rentMoneyTextFiled;
@property (strong, nonatomic) UIView *contactview;

@property (strong, nonatomic) UIView *myview;
@property (strong, nonatomic) UIView *bkView;
@property (assign, nonatomic) BOOL isxiaoshi;

@property (strong, nonatomic) UIButton *housePicBtn;
@property (strong, nonatomic) UIImageView *ima;
@property (assign, nonatomic) int i;
@property (strong, nonatomic) UIScrollView *housePicView;

@property (assign, nonatomic) int p;
@property (strong, nonatomic) NSMutableArray *collectMutArr;

@property (strong, nonatomic) NSMutableArray *pMutArr;

@property (assign, nonatomic) long int  s;

@property (strong, nonatomic) UIButton *collectBtn;

@property (strong, nonatomic) UIButton *longBtn;



@property (strong, nonatomic) NSMutableArray *colMutArr;


@property (strong, nonatomic) NSDictionary *confirmDic;//提交



@property (copy, nonatomic) NSString *u;
@property (strong, nonatomic) NSMutableArray *btnMutArr;

@property (copy, nonatomic) NSString *jointStr;


@property (copy, nonatomic) NSString *rentStyleStr;//整租/分租



@property (strong, nonatomic) NSMutableArray *mutArrTap;


@property (strong, nonatomic) NSMutableArray *houArr;
@property (strong, nonatomic) NSMutableArray *sArr;


@property (strong, nonatomic) NSDictionary *recordDic;
@end
