//
//  Trainers_MentorsBaseModel.m
//  FindTraining
//
//  Created by Jiang on 16/9/24.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import "Trainers_MentorsBaseModel.h"

@implementation Trainers_MentorsBaseModel
+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{
             @"ID" : @"id",
             };
}
@end
