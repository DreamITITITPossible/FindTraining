//
//  Details_T_MTableViewCell.h
//  FindTraining
//
//  Created by Jiang on 16/9/29.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MemberDetailsModel.h"

@interface Details_T_MTableViewCell : UITableViewCell
@property (nonatomic, retain) NSString *skillTitle;
@property (nonatomic, retain) NSString *scoreTitle;
@property (nonatomic, retain) NSString *introTitle;
@property (nonatomic, retain) MemberDetailsModel *memberDetails;
@property (nonatomic, retain) NSString *segmenTitle;
@end
