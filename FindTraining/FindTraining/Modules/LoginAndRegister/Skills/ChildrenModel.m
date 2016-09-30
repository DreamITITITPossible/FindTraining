//
//  ChildrenModel.m
//  FindTraining
//
//  Created by Jiang on 16/9/22.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import "ChildrenModel.h"

@implementation ChildrenModel
+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{
             @"myId" : @"id"
             };
}
@end
