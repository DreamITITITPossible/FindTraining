//
//  Trainers_MentorsViewController.m
//  FindTraining
//
//  Created by Jiang on 16/9/24.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import "Trainers_MentorsViewController.h"
#import "Requst_Trainers_Mentors.h"
#import "TrainersModel.h"
#import "MentorsModel.h"
#import "Trainers_MentorsTableViewCell.h"
#import "PersonalDetailsViewController.h"
static NSString *const identifier = @"Trainers_Mentors_Cell";
@interface Trainers_MentorsViewController ()
<
UITableViewDataSource,
UITableViewDelegate
>
@property (nonatomic, retain) Requst_Trainers_Mentors *requestData;
@property (nonatomic, retain) NSMutableArray *pageInfoArray;
@property (nonatomic, retain) UITableView *tableView;
@end

@implementation Trainers_MentorsViewController
#pragma mark - 初始请求数据
- (void)defaultRequestData {
    self.requestData = [[Requst_Trainers_Mentors alloc] init];
    self.requestData.lats = @"38.882099";
    self.requestData.longs = @"121.539824";
    self.requestData.pageNo = @"1";
    self.requestData.sortId = @"1";
    self.requestData.keywords = @"";
    _requestData.areaId = @"";
    _requestData.categoryId = @"";
    _requestData.cityId = @"";
    _requestData.maxAge = @"";
    _requestData.minAge = @"";
    _requestData.sex = @"";
    _requestData.skillId = @"";
}
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        
    }
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *backItem = [UIBarButtonItem getBarButtonItemWithImageName:@"navigator_btn_back" HighLightedImageName:@"navigator_btn_back" targetBlock:^{
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    self.navigationItem.leftBarButtonItem = backItem;
    self.tabBarController.tabBar.hidden = YES;
    self.pageInfoArray = [NSMutableArray array];
    
    [self defaultRequestData];
    
    [self requestPageInfo];

    [self createTableView];
    
}
#pragma mark - 创建tableView视图
- (void)createTableView {
        self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 160;
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
        [self.view addSubview:_tableView];
    

    
    
}



#pragma mark - 请求页面信息
- (void)requestPageInfo {
    _requestData.summary = [[NSString stringWithFormat:@"%@%@%@%@", key_API, _requestData.longs, _requestData.lats, _requestData.keywords] stringWith32BitMD5Lower];
    NSString *queryData = [NSString stringWithFormat:@"areaId=%@&categoryId=%@&cityId=%@&keywords=%@&lats=%@&longs=%@&maxAge=%@&minAge=%@&pageNo=%@&sex=%@&skillId=%@&sortId=%@&summary=%@", _requestData.areaId, _requestData.categoryId, _requestData.cityId, _requestData.keywords, self.requestData.lats, self.requestData.longs, _requestData.maxAge, _requestData.minAge, _requestData.pageNo, _requestData.sex, _requestData.skillId, self.requestData.sortId, _requestData.summary];
    
    [HttpClient GET:[NSString stringWithFormat:@"%@?%@",self.urlString, queryData] body:JYX_BodyString headerFile:nil response:JYX_JSON success:^(id result) {
        
        if ([[result objectForKey:@"code"] isEqualToString:@"0"] ) {

//            NSMutableArray *arrayTemp = [NSMutableArray array];
            NSArray *array = [result objectForKey:@"data"];
            for (NSDictionary *dic in array) {
                // 判断是教练或陪练
                if (0 == self.item) {
                    TrainersModel *trainers = [TrainersModel mj_objectWithKeyValues:dic];
                    [self.pageInfoArray addObject:trainers];
                }
                else {
                    MentorsModel *mentors = [MentorsModel mj_objectWithKeyValues:dic];
                    [self.pageInfoArray addObject:mentors];
                }
            }

            
        }
        
        [_tableView reloadData];
        
    } failure:^(NSError *error) {
        
        NSLog(@"error");
        
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
        return self.pageInfoArray.count;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    Trainers_MentorsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[Trainers_MentorsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    } else {
//        NSArray  *arr =  cell.contentView.subviews;
//        for ( UIView *vi  in arr) {
//            //把cell的contentView上面所有的子视图从父类上面移除
//            [vi  removeFromSuperview];
//        }
}
    if (self.item == 0) {
        cell.trainersModel = _pageInfoArray[indexPath.row];
    } else {
        cell.mentorsModel = _pageInfoArray[indexPath.row];
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PersonalDetailsViewController *personalDetailsVC = [[PersonalDetailsViewController alloc] init];
    if (self.item == 0) {
        TrainersModel *trainersModel = _pageInfoArray[indexPath.row];
        personalDetailsVC.memberId = trainersModel.memberId;
    } else {
        MentorsModel *mentorsModel = _pageInfoArray[indexPath.row];
        personalDetailsVC.memberId = mentorsModel.memberId;
    }
    [self.navigationController pushViewController:personalDetailsVC animated:YES];
    
    
    
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
