//
//  guanzhuViewController.m
//  tests
//
//  Created by a on 2017/12/23.
//  Copyright © 2017年 a. All rights reserved.
//

#import "guanzhuViewController.h"
#import "shopCell.h"
#import "BIGTableViewCell.h"
#import "chuangyimodeul.h"
#import "AFNetworking.h"
#import "MJRefresh.h"
#import "celltitleview.h"
#import "CLViewController5.h"
@interface guanzhuViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,
UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)AFHTTPSessionManager *manager;
@property(nonatomic,strong)NSMutableArray<chuangyimodeul*> *titlearray;
@property(nonatomic,strong)NSMutableArray<NSMutableArray*> *neirongarray;

@end
@implementation guanzhuViewController
-(AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        
    }
    return _manager;
}
-(NSMutableArray *)titlearray
{
    if (!_titlearray) {
        _titlearray = [[NSMutableArray alloc]init];
        
    }
    return _titlearray;
}

-(NSMutableArray *)neirongarray
{
    if (!_neirongarray) {
        _neirongarray = [[NSMutableArray alloc]init];
        
    }
    return _neirongarray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"推荐关注";
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.zyf_width, self.view.zyf_height) style:UITableViewStyleGrouped];
    
    
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
        [self setupRefresh];
    
    
    
}

- (void)setupRefresh
{
    self.tableView.mj_header=[MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData2)];
    
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer =[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadmoreData2)];
}


-(void)loadData2
{
    [self.manager  GET:@"http://baobab.kaiyanapp.com/api/v4/tabs/follow" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSMutableArray *itemList = [responseObject objectForKey:@"itemList"];         self.NextPageURL = [NSString stringWithFormat:@"%@",responseObject[@"nextPageUrl"]];
        for (int i=0; i<itemList.count; i++) {
            
            NSDictionary *abc = itemList[i];
            NSDictionary *data = [abc objectForKey:@"data"];
            
            //解析标题
            NSDictionary *itemList3=[data objectForKey:@"header"];
            chuangyimodeul *model = [[chuangyimodeul alloc]init];
            model.miaoshu = [NSString stringWithFormat:@"%@",itemList3[@"description"]];
            model.title = [NSString stringWithFormat:@"%@",itemList3[@"title"]];
            model.icon = [NSString stringWithFormat:@"%@",itemList3[@"icon"]];
           
            
            [self.titlearray addObject:model];
            
            
            //解析具体视频内容
            
            NSMutableArray *item = [data objectForKey:@"itemList"];
            NSMutableArray *xyz = [[NSMutableArray alloc]init];
            for (int i=0; i<item.count; i++) {
                NSDictionary *def = item[i];
                NSDictionary *neirong = [def objectForKey:@"data"];
                chuangyimodeul *model2 = [[chuangyimodeul alloc]init];
                
                model2.miaoshu = [NSString stringWithFormat:@"%@",neirong[@"description"]];
                model2.title = [NSString stringWithFormat:@"%@",neirong[@"title"]];
                model2.coverForFeed = [NSString stringWithFormat:@"%@",neirong[@"cover"][@"feed"]];
                model2.icon = [NSString stringWithFormat:@"%@",neirong[@"author"][@"icon"]];
                model2.category = [NSString stringWithFormat:@"#%@",neirong[@"category"]];
                
                [xyz addObject:model2];
                
            }
            
            [self.neirongarray addObject:xyz];
            
            
        }
        
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"数据获取失败");
        [self.tableView.mj_header endRefreshing];
    }];
}


-(void)loadmoreData2
{
    [self.manager  GET:self.NextPageURL parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSMutableArray *itemList = [responseObject objectForKey:@"itemList"];
        self.NextPageURL = [NSString stringWithFormat:@"%@",responseObject[@"nextPageUrl"]];

        for (int i=0; i<itemList.count; i++) {
            
            NSDictionary *abc = itemList[i];
            NSDictionary *data = [abc objectForKey:@"data"];
            
            //解析标题
            NSDictionary *itemList3=[data objectForKey:@"header"];
            chuangyimodeul *model = [[chuangyimodeul alloc]init];
            model.miaoshu = [NSString stringWithFormat:@"%@",itemList3[@"description"]];
            model.title = [NSString stringWithFormat:@"%@",itemList3[@"title"]];
            model.icon = [NSString stringWithFormat:@"%@",itemList3[@"icon"]];
            
            [self.titlearray addObject:model];
            
            
            //解析具体视频内容
            
            NSMutableArray *item = [data objectForKey:@"itemList"];
            NSMutableArray *xyz = [[NSMutableArray alloc]init];
            for (int i=0; i<item.count; i++) {
                NSDictionary *def = item[i];
                NSDictionary *neirong = [def objectForKey:@"data"];
                chuangyimodeul *model2 = [[chuangyimodeul alloc]init];
                
                model2.miaoshu = [NSString stringWithFormat:@"%@",neirong[@"description"]];
                model2.title = [NSString stringWithFormat:@"%@",neirong[@"title"]];
                model2.coverForFeed = [NSString stringWithFormat:@"%@",neirong[@"cover"][@"feed"]];
                model2.icon = [NSString stringWithFormat:@"%@",neirong[@"author"][@"icon"]];
                model2.category = [NSString stringWithFormat:@"#%@",neirong[@"category"]];
                
              
                [xyz addObject:model2];
                
            }
            
            [self.neirongarray addObject:xyz];
            
            
        }
        
        [self.tableView reloadData];
        
        
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"数据获取失败");
        
        [self.tableView.mj_footer endRefreshing];
    }];
}




#pragma collectionview代理方法实现
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    shopcell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"shopCell" forIndexPath:indexPath];
    cell.userInteractionEnabled = YES;
  
    cell.model = self.neirongarray[collectionView.tag][indexPath.row];
   
    
    return cell;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
        return self.neirongarray[collectionView.tag].count;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
        return self.titlearray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 0;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
  
    UITableViewCell * cell =[[UITableViewCell alloc]init];
    return cell;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
   
    
    celltitleview *titlecell =[[celltitleview alloc]init];
    titlecell.model=self.titlearray[section];
    return titlecell;
 
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 280;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 55;
}



-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section

{
    
    UIView *headview =[[UIView alloc]init];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    //    设置大小
    layout.itemSize=CGSizeMake(350, 260);
    //设置最小行间隔
    layout.minimumLineSpacing=15;
    //设置方向
    layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    
    CGFloat margin =15;
    
    layout.sectionInset=UIEdgeInsetsMake(0, margin, 0, margin);
    
    //创建一个collectionView 通过布局策略来创建
    UICollectionView* collect = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 280) collectionViewLayout:layout];
    collect.tag=section;
    collect.backgroundColor=[UIColor whiteColor];
    //设置是否可以接受点击事件
    collect.userInteractionEnabled=YES;
    collect.delegate =self;
    collect.dataSource=self;
    
    //    //注册item类型
    [collect registerNib:[UINib nibWithNibName:NSStringFromClass([shopcell class]) bundle:nil] forCellWithReuseIdentifier:@"shopCell"];
    
    collect.scrollEnabled=YES;
    
    //水平滑动条
    collect.showsHorizontalScrollIndicator=NO;
    [headview addSubview:collect];
    
    return headview;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CLViewController5 *Videoplay=[[CLViewController5 alloc]init];
    chuangyimodeul *model = self.neirongarray[collectionView.tag][indexPath.row];
    Videoplay.model = model;
    [self presentViewController:Videoplay animated:YES completion:nil];
    
    
}





@end
