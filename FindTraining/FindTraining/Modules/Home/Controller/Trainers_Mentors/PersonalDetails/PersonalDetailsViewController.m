
//
//  PersonalDetailsViewController.m
//  FindTraining
//
//  Created by Jiang on 16/9/26.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import "PersonalDetailsViewController.h"
#import "MemberDetailsModel.h"
#import "MemberPhotoListModel.h"
#import "Details_HeadImageView.h"
#import "IntroductionTableViewCell.h"
#import "AlbumViewController.h"
#import "RecentTableViewCell.h"
#import "RecentMomentModel.h"
#import "DetailsModel.h"
#import "PhotoListModel.h"
#import "Details_T_MTableViewCell.h"
#import "List_ArrowTableViewCell.h"
#import "Comment_T_MTableViewCell.h"
#import "M_T_CommentListModel.h"
#import "SegmentTableView_H_F_View.h"
static NSString *const seg_HeadView = @"segment_HeadView";
@interface PersonalDetailsViewController ()
<
UITableViewDataSource,
UITableViewDelegate,
IntroductionTableViewCellDelegate,
SegmentTableView_H_F_ViewDelegate
>

@property (nonatomic, retain) NSMutableArray *photoListArray;
@property (nonatomic, retain) NSMutableArray *recentPhotoListArray;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, retain) Details_HeadImageView *headImageView;
@property (nonatomic, retain) MemberDetailsModel *memberDetails;
@property (nonatomic, retain) RecentMomentModel *recentMoment;
@property (nonatomic, retain) NSMutableArray *trainers_mentorsArray;
@property (nonatomic, retain) NSString *segmentTitle;
@property (nonatomic, retain) NSArray *skillArray;
@property (nonatomic, retain) NSMutableArray *commentArray;
@end
@implementation PersonalDetailsViewController
- (void)loadView {
    [super loadView];
    [self getMemberDetailsData];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.tabBarController.tabBar.hidden = YES;
    self.navigationItem.title = @"个人详情";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem getBarButtonItemWithImageName:@"navigator_btn_back" HighLightedImageName:@"navigator_btn_back" targetBlock:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem getBarButtonItemWithImageName:@"share" HighLightedImageName:@"share" targetBlock:^{
        
    }];
    
    
    [self createTableView];
    [self setupHeaderView];
    
   
    
}
- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 50) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.y = -20;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.contentInset = UIEdgeInsetsMake(-200, 0, 0, 0);
    [_tableView registerClass:[SegmentTableView_H_F_View class] forHeaderFooterViewReuseIdentifier:seg_HeadView];
    [self.view addSubview:_tableView];
    
    
}
- (void)setupHeaderView {
    
    self.headImageView= [[Details_HeadImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 500)];
    [self scrollViewDidScroll:self.tableView];
    
    
    // 与图像高度一样防止数据被遮挡
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH , _headImageView.height)];
    //    [self.view addSubview:_headImageView];
    self.tableView.tableHeaderView = _headImageView;
}


#pragma mark - 获取教陪练详情数据
- (void)getMemberDetailsData {
    NSString *urlString = [baseURL stringByAppendingString:@"/wechapi/member/getMemberDetail"];
    NSString *summary = [[key_API stringByAppendingString:self.memberId] stringWith32BitMD5Lower];
    urlString = [NSString stringWithFormat:@"%@?credential=%@&memberId=%@&summary=%@", urlString, credential, self.memberId, summary];
    [HttpClient GET:urlString body:nil headerFile:nil response:JYX_JSON success:^(id result) {
        if ([[result objectForKey:@"code"] isEqualToString:@"0"]) {
            
            NSDictionary *dataDic = [result objectForKey:@"data"];
            self.photoListArray = [NSMutableArray array];
            self.memberDetails = [MemberDetailsModel mj_objectWithKeyValues:dataDic];
            _headImageView.memberDetails = self.memberDetails;
            
            
            for (MemberPhotoListModel *photoList in _memberDetails.memberPhotoList) {
                [_photoListArray addObject:photoList];
            }
            [self getRecentData];
        } else {
            [UIView showMessage:[result objectForKey:@"msg"]];
        }
    } failure:^(NSError *error) {
    }];
    
}
#pragma mark - 获取动态数据
- (void)getRecentData {
    
    NSString *urlString = @"http://www.51zhaolian.cn/wechapi/moment/queryMyRecentMoment";
    NSString *summary = [[NSString stringWithFormat:@"%@%lld", key_API, TIMESTAMP] stringWith32BitMD5Lower];
    NSString *body = [NSString stringWithFormat:@"memberId=%@&summary=%@&timeStamp=%lld", _memberDetails.memberId, summary,TIMESTAMP];
//    NSLog(@"%@", self.memberDetails.memberId);
    [HttpClient POST:urlString body:body bodyStyle:JYX_BodyString headerFile:nil response:JYX_JSON success:^(id result) {
        if ([[result objectForKey:@"code"] isEqualToString:@"0"]) {
//            NSLog(@"%@", result);
            self.recentMoment = [RecentMomentModel mj_objectWithKeyValues:[result objectForKey:@"data"]];
            
            for (DetailsModel *details in _recentMoment.detail) {
//                NSLog(@"test : %@", details.name);
            }
            for (PhotoListModel *photoList in _recentMoment.photoList) {
                [self.recentPhotoListArray addObject:photoList];
            }
        }
        
        //        NSLog(@"+++++++++++++++%@", _recentMoment);
        [_tableView reloadData];
        
    } failure:nil];
}
#pragma mark - 获取评论列表
- (void)getComment_T_MList {
    NSString *urlstring = baseURL;
    if (_segmentTitle != nil) {
        
      if ([_segmentTitle isEqualToString:@"教练"]) {
        urlstring = [urlstring stringByAppendingString:@"/wechapi/comment/trainerCommentList"];
    } else if ([ _segmentTitle isEqualToString:@"陪练"]) {
        urlstring = [urlstring stringByAppendingString:@"/wechapi/comment/mentorCommentList"];
    }
    NSString *summary = [[NSString stringWithFormat:@"%@%@", key_API, _memberId] stringWith32BitMD5Lower];
    NSString *body = [NSString stringWithFormat:@"memberId=%@&pageNo=%@&summary=%@", _memberId, @"1", summary];
    urlstring = [NSString stringWithFormat:@"%@?%@", urlstring, body];
    [HttpClient GET:urlstring body:body headerFile:nil response:JYX_JSON success:^(id result) {
        NSLog(@"%@", result);
        NSArray *array = [result objectForKey:@"data"];
        self.commentArray = [NSMutableArray array];
        for (NSDictionary *dic in array) {
            NSLog(@"%@", dic);
            M_T_CommentListModel *MT_CommentList = [M_T_CommentListModel mj_objectWithKeyValues:dic];
            [self.commentArray addObject:MT_CommentList];
            
//            NSLog(@"MT%@", MT_CommentList);
        }
        
    } failure:nil];
    
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 50;
    } if (section == 2) {
        return 20;
    }
    
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    self.trainers_mentorsArray = [NSMutableArray array];
    if (_trainers_mentorsArray.count > 0) {
        [_trainers_mentorsArray removeAllObjects];
    }
    if (self.memberDetails != nil) {
        if (_memberDetails.trainerScore != nil) {
            
            [_trainers_mentorsArray addObject:@"教练"];
        }
        if (_memberDetails.mentorScore != nil) {
            [_trainers_mentorsArray addObject:@"陪练"];
        }
        
    }
    if (self.trainers_mentorsArray.count > 0) {
    
    if (_segmentTitle == nil) {
        _segmentTitle = _trainers_mentorsArray[0];
    }
        [self getComment_T_MList];
    if (section == 1) {
        SegmentTableView_H_F_View *segmentView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:seg_HeadView];
        
        segmentView.trainers_mentorsArray = _trainers_mentorsArray;
        segmentView.delegate = self;
        return segmentView;
        
    }}
    if (section == 2) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
        UILabel *label = [[UILabel alloc] init];
        label.text = @"课程评论";
        label.font = kFONT_SIZE_15_BOLD;
        CGFloat labelWidth = [UILabel  getWidthWithTitle:label.text font:label.font];
        label.frame = CGRectMake(10, 0, labelWidth, 20);
        [view addSubview:label];
        return view;
    }
    
    return nil;
}
- (void)getItemTitleByClick:(NSString *)segmentTitle {
    self.segmentTitle = segmentTitle;
    [_tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 220;
        } else if ([_recentMoment.type isEqualToString:@"1"]) {
            return 90;
        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            if ([_segmentTitle isEqualToString:@"教练"]) {
                self.skillArray = [_memberDetails.trainerSkill componentsSeparatedByString:@","];
            } else if ([_segmentTitle isEqualToString:@"陪练"]) {
                
                self.skillArray = [_memberDetails.memberSkill componentsSeparatedByString:@","];
               
                
            }
            
            NSInteger count =  _skillArray.count / 3;
            if (_skillArray.count % 3 > 0) {
                count = count + 1;
            }
            if (_skillArray.count == 0) {
                count = 0;
            }
            if ([_segmentTitle isEqualToString:@"教练"]) {
                NSLog(@"%f", [UILabel getWidthWithTitle:@"课程评论" font:kFONT_SIZE_15_BOLD]);
                CGFloat height = [UILabel getHeightByWidth:SCREEN_WIDTH - 95 title: _memberDetails.trainerIntro font:kFONT_SIZE_15_BOLD];
                return count * 45 + 20 + height + 50;

            } else if ([_segmentTitle isEqualToString:@"陪练"]) {
                CGFloat height = [UILabel getHeightByWidth:SCREEN_WIDTH - 95 title: _memberDetails.mentorIntro font:kFONT_SIZE_15_BOLD];
                return count * 45 + 20 + height + 50;

            }

        } else {
            return 30;
        }
        
    }
    if (indexPath.section == 2) {
        return 200;
    }
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    } else if (section == 1) {
        return 2;
    } else {
        if (_commentArray.count > 0) {
            return _commentArray.count;
        }
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
#pragma mark - 签名 标签
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            NSString *const introductionIdentifier = @"introCell";
            IntroductionTableViewCell *introductionCell = [tableView dequeueReusableCellWithIdentifier:introductionIdentifier];
            if (!introductionCell) {
                introductionCell = [[IntroductionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:introductionIdentifier];
            }
            introductionCell.delegate = self;
            if (self.memberDetails != nil) {
                introductionCell.memberDetails = self.memberDetails;
                return introductionCell;
            }
            
        } else {
#pragma mark - 动态
            NSString *const recentCellIdentifier = @"recentCell";
            RecentTableViewCell *recentCell = [tableView dequeueReusableCellWithIdentifier:recentCellIdentifier];
            
            if (nil == recentCell) {
                recentCell = [[RecentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:recentCellIdentifier];
            }             
            if (_recentMoment != nil) {
                
                recentCell.recentMoment = _recentMoment;
                
            }
            
            return recentCell;
        }
    }
    if (indexPath.section == 1) {
#pragma mark - 教练 陪练
        if (indexPath.row == 0) {
            NSString *const details_T_MIdentifier = @"details_T_MIdentifier";
            Details_T_MTableViewCell *details_T_MCell = [tableView dequeueReusableCellWithIdentifier:details_T_MIdentifier];
            
            if (nil == details_T_MCell) {
                details_T_MCell = [[Details_T_MTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:details_T_MIdentifier];
            }
            if ([_segmentTitle isEqualToString:@"教练"]) {
                details_T_MCell.segmenTitle = _segmentTitle;
                details_T_MCell.skillTitle = @"课程标签:";
                details_T_MCell.scoreTitle = @"课程评分:";
                details_T_MCell.introTitle = @"教练简介:";
                details_T_MCell.memberDetails = _memberDetails;
                
            }
            
            else if ([ [NSMutableString stringWithFormat:@"%@", _segmentTitle] isEqualToString:@"陪练"]) {
                details_T_MCell.segmenTitle = _segmentTitle;
                details_T_MCell.skillTitle = @"活动标签:";
                details_T_MCell.scoreTitle = @"活动评分:";
                details_T_MCell.introTitle = @"陪练简介:";
                details_T_MCell.memberDetails = _memberDetails;
            }
            return details_T_MCell;
        } else {
            
            NSString *const listCellIdentifier = @"listTMIdentifier";
            List_ArrowTableViewCell *listCell = [tableView dequeueReusableCellWithIdentifier:listCellIdentifier];
            
            if (nil == listCell) {
                listCell = [[List_ArrowTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:listCellIdentifier];
            }
            if ([_segmentTitle isEqualToString:@"教练"]) {
                listCell.listTitle = @"课程信息";
            } else if ([_segmentTitle isEqualToString:@"陪练"]) {
                listCell.listTitle = @"活动信息";
                
            }
            return listCell;
        }
    }
    
    if (indexPath.section == 2) {
        if (_commentArray.count > 0) {
            
        NSString *const commentIdentifier = @"Comment_T_MTableViewCell";
        Comment_T_MTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:commentIdentifier];
        if (!cell) {
            
            cell = [[Comment_T_MTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:commentIdentifier];
        }
        if ([_segmentTitle isEqualToString:@"教练"]) {
            cell.course_ActivityName = @"课程名称";
        }
        
        else if ([_segmentTitle isEqualToString:@"陪练"]) {
            cell.course_ActivityName = @"活动名称";
        }
        cell.M_T_CommentList = _commentArray[indexPath.row];
        return cell;
        } else {
            NSString *const identifier = @"cell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
            }
            cell.textLabel.textAlignment = 1;
            cell.textLabel.font = kFONT_SIZE_15_BOLD;
            cell.textLabel.textColor = [UIColor lightGrayColor];
            cell.textLabel.text = @"暂无评论";
            return cell;
        }

    }
    NSString *const identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    return cell;
}

#pragma mark - 相册跳转协议
- (void)selectedItemAtIndexPath:(NSInteger)item {
    AlbumViewController *albumVC = [[AlbumViewController alloc] init];
    albumVC.albumArray = _photoListArray;
    albumVC.currentImage = item;
    [self.navigationController pushViewController:albumVC animated:YES];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY < -200) {
        
        self.headImageView.frame = CGRectMake(offsetY / 2, offsetY, SCREEN_WIDTH - offsetY, 270 - offsetY);  // 修改头部的frame值就行了
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
