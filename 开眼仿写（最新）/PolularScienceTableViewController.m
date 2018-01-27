//
//  PolularScienceTableViewController.m
//  开眼放血（最新）
//
//  Created by a on 2017/12/30.
//  Copyright © 2017年 a. All rights reserved.
//

//
//  musicTableViewController.m
//  开眼放血（最新）
//
//  Created by a on 2017/12/30.
//  Copyright © 2017年 a. All rights reserved.
//


#import "PolularScienceTableViewController.h"
#import "picturecellTableViewCell.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "chuangyimodeul.h"
#import "headview.h"
#import "xiangqingViewController.h"
#import "CLViewController5.h"
#import "smallcell.h"
#import "shopcell.h"
@interface PolularScienceTableViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *dataarray;
@property(nonatomic,strong)NSMutableArray<chuangyimodeul*>  *modelarray;

@property(nonatomic,strong)NSMutableArray  *allarray;


@property(nonatomic,strong)NSMutableArray  *randarray;
//任务管理者
@property(nonatomic,strong)AFHTTPSessionManager *manager;

@end

@implementation PolularScienceTableViewController



-(NSMutableArray *)modelarray
{
    if (!_modelarray) {
        _modelarray = [[NSMutableArray alloc]init];
    }
    return _modelarray;
}

-(NSMutableArray *)randarray
{
    if (!_randarray) {
        _randarray = [[NSMutableArray alloc]init];
    }
    return _randarray;
}
-(AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        
    }
    return _manager;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.zyf_width, self.view.zyf_height) style:UITableViewStyleGrouped];
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([picturecellTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"pic"];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([smallcell class]) bundle:nil] forCellReuseIdentifier:@"smallcell"];
    
    
    [self setupRefresh];
    
    
    
    
}

- (void)setupRefresh
{
    self.tableView.mj_header=[MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadnewdata)];
    
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer =[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoredata)];
}


-(void)loadMoredata{
    
    [self.manager GET:self.NextPageURL parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        self.NextPageURL = [NSString stringWithFormat:@"%@",responseObject[@"nextPageUrl"]];
        
        NSDictionary *itemList = [responseObject objectForKey:@"videoList"];
        
        NSLog(@"%@",itemList);
        for (NSDictionary *dict in itemList) {
            
            chuangyimodeul *model = [[chuangyimodeul alloc]init];
            
            model.coverForFeed = [NSString stringWithFormat:@"%@",dict[@"coverForDetail"]];
            model.miaoshu= [NSString stringWithFormat:@"%@",dict[@"description"]];
            model.title = [NSString stringWithFormat:@"%@",dict[@"title"]];
            model.category = [NSString stringWithFormat:@"%@",dict[@"category"]];            model.name = [NSString stringWithFormat:@"%@",dict[@"author"][@"name"]];
            model.icon = [NSString stringWithFormat:@"%@",dict[@"author"][@"icon"]];
            model.playUrl = [NSString stringWithFormat:@"%@",dict[@"playUrl"]];
            
            [self.modelarray addObject:model];
            
            
        }
        
        [self.randarray removeAllObjects];
        // 让[刷新控件]结束刷新
        
        
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_footer endRefreshing];
    }];
    
    
    
    
    
}

-(void)loadnewdata{
    
    
    [self.manager  GET:@"http://baobab.wandoujia.com/api/v1/videos.bak?strategy=date&categoryName=%E7%A7%91%E6%99%AE&num=30" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        
        self.NextPageURL = [NSString stringWithFormat:@"%@",responseObject[@"nextPageUrl"]];
        
        NSDictionary *itemList = [responseObject objectForKey:@"videoList"];
        
        for (NSDictionary *dict in itemList) {
            
            chuangyimodeul *model = [[chuangyimodeul alloc]init];
            
            
            
            
            model.coverForFeed = [NSString stringWithFormat:@"%@",dict[@"coverForDetail"]];
            model.title = [NSString stringWithFormat:@"%@",dict[@"title"]];
            model.miaoshu= [NSString stringWithFormat:@"%@",dict[@"author"][@"name"]];
            
            model.category = [NSString stringWithFormat:@"%@",dict[@"category"]];
            model.name = [NSString stringWithFormat:@"%@",dict[@"author"][@"name"]];
            model.icon = [NSString stringWithFormat:@"%@",dict[@"author"][@"icon"]];
            model.playUrl = [NSString stringWithFormat:@"%@",dict[@"playUrl"]];
            
            [self.modelarray addObject:model];
            
            
        }
        // 让[刷新控件]结束刷新
        
        
        [self.randarray removeAllObjects];
        for (int i=0; i<6; i++) {
            
            int randomcount = (arc4random() % 30);
            [self.randarray addObject:[NSNumber numberWithInteger:randomcount]];
            
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
    }];
    
    
    
}



-(NSInteger)numberOfSectionsIntableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelarray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.row) {
        case 1:case 2:case 4:case 5:{
            smallcell *cell = [tableView dequeueReusableCellWithIdentifier:@"smallcell" forIndexPath:indexPath];
            
            cell.model2=self.modelarray[[self.randarray[indexPath.row] integerValue]];
            
            return cell;
        }
            
            break;
            
            
        default:
        {
            picturecellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pic"];
            if (indexPath.row==0||indexPath.row==3) {
                cell.model=self.modelarray[[self.randarray[indexPath.row] integerValue]];
            }else{
                cell.model=self.modelarray[indexPath.row-6];
            }
            return cell;
        }
            
            
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.row) {
        case 1:case 2:case 4:case 5:{
            return 150;
        }
            break;
            
        default:
        {
            return 300;
        }
            
            
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.zyf_width/2, 50)];
    label.text=@"正在刷新";
    label.backgroundColor=[UIColor greenColor];
    return label;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CLViewController5 *xq = [[CLViewController5 alloc]init];
    if (indexPath.row<6) {
        xq.model =  self.modelarray[[self.randarray[indexPath.row] integerValue]];
        xq.playurl = self.modelarray[[self.randarray[indexPath.row] integerValue]].playUrl;
    }else{
        xq.model =self.modelarray[indexPath.row];
        xq.playurl = self.modelarray[indexPath.row].playUrl;
    }
    [self presentViewController:xq animated:YES completion:nil];
    
}



@end




