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
#import <MJRefresh.h>


#define XMGSelectCategory self.catrgories[self.categoryTableView.indexPathForSelectedRow.row]

@interface XMGRecommendViewController ()<UITableViewDataSource,UITableViewDelegate>

/*左边类别的数据 */
@property (nonatomic, strong) NSArray  *catrgories;
/*右边表格数据 */
@property (nonatomic, strong) NSArray  *users;


@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;

@property (weak, nonatomic) IBOutlet UITableView *userTableView;

/*请求参数 */
@property (nonatomic, strong) NSMutableDictionary  *prames;



/*AFN管理者 */
@property (nonatomic, strong) AFHTTPSessionManager  *manager;


@end

@implementation XMGRecommendViewController

 static NSString * const XMGCategoryId = @"category";
 static NSString * const XMGUserId = @"user";

-(AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //控件的初始化
    [self setupTableView];
    //下拉刷新
    [self setupRefresh];
    // Do any additional setup after loading the view from its nib.
   
    
    //加载左侧数据
    [self loadCategories];
   
}
-(void)loadCategories{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    self.prames = params;
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (self.prames != params) return ;
        // 隐藏指示器
        [SVProgressHUD dismiss];
        
        // 服务器返回的JSON数据
        //self.catrgories = [XMGRecommendCategory objectArrayWithKeyValuesArray:responseObject[@"list"]];
        self.catrgories = [XMGRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 刷新表格
        [self.categoryTableView reloadData];
        
        // 默认选中首行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        [self.userTableView.mj_header beginRefreshing];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (self.prames != params) return ;
        // 显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
    }];

}
-(void)setupRefresh{
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    self.userTableView.mj_footer.hidden = YES;
}
-(void)loadNewUsers{
    
    XMGRecommendCategory *rc = XMGSelectCategory;
    rc.currentPage = 1;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(rc.id);
    params[@"page"] = @(rc.currentPage);
    self.prames = params;
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         if (self.prames != params) return ;
        //XMGLog(@"%@",responseObject);
        //self.users = [XMGRecommendUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
        NSArray *users = [XMGRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [rc.users addObjectsFromArray:users];
        //保存用户总数
        rc.total = [responseObject[@"total"] integerValue];
        
        [self.userTableView reloadData];
       
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
        [self.userTableView.mj_header endRefreshing];
        if (rc.users.count == rc.total) {
            [self.userTableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.userTableView.mj_footer endRefreshing];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         if (self.prames != params) return ;
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
        [self.userTableView.mj_header endRefreshing];
    }];
}
-(void)loadMoreUsers{
    XMGRecommendCategory *category = XMGSelectCategory;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @([category id]);
    params[@"page"] = @(++category.currentPage);
    self.prames = params;
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         if (self.prames != params) return ;
        //XMGLog(@"%@",responseObject);
        //self.users = [XMGRecommendUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
        NSArray *users = [XMGRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [category.users removeAllObjects];
        [category.users addObjectsFromArray:users];
        
        [self.userTableView reloadData];
        [self checkFooterStater];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         if (self.prames != params) return ;
        XMGLog(@"加载失败");
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
//时刻检查footer的状态
-(void)checkFooterStater{
    XMGRecommendCategory *rc = XMGSelectCategory;
    self.userTableView.mj_footer.hidden = (rc.users.count == 0);

    if (rc.users.count == rc.total) {
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    }else{
        [self.userTableView.mj_footer endRefreshing];
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.categoryTableView)  return self.catrgories.count;
    
   [self checkFooterStater];
   return [XMGSelectCategory users].count;
  
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (tableView == self.categoryTableView) {
         XMGRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:XMGCategoryId];
        cell.category = self.catrgories[indexPath.row];
        return cell;
    }else{
        XMGRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:XMGUserId];
        
        cell.user = [XMGSelectCategory users][indexPath.row];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.userTableView.mj_footer endRefreshing];
    [self.userTableView.mj_header endRefreshing];
    XMGRecommendCategory *c = self.catrgories[indexPath.row];
    if (c.users.count) {
        [self.userTableView reloadData];
    }else{
        [self.userTableView reloadData];
        //进入下拉刷新状态
        [self.userTableView.mj_header beginRefreshing];

           }
    
}

-(void)dealloc{
    [self.manager.operationQueue cancelAllOperations];
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
