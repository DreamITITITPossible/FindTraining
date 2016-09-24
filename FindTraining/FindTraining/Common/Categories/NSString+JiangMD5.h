//
//  NSString+JiangMD5.h
//  FindTraining
//
//  Created by Jiang on 16/9/21.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JiangMD5)
// 字符串 转换 32位 MD5字符串小写
- (NSString *)stringWith32BitMD5Lower;
// 字符串 转换 32位 MD5字符串大写
- (NSString *)stringWith32BitMD5Upper;
// 字符串 转换 16位 MD5字符串小写
- (NSString *)stringWith16BitMD5Lower;
// 字符串 转换 16位 MD5字符串大写
- (NSString *)stringWith16BitMD5Upper;

@end
