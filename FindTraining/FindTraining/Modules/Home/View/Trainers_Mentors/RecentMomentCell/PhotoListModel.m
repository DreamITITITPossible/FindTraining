//
//  PhotoListModel.m
//  FindTraining
//
//  Created by Jiang on 16/9/28.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import "PhotoListModel.h"

@implementation PhotoListModel
+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{
             @"ID" : @"id",
             @"url" : @"imageUrl"
             };
}
@end
