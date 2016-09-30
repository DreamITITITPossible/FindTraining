//
//  RoleTypeView.m
//  FindTraining
//
//  Created by Jiang on 16/9/24.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import "RoleTypeView.h"

@interface RoleTypeView ()
@property (nonatomic, retain) NSMutableArray *roleTypeArray;
@property (nonatomic, retain) UIImageView *mentorImageView;
@property (nonatomic, retain) UIImageView *trainerImageView;
@property (nonatomic, retain) UIImageView *authenticatedImageView;

@end
@implementation RoleTypeView

- (void)setRoleType:(NSString *)roleType {
    if (_roleType != roleType) {
        _roleType = roleType;
 
    }
    NSArray *array = [NSArray array];
    array = [_roleType componentsSeparatedByString:@","];
    self.roleTypeArray = [NSMutableArray arrayWithArray:array];

}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.mentorImageView = [UIImageView new];
        _mentorImageView.image = [UIImage imageNamed:@"me_tag_mentor"];
        [self addSubview:_mentorImageView];
        self.trainerImageView = [UIImageView new];
        _trainerImageView.image = [UIImage imageNamed:@"me_tag_trainer"];
        [self addSubview:_trainerImageView];
        self.authenticatedImageView = [UIImageView new];        _authenticatedImageView.image = [UIImage imageNamed:@"me_tag_authenticated"];
        [self addSubview:_authenticatedImageView];
    
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.mentorImageView.frame = CGRectMake(5, 0, 20, 20);
        if (![self.roleTypeArray containsObject:@"2"]) {
            self.mentorImageView.frame = CGRectMake(0, 0, 0, 0);
        }
    self.trainerImageView.frame = CGRectMake(_mentorImageView.frame.origin.x + _mentorImageView.bounds.size.width + 5, _mentorImageView.frame.origin.y, 20, 20);
    if (![self.roleTypeArray containsObject:@"1"]) {
         self.trainerImageView.frame = CGRectMake(_mentorImageView.frame.origin.x + _mentorImageView.bounds.size.width + 0, _mentorImageView.frame.origin.y, 0, 0);
    }
    self.authenticatedImageView.frame = CGRectMake(_trainerImageView.frame.origin.x + _trainerImageView.frame.size.width + 5, _trainerImageView.frame.origin.y, 20, 20);
    if (![self.roleTypeArray containsObject:@"3"]) {
        self.authenticatedImageView.frame = CGRectMake(_trainerImageView.frame.origin.x + _trainerImageView.frame.size.width + 0, _trainerImageView.frame.origin.y, 0, 0);

    }
}
@end
