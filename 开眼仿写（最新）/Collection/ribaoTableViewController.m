//
//  ribaoTableViewController.m
//  开眼放血（最新）
//
//  Created by a on 2017/12/28.
//  Copyright © 2017年 a. All rights reserved.
//

#import "ribaoTableViewController.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "chuangyimodeul.h"
#import "picturecellTableViewCell.h"
#import "CLViewController5.h"
@interface ribaoTableViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
     NSInteger sectioncount;
}



@property(nonatomic,strong)NSMutableArray *datacountarray;
@property(nonatomic,strong)NSMutableArray<chuangyimodeul*>  *modelarray;
//任务管理者
@property(nonatomic,strong)AFHTTPSessionManager *manager;
@property(nonatomic,strong)NSMutableArray<chuangyimodeul*>  *sectionarray;






@end
@implementation ribaoTableViewController


-(NSMutableArray *)datacountarray
{
    if (!_datacountarray) {
        _datacountarray = [[NSMutableArray alloc]init];
    }
    return _datacountarray;
}
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


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    [self setupRefresh];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([picturecellTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"pic"];
    
    
}

- (void)setupRefresh
{
    self.tableView.mj_header=[MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadnewdata)];
    
    [self.tableView.mj_header beginRefreshing];
    NSLog(@"1111111");
    
    self.tableView.mj_footer =[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoredata)];
}


-(void)loadMoredata{
    
    [self.manager GET:self.NextPageURL parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
  
        self.NextPageURL = [NSString stringWithFormat:@"%@",responseObject[@"nextPageUrl"]];
        NSDictionary *dailyListDict = [responseObject objectForKey:@"dailyList"];
        
        for (NSDictionary *videoList in dailyListDict) {

        NSDictionary *itemList = [videoList objectForKey:@"videoList"];
          
            
            
            for (NSDictionary *dict in itemList) {
                
                chuangyimodeul *model = [[chuangyimodeul alloc]init];
                
                

            
            model.coverForFeed = [NSString stringWithFormat:@"%@",dict[@"coverForDetail"]];
            model.title = [NSString stringWithFormat:@"%@",dict[@"title"]];
            model.category = [NSString stringWithFormat:@"%@",dict[@"category"]];
            model.name = [NSString stringWithFormat:@"%@",dict[@"author"][@"name"]];
            model.icon = [NSString stringWithFormat:@"%@",dict[@"author"][@"icon"]];
            model.playUrl = [NSString stringWithFormat:@"%@",dict[@"playUrl"]];
            
            [self.modelarray addObject:model];
            
            
        }
        // 让[刷新控件]结束刷新
        
            
    }
        
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_footer endRefreshing];
    }];
    
    
    
    
    
}

-(void)loadnewdata{
    
    
    [self.manager  GET:@"http://baobab.wandoujia.com/api/v1/feed.bak?num=6&date=20651222" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [responseObject writeToFile:@"/Users/zyf/Desktop/chuangyi1.plist" atomically:YES ];
        
        self.NextPageURL = [NSString stringWithFormat:@"%@",responseObject[@"nextPageUrl"]];
        
        
        NSMutableArray *dailyListDict = [responseObject objectForKey:@"dailyList"];
         sectioncount=dailyListDict.count;
        self.sectionarray = [[NSMutableArray alloc]init];
        
        
        
        
   
            
            for (NSDictionary *data in dailyListDict) {
                
                
                NSString * itemcount=[data objectForKey:@"total"];
                
                [_datacountarray addObject:itemcount];
                NSLog(@"itemcount%@",itemcount);
                NSArray *itemList = [data objectForKey:@"videoList"];
              
                for (NSDictionary *dict in itemList) {
                    
                    chuangyimodeul *model = [[chuangyimodeul alloc]init];
                    
                    
                    model.coverForFeed = [NSString stringWithFormat:@"%@",dict[@"coverForDetail"]];
                    model.title = [NSString stringWithFormat:@"%@",dict[@"title"]];
                    model.category = [NSString stringWithFormat:@"%@",dict[@"category"]];
                    model.name = [NSString stringWithFormat:@"%@",dict[@"author"][@"name"]];
                    model.icon = [NSString stringWithFormat:@"%@",dict[@"author"][@"icon"]];
                    model.playUrl = [NSString stringWithFormat:@"%@",dict[@"playUrl"]];
                    
                    [self.modelarray addObject:model];

                    
                }
                
                [self.sectionarray addObject:self.modelarray];

                  }
        

        // 让[刷新控件]结束刷新
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    
       
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
    }];
    
    
    
    
    
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.zyf_width/2, 50)];
    label.text=@"分区拦";
    label.backgroundColor=[UIColor greenColor];
    return label;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}

-(NSInteger)numberOfSectionsIntableView:(UITableView *)tableView
{
    return sectioncount;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    
    return self.modelarray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    picturecellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pic"];
    //    NSLog(@"%@",_modelarray.count);
    cell.model=self.modelarray[indexPath.section*3+indexPath.row];
    NSLog(@"%ld",(indexPath.section*3+indexPath.row));
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300;
    //    return self.modelarray[indexPath.row].cellHeight;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CLViewController5 *xq = [[CLViewController5 alloc]init];
  
        xq.model =self.modelarray[indexPath.row];
        xq.playurl = self.modelarray[indexPath.row].playUrl;
  
    [self presentViewController:xq animated:YES completion:nil];
    
}


@end
