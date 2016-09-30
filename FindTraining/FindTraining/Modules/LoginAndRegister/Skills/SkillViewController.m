//
//  SkillViewController.m
//  FindTraining
//
//  Created by Jiang on 16/9/22.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import "SkillViewController.h"
#import "SkillCollectionReusableView.h"
#import "SkillCollectionViewCell.h"
#import "SkillDataModel.h"
#import "ChildrenModel.h"
#import "HomeViewController.h"

static NSString *const cellIdentifier = @"skillCell";
static NSString *const header = @"skillHeader";
@interface SkillViewController ()
<
UICollectionViewDelegate,
UICollectionViewDataSource
>
@property (nonatomic, retain)UICollectionView *collectionView;
//@property (nonatomic, assign)id result;
@property (nonatomic, retain)NSMutableArray *dataArray;
@property (nonatomic, retain)NSMutableArray *skillArray;
@end

@implementation SkillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"选择标签";
    self.dataArray = [NSMutableArray array];
    self.skillArray = [NSMutableArray array];
    
    [self getSkillListData];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(80, 40);
    flowLayout.headerReferenceSize = CGSizeMake(100, 40);
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.frame.size.height - 60) collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
    
    
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[SkillCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
    [_collectionView registerClass:[SkillCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:header];
    
    UIButton *finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:finishButton];
    [finishButton setTitle:@"完成注册" forState:UIControlStateNormal];
    [finishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    finishButton.backgroundColor = [UIColor redColor];
    [finishButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view).offset(0);
        make.height.equalTo(@50);
    }];
    
    [finishButton addTarget:self action:@selector(finishButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    

    
}
// 获取数据
- (void)getSkillListData {
    NSString *summary = [key_API stringWith32BitMD5Lower];
    NSString *urlString = [NSString stringWithFormat:@"%@/wechapi/skill/getSkillList?summary=%@", baseURL, summary];
    [HttpClient GET:urlString body:nil headerFile:nil response:JYX_JSON success:^(id result) {
         NSArray *array = [result objectForKey:@"data"];
        
        NSMutableArray *dataDicArray = [NSMutableArray array];
        for (NSDictionary *dataDic in array) {
            SkillDataModel *skillData = [SkillDataModel mj_objectWithKeyValues:dataDic];
            [dataDicArray addObject:skillData];
        }
        self.dataArray = dataDicArray;
        
        [_collectionView reloadData];
    } failure:^(NSError *error) {
        
    }];
   
}



- (void)finishButtonAction:(UIButton *)button {
    
    NSURL *url = [NSURL URLWithString:[baseURL stringByAppendingString:@""]];
    NSString *urlString = [baseURL stringByAppendingString:@"/wechapi/member/regist"];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    
    NSString *summary_custom = [[@"wech_app2015_en" stringByAppendingString:_reg_InfoModel.cellphone] stringByAppendingString:[NSString stringWithFormat:@"%lld", TIMESTAMP]];;
    NSString *summary = [summary_custom stringWith32BitMD5Lower];
    NSString *passordMD5 = [_reg_InfoModel.password stringWith32BitMD5Lower];
    NSString *skilllds = [_skillArray componentsJoinedByString:@","];
    
    NSString *body = [NSString stringWithFormat:@"cellphone=%@&password=%@&invCode=%@&verifyCode=%@&deviceId=%@&sex=%@&age=%@&nickName=%@&skilllds=%@&timeStamp=%lld&summary=%@", _reg_InfoModel.cellphone, passordMD5, _reg_InfoModel.invCode, _reg_InfoModel.verifyCode, _reg_InfoModel.deviceId,_reg_InfoModel.sex, _reg_InfoModel.age, _reg_InfoModel.nickName, skilllds, TIMESTAMP, summary];
    
    [HttpClient POST:urlString body:body bodyStyle:JYX_BodyString headerFile:nil response:JYX_JSON success:^(id result) {
     
        [UIView showMessage:[NSString stringWithFormat:@"%@", [result objectForKey:@"msg"]]];
        if ([[result objectForKey:@"msg"] isEqualToString:@"success"]) {
            HomeViewController *homeVC = [[HomeViewController alloc] init];
//            homeVC. = self.reg_InfoModel;
            homeVC.navigationItem.title = @"Home";
            [self.navigationController pushViewController:homeVC animated:YES];
        }
        
        [_collectionView reloadData];
        
    } failure:^(NSError *error) {
        
        
    }];
    
    
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _dataArray.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    SkillCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:header forIndexPath:indexPath];
    headerView.backgroundColor = [UIColor colorWithWhite:0.956 alpha:1.000];
    SkillDataModel *skillData = _dataArray[indexPath.section];
    headerView.text = skillData.name;
    
    return headerView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    SkillDataModel *skillData = _dataArray[section];
    return skillData.children.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SkillCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    SkillDataModel *skillData = _dataArray[indexPath.section];
    ChildrenModel *children = skillData.children[indexPath.item];
    cell.text = children.name;
    cell.backgroundColor = [UIColor clearColor];
    cell.isSelected = NO;
    cell.layer.cornerRadius = 10.f;
    cell.layer.borderWidth = 1.0f;
    cell.layer.borderColor = [UIColor lightGrayColor].CGColor;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SkillCollectionViewCell *cell = (SkillCollectionViewCell *)[_collectionView cellForItemAtIndexPath:indexPath];
    [self changeSelectedValue:cell];
   }

- (void)changeSelectedValue:(SkillCollectionViewCell *)cell {
    cell.isSelected = !cell.isSelected;
//    NSLog(@"select : %d", cell.isSelected);
    if (cell.isSelected) {
        [self.skillArray addObject:cell.text];
//        NSLog(@"%@", self.skillArray);
        cell.backgroundColor = [UIColor colorWithRed:0.991 green:0.0684 blue:0.0646 alpha:1.0];
        cell.textColor = [UIColor whiteColor];
    } else {
        [self.skillArray removeObject:cell.text];
        cell.backgroundColor = [UIColor whiteColor];
        cell.textColor = [UIColor lightGrayColor];
//        NSLog(@"%@", self.skillArray);
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
