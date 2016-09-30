//
//  Comment_T_MTableViewCell.h
//  FindTraining
//
//  Created by Jiang on 16/9/29.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "M_T_CommentListModel.h"

@interface Comment_T_MTableViewCell : UITableViewCell
@property (nonatomic, retain) NSString *course_ActivityName;
@property (nonatomic, retain) M_T_CommentListModel *M_T_CommentList;
@end
