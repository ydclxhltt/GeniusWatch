//
//  CommonHeader.h
//  GeniusWatch
//
//  Created by clei on 15/8/21.
//  Copyright (c) 2015年 chenlei. All rights reserved.
//

#ifndef GeniusWatch_CommonHeader_h
#define GeniusWatch_CommonHeader_h

//设置RGB
#define RGBA(R,G,B,AL)          [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:AL]
#define RGB(R,G,B)              [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]

//设置字体大小
#define FONT(f)                 [UIFont systemFontOfSize:f]

//设置加粗字体大小
#define BOLD_FONT(f)            [UIFont boldSystemFontOfSize:f]

//主色调
#define APP_MAIN_COLOR          RGB(231.0,151.0,62.0)

//导航条高度
#define NAVBAR_HEIGHT           64.0

//百度地图Key
#define BAIDU_MAP_KEY           @"Y0sGfOsjD053snNF2oWlopmB"

//屏幕宽度
#define SCREEN_HEIGHT           [UIScreen mainScreen].bounds.size.height

//屏幕高度
#define SCREEN_WIDTH            [UIScreen mainScreen].bounds.size.width

//设备型号
#define DEVICE_MODEL            [[UIDevice currentDevice] model]

//分辨率
#define DEVICE_RESOLUTION       [NSString stringWithFormat:@"%.0f*%.0f", SCREEN_WIDTH * [[UIScreen mainScreen] scale], SCREEN_HEIGHT * [[UIScreen mainScreen] scale]]

//系统版本
#define DEVICE_SYSTEM_VERSION   [[[UIDevice currentDevice] systemVersion] floatValue]

//scale
#define CURRENT_SCALE           SCREEN_WIDTH/375.0

#endif
