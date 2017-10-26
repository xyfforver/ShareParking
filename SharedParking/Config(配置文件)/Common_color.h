//
//  Common_color.h
//  yimaxingtianxia
//
//  Created by lingbao on 2017/5/18.
//  Copyright © 2017年 lingbao. All rights reserved.
//

#ifndef Common_color_h
#define Common_color_h


/********************** Color ****************************/
#ifndef UIColorHex
#define UIColorHex(_hex_)   [UIColor getColorFromHex:((__bridge NSString *)CFSTR(#_hex_))]
#endif


#pragma mark - 颜色

#define kColorRandom [UIColor randomColor]

#pragma mark - ---------基准颜色---------
#define kNavBarColor UIColorHex(#73B76C)
#define kBackGroundGrayColor UIColorHex(0xededed)
#define kColorf4f4f4 UIColorHex(0xf4f4f4)//灰色 超浅
#define kColorC1C1C1 UIColorHex(0xC1C1C1)//字体颜色 浅
#define kColor6B6B6B UIColorHex(0x6B6B6B)//字体颜色 中
#define kColor333333 UIColorHex(0x333333)//字体颜色 深




/// 设置颜色
#define UIColorRGB(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]

#define RGB(A,B,C,D) [UIColor colorWithRed:A/255.0f green:B/255.0f blue:C/255.0f alpha:D]

/// 设置颜色与透明度 示例：UIColorHEX_Alpha(0x26A7E8, 0.5)
#define UIColorHex_Alpha(rgbValue, al) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:al]

/// 设置颜色 示例：UIColorHexStr(@"#7b7b7b");
#define UIColorHexStr(hex)     [UIColor colorWithHexString:hex]


/// 透明色
#define kColorClear [UIColor clearColor]

/// 白色-如导航栏字体颜色
#define kColorWhite UIColorHex(0xffffff)

/// 淡灰色-如普通界面的背景颜色
#define kColorLightgrayBackground UIColorHex(0xf5f5f5)

/// 灰色—如内容字体颜色
#define kColorLightgrayContent UIColorHex(0x969696)

/// 灰色-如输入框占位符字体颜色
#define kColorLightgrayPlaceholder UIColorHex(0xaaaaaa)

/// 深灰色
#define kColorDarkgray UIColorHex(0x666666)

/// 中灰色-文字颜色
#define kColorMediumGray UIColorHexStr(@"#7b7b7b")

/// 黑色-如输入框输入字体颜色或标题颜色
#define kColorBlack UIColorHex(0x333333)

/// 黑色-细黑
#define kColorBlacklight UIColorHex(0x999999)

/// 黑色-纯黑
#define kColorDeepBlack UIColorHex(0x000000)

/// 灰色-边框线颜色
#define kColorBorderline UIColorHex(0xb8b8b8)

/// 绿色-如导航栏背景颜色
#define kColorGreenNavBground UIColorHex(0x38ad7a)

/// 绿色
#define kColorGreen UIColorHex(0x349c6f)

/// 深绿色
#define kColorDarkGreen UIColorHex(0x188d5a)

/// 橙色
#define kColorOrange UIColorHex(0xf39700)

/// 深橙色
#define kColorDarkOrange UIColorHex(0xe48437)

/// 淡紫色
#define kColorLightPurple UIColorHex(0x909af8)

/// 红色
#define kColorRed UIColorHex(0xff4b3b)

/// 蓝色
#define kColorBlue UIColorHex(0x00a0e9)

/// 高雅黑
#define kColorElegantBlack UIColorRGB(29, 31, 38)

/// 白色
#define kColorWhitelight UIColorHex(0xfefefe)

/// 背景色
#define kColorBackGroundColor UIColorHex(0xeff0f2)

/********************** Color ****************************/

#endif /* Common_color_h */
