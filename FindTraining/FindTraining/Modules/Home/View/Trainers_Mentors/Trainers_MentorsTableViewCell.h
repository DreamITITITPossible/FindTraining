//
//  Trainers_MentorsTableViewCell.h
//  FindTraining
//
//  Created by Jiang on 16/9/24.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TrainersModel;
@class MentorsModel;





@interface Trainers_MentorsTableViewCell : UITableViewCell
@property (nonatomic, retain) MentorsModel *mentorsModel;
@property (nonatomic, retain) TrainersModel *trainersModel;
@end
