
//
//  Title_SkillView.m
//  FindTraining
//
//  Created by Jiang on 16/9/29.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import "Title_SkillView.h"

#import "SkillCollectionViewCell.h"
static NSString *const cellIdentifier = @"personSkillCell";

@interface Title_SkillView ()
<
UICollectionViewDataSource,
UICollectionViewDelegate
>
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) NSArray *skillArray;
@end
@implementation Title_SkillView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel = [[UILabel alloc] init];
        _titleLabel.font = kFONT_SIZE_15_BOLD;
        
        [self addSubview:_titleLabel];
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(70, 30);
        flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.contentInset = UIEdgeInsetsMake(0, 0, -10, 0);
        
        
        _collectionView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_collectionView];
        [_collectionView registerClass:[SkillCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
        
        
    }
    return self;
}
- (void)setMemberSkill:(NSString *)memberSkill {
    if (_memberSkill != memberSkill) {
        _memberSkill = memberSkill;
    }
    self.skillArray = [_memberSkill componentsSeparatedByString:@","];
    NSInteger count =  _skillArray.count / 4;
    if (_skillArray.count % 4 > 0) {
        count = count + 1;
    }
    if (_skillArray.count == 0) {
        count = 0;
    }
    _collectionView.frame = CGRectMake(_titleLabel.frame.origin.x + _titleLabel.frame.size.width + 10, _titleLabel.frame.origin.y - 10, SCREEN_WIDTH - _titleLabel.frame.origin.x - _titleLabel.frame.size.width - 10 - 5, 45 * count);
    [_collectionView reloadData];
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    self.skillArray = [_memberSkill componentsSeparatedByString:@","];
    if ([_skillArray[0] isEqualToString:@""]) {
        return 0;
    }
    
    return _skillArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SkillCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.text = _skillArray[indexPath.item];
    cell.backgroundColor = [UIColor colorWithRed:0.199 green:0.492 blue:1.0 alpha:1.0];
    cell.layer.cornerRadius = 10.f;
    cell.textColor = [UIColor whiteColor];
    return cell;
}


- (void)setTitle:(NSString *)title {
    if (_title != title) {
        _title = title;
    }
    _titleLabel.text = _title;
    CGFloat width = [UILabel getWidthWithTitle:_titleLabel.text font:_titleLabel.font];
    _titleLabel.frame = CGRectMake(0, 0, width, 18);
    
}



@end
