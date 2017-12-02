//
//  Common_define.h
//  yimaxingtianxia
//
//  Created by lingbao on 2017/5/18.
//  Copyright © 2017年 lingbao. All rights reserved.
//
//  功能描述：常用宏定义

/***common**/
#import "AFNetworking.h"
#import "DataManager.h"
#import "UserModel.h"
#import "StatusModel.h"
#import "StatusRecordListModel.h"
#import <MJRefresh/MJRefresh.h>
#import <MJExtension/MJExtension.h>
#import "AppDelegate.h"
#import <Masonry/Masonry.h>
#import "JKNavigationController.h"
#import "JMRefreshHeader.h"
#import "JMRefreshFooter.h"
#import "IQKeyboardManager.h"
#import "WSProgressHUD.h"
#import "HelpTool.h"
#import "iOSBlocks.h"
#import "BaseTBView.h"
#import "BaseCLView.h"

#import <MapKit/MapKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>

/***类别***/
#import "UIViewExt.h"
#import "UIColor+Extension.h"
#import "UIButton+EnlargeEdge.h"
#import "UIView+UIViewController.h"
#import "UIButton+LCAlignment.h"
#import "UIImage+UIColor.h"
#import "UINavigationBar+Awesome.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "NSString+String.h"
#import "NSDictionary+Log.h"
#import "NSArray+Log.h"
#import "UIButton+Block.h"
#import "UIView+BlockGesture.h"
#import "UIViewController+Util.h"
#import "NSDictionary+RequestEncoding.h"
#import "NSString+Regex.h"
#import "UIScrollView+EmptyDataSet.h"


/***View***/


/***Manager***/


/***Util***/


/***Model***/

/***Configure***/

#ifndef Common_define_h
#define Common_define_h


#define rgbColor(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1];

//NSNumber转NSString
#define kNumberToString(number) [NSString stringWithFormat:@"%@", number]

#define kSystermVersion [[[UIDevice currentDevice] systemVersion] floatValue]

#define DEVICE_IPHONE5 ([[UIScreen mainScreen] bounds].size.width == 320)
#define DEVICE_IPHONE6 ([[UIScreen mainScreen] bounds].size.width == 375)
#define DEVICE_IPHONEPLUS ([[UIScreen mainScreen] bounds].size.width == 414)
#define DEVICE_IPHONEX [UIScreen mainScreen].bounds.size.width == 375.0f && [UIScreen mainScreen].bounds.size.height == 812.0f
#define  kStatusBarHeight      (DEVICE_IPHONEX ? 44.f : 20.f)
#define  kNavigationBarHeight  44.f
#define  kTabbarSafeBottomMargin         (DEVICE_IPHONEX ? 34.f : 0.f)
#define  kStatusBarAndNavigationBarHeight  (DEVICE_IPHONEX ? 88.f : 64.f)

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kBodyHeight   kScreenHeight - kStatusBarAndNavigationBarHeight
#define kTabBarHeight   ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)
#define kScreenRect  CGRectMake(0, 0, kScreenWidth, kBodyHeight)


#define IOS11 @available(iOS 11.0, *)
#define ViewSafeAreInsets(view) ({UIEdgeInsets i; if(@available(iOS 11.0, *)) {i = view.safeAreaInsets;} else {i = UIEdgeInsetsZero;} i;})


//=========================================

//=========================================
#define RMB @"￥"

#define GetDataManager [DataManager sharedManager]
#define GetDataUserModel [[DataManager sharedManager] userModel]

#define GetAPPDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)
#define GetAppBundleVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define kSystermVersion [[[UIDevice currentDevice] systemVersion] floatValue]

#define kLingBaoUser @"kLingBaoUser" // 用户帐户
#define kPreviousVersion @"PreviousVersion" //版本记录
#define kGetLatestAppVersion @"getLatestAppVersion"
#define kRegistrationIDKey @"registrationID"
#define kAutoLogin @"aotuLogin"


//=========================================
///消除webview margin
static NSString *const kMarginDeleteString = @"<style> *{margin:0px;padding:0;} img {max-width:100%;}</style>";

#define kUrlWithString(urlString) [NSURL URLWithString:urlString]
//=========================================

#define kMargin15 15
#define kMargin10 10

/***图片文字key***/
#define kTitleKey   @"title"
#define kSubTitleKey   @"subTitle"
#define kImgKey     @"imageName"
#define kSelectImgKey     @"selectImageName"
#define kCountKey     @"countNumber"

//=========================================
#define kGoodsHistroySearchData          @"kGoodsHistroySearchData"


//====================默认图片=====================
#define kDefaultStoreLogo         [UIImage imageNamed:@"store_placeHolder"]

//=========================================
#define BMKMapAK @"8EfaAbqwTcb7uLqMDl0Xki6kvgU7PQE0"



//=========================================
typedef enum :NSInteger {
    CarportShortRentType,
    CarportLongRentType,
    
}CarportRentType;


//=========================================
/**
 Synthsize a weak or strong reference.
 
 Example:
 @weakify(self)
 [self doSomething^{
 @strongify(self)
 if (!self) return;
 ...
 }];
 
 */
// 弱引用
#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

// 强引用
#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif


/// block self
#define kSelfWeak __weak typeof(self) weakSelf = self
#define kSelfStrong __strong __typeof__(weakSelf) strongSelf = weakSelf

/// Dlog
#ifdef DEBUG
//#   define DLog(fmt, ...) {NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}
//iOS10.0以上真机调试时NSLog打印不出日志 改用printf
#define DLog(fmt, ...) printf("< Line:(%d) > method: %s \n%s\n", __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(fmt), ##__VA_ARGS__] UTF8String] )

#   define ELog(err) {if(err) DLog(@"%@", err)}
#else
#   define DLog(...)
#   define ELog(err)
#endif


#endif /* Common_define_h */
