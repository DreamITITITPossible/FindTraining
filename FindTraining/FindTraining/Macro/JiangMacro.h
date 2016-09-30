//
//  JiangMacro.h
//  FindTraining
//
//  Created by Jiang on 16/9/20.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#ifndef JiangMacro_h
#define JiangMacro_h

/**
 *  DDLog参数
 */
#ifdef DEBUG
static const int ddLogLevel = DDLogLevelVerbose;
#else
static const int ddLogLevel = DDLogLevelWarning;
#endif

/**
 *  AppStore
 */
#define APP_STORE_URL_7_UNDER @""
#define APP_STORE_URL_7_SUPPER @""

#define SCREEN_RECT         [UIScreen mainScreen].bounds
#define SCREEN_SIZE         [UIScreen mainScreen].bounds.size
#define SCREEN_WIDTH        SCREEN_SIZE.width
#define SCREEN_HEIGHT       SCREEN_SIZE.height
#define TIMESTAMP           [NSDate timeStamp]
/**
 *  UMeng参数
 */
// appkey:控制台应用app key
static NSString *const kUMengAppKey = @"57df91dfe0f55ac0a6001507";
// channelID:渠道
static NSString *const kUMengChannelId = @"App Store";


/**
 *  base 数据
 */
// base url
static NSString *const baseURL = @"http://www.51zhaolian.cn";
// base key
static NSString *const key_API = @"wech_app2015_en";
static NSString *const credential = @"2JCBm7HOLVbxjv3OLuRIWQnmQjWFkkCs5Vofbvv02SPld9gXkymN6kOJxxgjZg6ofvgFtctffjsmojpUd5y5rPVCNhMnSeIHTdecTbxwKrHxFWvFj2DPhNX1eH3JZed0oWNDvDdUnGjir2c4roOOchrRJVcYg2mQfmi74BBamVwOEOSB9d6tXJ6mtqkWRx1cABgSwUOXAJgSIsJh4DWS52YMGeh9vUhDhPmuvFvm6P87MM0";

#endif /* JiangMacro_h */
