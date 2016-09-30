//
//  SkillCollectionViewCell.h
//  FindTraining
//
//  Created by Jiang on 16/9/22.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SkillCollectionViewCell : UICollectionViewCell
@property (nonatomic, retain) NSString *text;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, retain) UIColor *textColor;
@end
