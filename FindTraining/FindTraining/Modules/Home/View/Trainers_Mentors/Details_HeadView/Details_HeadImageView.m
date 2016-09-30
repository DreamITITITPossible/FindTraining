//
//  Details_HeadImageView.m
//  FindTraining
//
//  Created by Jiang on 16/9/27.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import "Details_HeadImageView.h"
#import "ScoreView.h"
#import "White_Sex_AgeView.h"
#import "RoleTypeView.h"
#import "White_ScoreView.h"

@interface Details_HeadImageView ()
@property (nonatomic, retain) UIImageView *headImageView;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) White_ScoreView *whiteScoreView;
@property (nonatomic, retain) White_Sex_AgeView *white_sex_ageView;
@property (nonatomic, retain) RoleTypeView *roleTypeView;
@property (nonatomic, retain) UILabel *areaLabel;
@property (nonatomic, retain) UIButton *collectionButton;
@property (nonatomic, assign) NSInteger count;
@end

@implementation Details_HeadImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeScaleToFill;
        UIView *backDarkView = [[UIView alloc] initWithFrame:self.frame];
        backDarkView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
        [self addSubview:backDarkView];
        self.headImageView = [[UIImageView alloc] init];
        [self addSubview:_headImageView];
        _headImageView.layer.cornerRadius = 30;
        _headImageView.clipsToBounds = YES;
        [self addSubview:_headImageView];
        self.whiteScoreView = [[White_ScoreView alloc] init];
        [self addSubview:_whiteScoreView];
     
        self.nameLabel = [[UILabel alloc] init];
        _nameLabel.font = kFONT_SIZE_18_BOLD;
        _nameLabel.textColor = [UIColor whiteColor];
        [self addSubview:_nameLabel];
        self.white_sex_ageView = [[White_Sex_AgeView alloc] init];
        [self addSubview:_white_sex_ageView];
        self.roleTypeView = [[RoleTypeView alloc] init];
        [self addSubview:_roleTypeView];
        
        
        self.areaLabel = [[UILabel alloc] init];
        _areaLabel.textColor = [UIColor whiteColor];
        _areaLabel.font = kFONT_SIZE_15_BOLD;
        [self addSubview:_areaLabel];
        
        self.collectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _collectionButton.backgroundColor = [UIColor redColor];
        _collectionButton.backgroundColor = [UIColor colorWithRed:0.3404 green:0.3404 blue:0.3404 alpha:0.7];
        [_collectionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

        [_collectionButton setImage:[UIImage imageNamed:@"collection_empty"] forState:UIControlStateNormal];
        [_collectionButton setImage:[UIImage imageNamed:@"collection"] forState:UIControlStateSelected];
        _collectionButton.layer.cornerRadius = 10;
        _collectionButton.frame = CGRectMake(100, 100, 100, 100);
        [self addSubview:_collectionButton];
   
    }
    return self;
}
- (void)setMemberDetails:(MemberDetailsModel *)memberDetails {
    if (_memberDetails != memberDetails) {
        _memberDetails = memberDetails;
    
    [self sd_setImageWithURL:[NSURL URLWithString:_memberDetails.headImageUrl] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    self.image = [self.image boxblurImageWithBlur:0.65];
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:_memberDetails.headImageUrl] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    _whiteScoreView.score = _memberDetails.allScore;
    _nameLabel.text = _memberDetails.name;
    _white_sex_ageView.sex = _memberDetails.sex;
    _white_sex_ageView.age = _memberDetails.age;
    _roleTypeView.roleType = _memberDetails.roleType;
    _areaLabel.text = [NSString stringWithFormat:@"%@ · %@", _memberDetails.cityName, _memberDetails.areaName];
    _headImageView.frame = CGRectMake(SCREEN_WIDTH / 2 -  30, self.bounds.size.height / 2 , 60, 60);
    _whiteScoreView.frame = CGRectMake(SCREEN_WIDTH / 2 - 28, _headImageView.frame.origin.y + _headImageView.frame.size.height + 15, 60, 10);
    CGFloat nameWidth = [UILabel getWidthWithTitle:_nameLabel.text font:_nameLabel.font];
    _nameLabel.frame = CGRectMake(SCREEN_WIDTH / 2 - 10 - nameWidth, _whiteScoreView.frame.origin.y + _whiteScoreView.frame.size.height + 20, nameWidth, 23);
    _white_sex_ageView.frame = CGRectMake(SCREEN_WIDTH / 2 + 10, _whiteScoreView.frame.origin.y + _whiteScoreView.frame.size.height + 20, 60, 23);
    _roleTypeView.frame = CGRectMake(SCREEN_WIDTH / 2 - 38, _nameLabel.frame.origin.y + _nameLabel.frame.size.height + 20, 60, 20);
    CGFloat areaWidth = [UILabel getWidthWithTitle:_areaLabel.text font:_areaLabel.font];
    _areaLabel.frame = CGRectMake(20, self.frame.size.height - 50, areaWidth, 20);
    
    CGFloat titleLabelWidth = [UILabel getWidthWithTitle:memberDetails.collectCount font:_collectionButton.titleLabel.text];
    _collectionButton.frame = CGRectMake(SCREEN_WIDTH - 80, self.frame.size.height - 50, 50 + titleLabelWidth, 20);
    CGSize imageSize = _collectionButton.imageView.frame.size;
    _collectionButton.titleEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, - imageSize.width / 2);
    CGSize titleSize = _collectionButton.titleLabel.frame.size;
    _collectionButton.imageEdgeInsets = UIEdgeInsetsMake(0.0, -titleSize.width - 3, 0.0, 0.0);

    
    
#pragma mark - 收藏
    BOOL isCollect = [_memberDetails.isCollect isEqualToString:@"1"];
    [_collectionButton setTitle:_memberDetails.collectCount forState:UIControlStateNormal];
    [_collectionButton setTitle:_memberDetails.collectCount forState:UIControlStateSelected];
    NSLog(@"%d", isCollect);
    if (isCollect == 0) {
        _collectionButton.selected = NO;
    } else {
        _collectionButton.selected = YES;
    }
    self.count = [_memberDetails.collectCount integerValue];

    [_collectionButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
       
#pragma mark - 收藏
     
        if (_collectionButton.selected == 0) {
            NSString *urlString = [baseURL stringByAppendingString:@"/wechapi/trainer/saveCollect"];
            NSString *summary = [[NSString stringWithFormat:@"%@%@%lld%@", key_API, credential, TIMESTAMP, _memberDetails.memberId] stringWith32BitMD5Lower];
            NSString *body = [NSString stringWithFormat:@"credential=%@&objectId=%@&roleType=%@&summary=%@&timeStamp=%lld", credential, _memberDetails.memberId, _memberDetails.roleType, summary, TIMESTAMP];
            [HttpClient GET:[NSString stringWithFormat:@"%@?%@", urlString, body] body:JYX_BodyString headerFile:nil response:JYX_JSON success:^(id result) {
                if ([[result objectForKey:@"code"] isEqualToString:@"0"]) {
                    [_collectionButton setTitle:[NSString stringWithFormat:@"%ld", _count + 1] forState:UIControlStateSelected];
                    [UIView showMessage:@"收藏成功"];
                    _count++;
                    _collectionButton.selected = !_collectionButton.selected;
                } else {
                    [UIView showMessage:[NSString stringWithFormat:@"%@", [result objectForKey:@"msg"]]];
                }
                
            } failure:^(NSError *error) {
                
                
            }];
            
        } else {
#pragma mark - 取消收藏
            NSString *urlString = [baseURL stringByAppendingString:@"/wechapi/trainer/deleteCollect"];
            NSString *summary = [[NSString stringWithFormat:@"%@%@%lld%@", key_API, credential, TIMESTAMP, _memberDetails.memberId] stringWith32BitMD5Lower];
            NSString *body = [NSString stringWithFormat:@"credential=%@&objectId=%@&roleType=%@&summary=%@&timeStamp=%lld", credential, _memberDetails.memberId, _memberDetails.roleType, summary, TIMESTAMP];
            [HttpClient GET:[NSString stringWithFormat:@"%@?%@", urlString, body] body:JYX_BodyString headerFile:nil response:JYX_JSON success:^(id result) {
                if ([[result objectForKey:@"code"] isEqualToString:@"0"]) {
                    [_collectionButton setTitle:[NSString stringWithFormat:@"%ld", _count - 1] forState:UIControlStateNormal];
                    [UIView showMessage:@"已取消收藏"];
                    _count--;

                    _collectionButton.selected = !_collectionButton.selected;
                } else {
                    [UIView showMessage:[NSString stringWithFormat:@"%@", [result objectForKey:@"msg"]]];
                }
                
            } failure:^(NSError *error) {
                
                
            }];

        }
    }];
    
    }
    
}


@end
