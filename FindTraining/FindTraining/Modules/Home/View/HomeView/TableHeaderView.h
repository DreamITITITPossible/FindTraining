//
//  TableHeaderView.h
//  FindTraining
//
//  Created by Jiang on 16/9/23.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol TableHeaderViewDelegate <NSObject>

- (void)tapToWebAction:(NSInteger)tag;

@end
@interface TableHeaderView : UIView

@property (nonatomic, retain) NSArray *bannerImageArray;
@property (nonatomic, assign) id<TableHeaderViewDelegate>delegate;

@end
