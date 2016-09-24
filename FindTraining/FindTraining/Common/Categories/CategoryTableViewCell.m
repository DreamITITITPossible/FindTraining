//
//  CategoryTableViewCell.m
//  FindTraining
//
//  Created by Jiang on 16/9/23.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import "CategoryTableViewCell.h"
#import "HomeCollectionViewCell.h"

//static NSString *const homeHeaderIdentifier = @"headerHome";
static NSString *const homeCellIdentifier = @"cellHome";
@interface CategoryTableViewCell ()
<
UICollectionViewDataSource,
UICollectionViewDelegate
>
@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) NSArray *cellImageArray;
@property (nonatomic, retain) NSArray *postUrlArray;

@end
@implementation CategoryTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.cellImageArray = @[@"home_icon_lianka", @"home_icon_buddy", @"home_icon_friend", @"home_icon_course", @"home_icon_act", @"home_icon_demand"];
        self.postUrlArray = @[@"http://www.51zhaolian.cn/wechapi/trainer/getTrainers", @"http://www.51zhaolian.cn/wechapi/mentor/getMentors", @"http://www.51zhaolian.cn/wechapi/moment/queryMomentFriendsList", @"http://www.51zhaolian.cn/wechapi/course/searchCourseList", @"http://www.51zhaolian.cn/wechapi/event/searchEventList", @"http://www.51zhaolian.cn/wechapi/demand/searchDemandList"];
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(60, 80);
        flowLayout.sectionInset = UIEdgeInsetsMake(30, 50, 30, 50);
        flowLayout.minimumLineSpacing = 30;
        flowLayout.minimumInteritemSpacing = 40;
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_collectionView];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[HomeCollectionViewCell class]forCellWithReuseIdentifier:homeCellIdentifier];
    

        
    }
    return self;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _collectionView.frame = self.bounds;
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return _cellImageArray.count;
    }
    return 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ;
    if (indexPath.section == 0) {
        HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:homeCellIdentifier forIndexPath:indexPath];
        cell.imageName = _cellImageArray[indexPath.item];
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
    }
    return nil;
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item <= 1) {
        [self.delegate pushTosubVC:_postUrlArray[indexPath.item] item:indexPath.item];
        
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
