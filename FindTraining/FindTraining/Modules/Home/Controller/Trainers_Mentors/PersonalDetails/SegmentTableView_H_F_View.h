//
//  SegmentTableView_H_F_View.h
//  FindTraining
//
//  Created by Jiang on 16/9/30.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SegmentTableView_H_F_ViewDelegate <NSObject>

- (void) getItemTitleByClick:(NSString *)segmentTitle;

@end
@interface SegmentTableView_H_F_View : UITableViewHeaderFooterView
@property (nonatomic, retain) NSArray *trainers_mentorsArray;
@property (nonatomic, assign) id<SegmentTableView_H_F_ViewDelegate>delegate;
@end
