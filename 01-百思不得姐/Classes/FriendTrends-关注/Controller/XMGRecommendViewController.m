//
//  XMGRecommendViewController.m
//  01-百思不得姐
//
//  Created by apple on 16/1/29.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGRecommendViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "XMGRecommendCategoryCell.h"
#import "XMGRecommendCategory.h"
#import <MJExtension.h>
#import "XMGRecommendUser.h"
#import "XMGRecommendUserCell.h"
@interface XMGRecommendViewController ()<UITableViewDataSource,UITableViewDelegate>

/*左边类别的数据 */
@property (nonatomic, strong) NSArray  *catrgories;
/*右边表格数据 */
@property (nonatomic, strong) NSArray  *users;


@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;

@property (weak, nonatomic) IBOutlet UITableView *userTableView;
@end

@implementation XMGRecommendViewController

 static NSString * const XMGCategoryId = @"category";
 static NSString * const XMGUserId = @"user";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
   
    // Do any additional setup after loading the view from its nib.
   
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    dict[@"a"] = @"category";
//     dict[@"c"] = @"subscribe";
//    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [SVProgressHUD dismiss];
//       // XMGLog(@"%@",responseObject);
//        self.catrgories = [XMGRecommendCategory objectArrayWithKeyValuesArray:responseObject[@"list"]];
//        [self.categoryTableView reloadData];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [SVProgressHUD showErrorWithStatus:@"加载失败"];
//       // XMGLog(@".....");
//    }];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        // 隐藏指示器
        [SVProgressHUD dismiss];
        
        // 服务器返回的JSON数据
        self.catrgories = [XMGRecommendCategory objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 刷新表格
        [self.categoryTableView reloadData];
        
        // 默认选中首行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        // 显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
    }];

   
}
-(void)setupTableView{
     [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([XMGRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:XMGCategoryId];
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([XMGRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:XMGUserId];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
    self.userTableView.rowHeight = 70;
    
    self.navigationItem.title = @"推荐关注";
    self.view.backgroundColor = XMGGlobalBg;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.categoryTableView) {
        return self.catrgories.count;
    }else{
        XMGRecommendCategory *c = self.catrgories[self.categoryTableView.indexPathForSelectedRow.row];
        return c.users.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (tableView == self.categoryTableView) {
         XMGRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:XMGCategoryId];
        cell.category = self.catrgories[indexPath.row];
        return cell;
    }else{
        XMGRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:XMGUserId];
        XMGRecommendCategory *c = self.catrgories[self.categoryTableView.indexPathForSelectedRow.row];
        cell.user = c.users[indexPath.row];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XMGRecommendCategory *c = self.catrgories[indexPath.row];
    if (c.users.count) {
        [self.userTableView reloadData];
    }else{
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"list";
        params[@"c"] = @"subscribe";
        params[@"category_id"] = @(c.id);
        [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //XMGLog(@"%@",responseObject);
            //self.users = [XMGRecommendUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
            NSArray *users = [XMGRecommendUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
            [c.users addObjectsFromArray:users];
            [self.userTableView reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            XMGLog(@"加载失败");
        }];
    }
    
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
