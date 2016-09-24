//
//  DistanceView.m
//  FindTraining
//
//  Created by Jiang on 16/9/24.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import "DistanceView.h"

@interface DistanceView ()
@property (nonatomic, retain) UILabel *label;
@property (nonatomic, retain) UIImageView *imageView;
@end

@implementation DistanceView
@synthesize distance = _distance;
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.label = [[UILabel alloc] init];
        _label.font = kFONT_SIZE_13;
        _label.textColor = [UIColor lightGrayColor];
        [self addSubview:_label];
        self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"demand_location"]];
        [self addSubview:_imageView];

       
        
    }
    return self;
}

- (void)setDistance:(NSString *)distance {
    if (_distance != distance) {
        _distance = distance;
              CGFloat num = [distance intValue] / 1000.0f;
        if (num > 99) {
            self.label.text = @">99km";
        } else {
            _label.text = [NSString stringWithFormat:@"%fkm", num];
        }
    }
   

}
- (void)layoutSubviews {
    CGFloat width = [UILabel getWidthWithTitle:_label.text font:kFONT_SIZE_13];
    _label.frame = CGRectMake(self.bounds.size.width - width, 0, width, self.frame.size.height);
    _imageView.frame = CGRectMake(_label.frame.origin.x - 17, _label.frame.origin.y + _label.frame.size.height / 2 - 8, 12, 16);
}
- (NSString *)distance {
    _distance = _label.text;
    return _distance;
}

@end
