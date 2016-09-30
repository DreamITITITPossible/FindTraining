//
//  CategoryTableViewCell.h
//  FindTraining
//
//  Created by Jiang on 16/9/23.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CategoryTableViewCellDelegate <NSObject>

- (void) pushTosubVC:(NSString *)urlString item:(NSInteger)item;

@end
@interface CategoryTableViewCell : UITableViewCell
@property (nonatomic, assign) id<CategoryTableViewCellDelegate>delegate;
@end
