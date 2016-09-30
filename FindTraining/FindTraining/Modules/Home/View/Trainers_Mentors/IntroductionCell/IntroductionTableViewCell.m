//
//  IntroductionTableViewCell.m
//  FindTraining
//
//  Created by Jiang on 16/9/27.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import "IntroductionTableViewCell.h"
#import "AlbumCollectionViewCell.h"
#import "Title_ContentView.h"
#import "Title_SkillView.h"
static NSString *const cellIdentifier = @"albumCell";

@interface IntroductionTableViewCell ()
<
UICollectionViewDataSource,
UICollectionViewDelegate
>
@property (nonatomic, retain) UICollectionView *albumCollectionView;
@property (nonatomic, retain) Title_ContentView *signatureView;
@property (nonatomic, retain) Title_SkillView *dynamicView;
@end
@implementation IntroductionTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(60, 60);
        // 在垂直滑动情况下: 连续的行之间的间距
        // 在水平滑动情况下: 连续的列之间的间距
        flowLayout.minimumLineSpacing = 5;
        // 设置滑动方向
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 0);
        self.albumCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _albumCollectionView.delegate = self;
        _albumCollectionView.dataSource = self;
        [self.contentView addSubview:_albumCollectionView];
        [_albumCollectionView registerClass:[AlbumCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];

        self.signatureView = [[Title_ContentView alloc] init];
        _signatureView.title = @"签名:";
        [self.contentView addSubview:_signatureView];

        self.dynamicView = [[Title_SkillView alloc] init];
        _dynamicView.title = @"标签:";
        [self.contentView addSubview:_dynamicView];
        
        
    }
    return self;
}
- (void)setMemberDetails:(MemberDetailsModel *)memberDetails {
    if (_memberDetails != memberDetails) {
        _memberDetails = memberDetails;
    }
    _signatureView.content = _memberDetails.slogan;
    _dynamicView.memberSkill = _memberDetails.memberSkill;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _memberDetails.memberPhotoList.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AlbumCollectionViewCell *albumCell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
        albumCell.memberPhotoListModel = _memberDetails.memberPhotoList[indexPath.item];
        
    
    return albumCell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    #pragma mark - 协议传 当前点击item作跳转
    [self.delegate selectedItemAtIndexPath:indexPath.item];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _albumCollectionView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 70);
    CGFloat signWidth = [UILabel getWidthWithTitle:_signatureView.title font:kFONT_SIZE_15_BOLD];
    CGFloat signHeight = [UILabel getHeightByWidth:SCREEN_WIDTH - signWidth - 5 title:_memberDetails.slogan font:kFONT_SIZE_15_BOLD];
    _signatureView.frame = CGRectMake(5, _albumCollectionView.frame.origin.y + _albumCollectionView.frame.size.height + 10, SCREEN_WIDTH, signHeight);


    NSArray *array = [_memberDetails.memberSkill componentsSeparatedByString:@","];
    NSInteger count =  array.count / 4;
    if (array.count % 4 > 0) {
        count = count + 1;
    }
    if ([array[0] isEqualToString:@""]) {
        count = 0;
        _dynamicView.frame = CGRectMake(5, _signatureView.frame.origin.y + _signatureView.frame.size.height + 45, SCREEN_WIDTH, 45 * count);
    } else {

    _dynamicView.frame = CGRectMake(5, _signatureView.frame.origin.y + _signatureView.frame.size.height + 20, SCREEN_WIDTH, 45 * count);
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
