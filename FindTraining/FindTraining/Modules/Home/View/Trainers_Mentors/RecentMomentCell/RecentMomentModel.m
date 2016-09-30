//
//  RecentMomentModel.m
//  FindTraining
//
//  Created by Jiang on 16/9/28.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import "RecentMomentModel.h"

@implementation RecentMomentModel
+ (NSDictionary *)objectClassInArray {
    return @{
             @"detail" : @"DetailsModel",
             @"photoList" : @"PhotoListModel"
             };
}
@end
