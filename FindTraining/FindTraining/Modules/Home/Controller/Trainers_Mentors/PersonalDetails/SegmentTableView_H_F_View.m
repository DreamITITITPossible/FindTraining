//
//  SegmentTableView_H_F_View.m
//  FindTraining
//
//  Created by Jiang on 16/9/30.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import "SegmentTableView_H_F_View.h"

@interface SegmentTableView_H_F_View ()

@property (nonatomic, retain) UIView *view;
@property (nonatomic, retain) UISegmentedControl *segmentedControl;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) NSInteger num;

@end

@implementation SegmentTableView_H_F_View
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {

        self.view = [[UIView alloc] init];
        _view.backgroundColor = [UIColor whiteColor];
        self.segmentedControl = [[UISegmentedControl alloc] init];
        
        [_segmentedControl addTarget:self action:@selector(segmentAction) forControlEvents:UIControlEventValueChanged];
        [_view addSubview:_segmentedControl];
        [self.contentView addSubview:_view];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
    _segmentedControl.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
    if (_trainers_mentorsArray.count == 1) {
        _segmentedControl.frame = CGRectMake(0, 0, SCREEN_WIDTH / 2, 50);
    }
    _segmentedControl.selectedSegmentIndex = self.index;
    
    _segmentedControl.backgroundColor = [UIColor whiteColor];
    
    _segmentedControl.layer.borderColor = [UIColor whiteColor].CGColor;
    _segmentedControl.tintColor = [UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1.0];

}

- (void)setTrainers_mentorsArray:(NSArray *)trainers_mentorsArray {
    if (_trainers_mentorsArray != trainers_mentorsArray) {
        _trainers_mentorsArray = trainers_mentorsArray;
    }
    if (_num > 0) {
        for (int i = 0; i < _num; i++) {
            [_segmentedControl removeSegmentAtIndex:0 animated:YES];
        }
    
    }
    for (int i = 0; i < _trainers_mentorsArray.count; i++) {
        [_segmentedControl insertSegmentWithTitle:_trainers_mentorsArray[i] atIndex:i animated:NO];
        _num++;
    }
    
    
//    NSLog(@"%@", trainers_mentorsArray);
    
}
- (void)segmentAction {
    
    self.index = [_segmentedControl selectedSegmentIndex];
    [self.delegate getItemTitleByClick:[_segmentedControl titleForSegmentAtIndex:self.index]];

    NSLog(@"dsas%ld", (long)_segmentedControl.selectedSegmentIndex);

    
}



@end
