//
//  HomeViewController.m
//  FindTraining
//
//  Created by Jiang on 16/9/21.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import "HomeViewController.h"
#import "BannerModel.h"
#import "BannerWebViewController.h"
#import "TableHeaderView.h"
#import "CategoryTableViewCell.h"
#import "Trainers_MentorsViewController.h"

@interface HomeViewController ()
<
UITableViewDataSource,
UITableViewDelegate,
TableHeaderViewDelegate,
CategoryTableViewCellDelegate
>
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *bannerDataArray;
@property (nonatomic, retain) NSMutableArray *bannerImageURLArray;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
//    self.tabBarItem.imageInsets = UIEdgeInsetsMake(10, 0, 10, 0);
//    self.tabBarItem.titlePositionAdjustment = UIOffsetMake(10, 0);
    
    
    
    [self GetHeaderData];
    [self createView];
    
    
   
}
- (void)createView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.9504 green:0.9504 blue:0.9504 alpha:1.0];
    _tableView.showsVerticalScrollIndicator = NO;

    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
//    _tableView.rowHeight = 120.f;
  
    
    
}

#pragma mark - 获取头视图数据
- (void)GetHeaderData {
    NSString *summary = [key_API stringWith32BitMD5Lower];
    NSString *urlString = [baseURL stringByAppendingString:[NSString stringWithFormat:@"/wechapi/banner/getPublishBannerList?summary=%@", summary]];
    [HttpClient GET:urlString body:JYX_BodyString headerFile:nil response:JYX_JSON success:^(id result) {
        
        if ([[result objectForKey:@"msg"] isEqualToString:@"success"]) {
            self.bannerDataArray = [NSMutableArray array];
            self.bannerImageURLArray = [NSMutableArray array];
            
            //            NSLog(@"%@", [result objectForKey:@"data"]);
            NSArray *array = [result objectForKey:@"data"];
            for (NSDictionary *dic in array) {
                
                BannerModel *bannerModel = [BannerModel modelWithDic:dic];
                [self.bannerDataArray addObject:bannerModel];
                [self.bannerImageURLArray addObject:bannerModel.bannerImageUrl];
            }
        }  [_tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
    


}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
  
        TableHeaderView *headView = [[TableHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH / 2)];
        headView.bannerImageArray = _bannerImageURLArray;
        headView.delegate = self;
        return headView;
  
}
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (0 == section) {
        return SCREEN_WIDTH / 2;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 250;
        
        
    }
    return 40;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *categoryIdentifier = @"categoryCell";
    if (indexPath.row == 0) {
        CategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:categoryIdentifier];
        if (nil == cell) {
            cell = [[CategoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:categoryIdentifier];
        }
        cell.delegate = self;
        return cell;
    }
    return 0;
}

#pragma mark -  跳转到二级界面
- (void)pushTosubVC:(NSString *)urlString item:(NSInteger)item {
    if (item <= 1) {
        Trainers_MentorsViewController *trainers_MentorsVC = [[Trainers_MentorsViewController alloc] init];
        trainers_MentorsVC.urlString = urlString;
        trainers_MentorsVC.item = item;
        [self.navigationController pushViewController:trainers_MentorsVC animated:YES];
    }
}





- (void)tapToWebAction:(NSInteger)tag {
    BannerWebViewController *bannerWebVC = [[BannerWebViewController alloc] init];
    BannerModel *bannerModel = _bannerDataArray[tag];
    bannerWebVC.targetUrl = bannerModel.targetUrl;
    bannerWebVC.navigationItem.title = bannerModel.title;
    [self.navigationController pushViewController:bannerWebVC animated:NO];
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
