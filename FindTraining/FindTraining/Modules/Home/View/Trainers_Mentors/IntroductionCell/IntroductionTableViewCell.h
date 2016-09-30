//
//  IntroductionTableViewCell.h
//  FindTraining
//
//  Created by Jiang on 16/9/27.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MemberDetailsModel.h"

@protocol IntroductionTableViewCellDelegate <NSObject>

- (void)selectedItemAtIndexPath:(NSInteger)item;


@end

@interface IntroductionTableViewCell : UITableViewCell
@property (nonatomic, retain) MemberDetailsModel *memberDetails;
@property (nonatomic, assign) id<IntroductionTableViewCellDelegate>delegate;
@end
