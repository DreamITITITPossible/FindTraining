//
//  MentorsModel.h
//  FindTraining
//
//  Created by Jiang on 16/9/24.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import "Trainers_MentorsBaseModel.h"
@interface MentorsModel : Trainers_MentorsBaseModel
@property (nonatomic, retain) NSString *meetCount;
@property (nonatomic, retain) NSString *isSign;
@property (nonatomic, assign) NSInteger isHot;

@end
