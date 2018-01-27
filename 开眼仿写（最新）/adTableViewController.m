//  chuangyiViewController.m
//  开眼放血（最新）
//
//  Created by a on 2017/12/28.
//  Copyright © 2017年 a. All rights reserved.
//

#import "adTableViewController.h"

#import "picturecellTableViewCell.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "chuangyimodeul.h"
#import "headview.h"
#import "VideoPlayViewController.h"

@interface adTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *dataarray;
@property(nonatomic,strong)NSMutableArray<chuangyimodeul*>  *modelarray;
//任务管理者
@property(nonatomic,strong)AFHTTPSessionManager *manager;

@end

@implementation adTableViewController



-(NSMutableArray *)modelarray
{
    if (!_modelarray) {
        _modelarray = [[NSMutableArray alloc]init];
    }
    return _modelarray;
}
-(AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        
    }
    return _manager;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
      chuangyimodeul *model= self.modelarray[indexPath.section*3+indexPath.row];
    VideoPlayViewController *videoPlay = [[VideoPlayViewController alloc]init];
    videoPlay.UrlString = model.playUrl;
    videoPlay.titleStr = model.title;
//    videoPlay.duration = [self.model.duration floatValue];
    [self.navigationController pushViewController:videoPlay animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    UITableView * tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.zyf_width, self.view.zyf_height) style:UITableViewStyleGrouped];

    self.tableView=tableview;
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    [self setupRefresh];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([picturecellTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"pic"];
    
    
}



- (void)setupRefresh
{
    self.tableView.mj_header=[MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadnewdata)];
    
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer =[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoredata)];
}


-(void)loadMoredata{
    
    [self.manager GET:self.NextPageURL parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [responseObject writeToFile:@"/Users/zyf/Desktop/chuangyi1.plist" atomically:YES ];
        
        self.NextPageURL = [NSString stringWithFormat:@"%@",responseObject[@"nextPageUrl"]];
        
        NSDictionary *itemList = [responseObject objectForKey:@"videoList"];
        
        for (NSDictionary *dict in itemList) {
            
            chuangyimodeul *model = [[chuangyimodeul alloc]init];
            
            
            
            
            model.coverForFeed = [NSString stringWithFormat:@"%@",dict[@"coverForDetail"]];
            model.title = [NSString stringWithFormat:@"%@",dict[@"title"]];
            model.category = [NSString stringWithFormat:@"%@",dict[@"category"]];            model.name = [NSString stringWithFormat:@"%@",dict[@"author"][@"name"]];
            model.icon = [NSString stringWithFormat:@"%@",dict[@"author"][@"icon"]];
            model.playUrl = [NSString stringWithFormat:@"%@",dict[@"playUrl"]];
            
            [self.modelarray addObject:model];
            
            
        }
        // 让[刷新控件]结束刷新
        
        
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_footer endRefreshing];
    }];
    
    
    
    
    
}

-(void)loadnewdata{
    
    
    [self.manager  GET:@"http://baobab.wandoujia.com/api/v1/videos.bak?strategy=date&categoryName=%E5%B9%BF%E5%91%8A&num=30" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        self.NextPageURL = [NSString stringWithFormat:@"%@",responseObject[@"nextPageUrl"]];
        
        NSDictionary *itemList = [responseObject objectForKey:@"videoList"];
        
        for (NSDictionary *dict in itemList) {
            
            chuangyimodeul *model = [[chuangyimodeul alloc]init];
            
            
            
            
            model.coverForFeed = [NSString stringWithFormat:@"%@",dict[@"coverForDetail"]];
            model.title = [NSString stringWithFormat:@"%@",dict[@"title"]];
            model.category = [NSString stringWithFormat:@"#%@",dict[@"category"]];
            model.name = [NSString stringWithFormat:@"%@",dict[@"author"][@"name"]];
            model.icon = [NSString stringWithFormat:@"%@",dict[@"author"][@"icon"]];
            model.playUrl = [NSString stringWithFormat:@"%@",dict[@"playUrl"]];
            NSLog(@"%@",model.playUrl);
            [self.modelarray addObject:model];
            
            
        }
        // 让[刷新控件]结束刷新
        
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
    }];
    
    
    
    
    
}




-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    
    NSMutableArray *numberarray = [[NSMutableArray alloc]init];
    for(int i =0;i<6;i++)
    {
        int randomcount = (arc4random() % 30);
        [numberarray addObject:[NSNumber numberWithInteger:randomcount]];
        
    }
    
    
    headview *head = [[headview alloc]initWithFrame:CGRectMake(0, 0, 375, 500)];
    if (self.modelarray.count) {
        
        head.model0 = self.modelarray[[numberarray[0] integerValue]];
        head.model1 = self.modelarray[[numberarray[1] integerValue]];
        
        head.model2 = self.modelarray[[numberarray[2] integerValue]];
        
        head.model3 = self.modelarray[[numberarray[3] integerValue]];
        
        head.model4 = self.modelarray[[numberarray[4] integerValue]];
        
        head.model5 = self.modelarray[[numberarray[5] integerValue]];
       
    
   
    }
    
 
    
    return head;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1230;
}

-(NSInteger)numberOfSectionsIntableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return self.modelarray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    picturecellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pic"];
    cell.model=self.modelarray[indexPath.section*3+indexPath.row];
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300;
}



@end
