//
//  shouyeViewController.m
//  tests
//
//  Created by a on 2017/12/23.
//  Copyright © 2017年 a. All rights reserved.
//

#import "shouyeViewController.h"
#import "shopCell.h"
#import "BIGTableViewCell.h"
#import "chuangyimodeul.h"
#import "AFNetworking.h"
#import "picturecellTableViewCell.h"
#import "smallcell.h"
#import "MJRefresh.h"
#import "CLViewController5.h"


@interface shouyeViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)AFHTTPSessionManager *manager;
@property(nonatomic,strong)NSMutableArray<chuangyimodeul*> *titlearray;
@property(nonatomic,strong)NSMutableArray<NSMutableArray*> *neirongarray;


@end

@implementation shouyeViewController


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

-(AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        
    }
    return _manager;
}


- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.zyf_width, self.view.zyf_height) style:UITableViewStyleGrouped];

self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;

    self.view.backgroundColor=[UIColor whiteColor];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([picturecellTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"pic"];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([smallcell class]) bundle:nil] forCellReuseIdentifier:@"smallcell"];
    

    [self setupRefresh];
    
}
- (void)setupRefresh
{
    self.tableView.mj_header=[MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer =[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadData2)];
}
-(void)loadData2
{
    [self.manager  GET:self.NextPageURL parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
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
                 model2.playUrl = [NSString stringWithFormat:@"%@",neirong[@"playUrl"]];
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


-(void)loadData
{
    [self.manager  GET:@"http://baobab.kaiyanapp.com/api/v4/tabs/follow" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
       
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
                  model2.playUrl = [NSString stringWithFormat:@"%@",neirong[@"playUrl"]];
                
                
                [xyz addObject:model2];

            }
            
            [self.neirongarray addObject:xyz];
            
           
            
    }
        
        [self.tableView reloadData];
        
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
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

 return self.neirongarray[collectionView.tag].count;}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CLViewController5 *Videoplay=[[CLViewController5 alloc]init];
    chuangyimodeul *model = self.neirongarray[collectionView.tag][indexPath.row];
    Videoplay.model = model;
    [self presentViewController:Videoplay animated:YES completion:nil];
    
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
      return self.neirongarray.count;;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.neirongarray[section].count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.row) {
        case 1:case 2:case 4:case 5:{
            smallcell *cell = [tableView dequeueReusableCellWithIdentifier:@"smallcell" forIndexPath:indexPath];
       
            cell.model2=self.neirongarray[indexPath.section][indexPath.row];
            
            return cell;
        }
            
            break;
            
            
        default:
        {
            picturecellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pic"];
            if (indexPath.row==0||indexPath.row==3) {
                cell.model=self.neirongarray[indexPath.section][indexPath.row];
            }else{
                cell.model=self.neirongarray[indexPath.section][indexPath.row];            }
            return cell;
        }
            
            
    }
    
        picturecellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pic"];
    
    cell.model=self.neirongarray[indexPath.section][indexPath.row];
          return cell;
}

//返回对应cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
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

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
    return 340;
    }
    return 0;
}



-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section==0) {
        
        UIView *headview =[[UIView alloc]init];
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 350, 60)];
        [label setTextColor:[UIColor blackColor]];
        label.text=@"开眼今日更新 >";
        [headview addSubview:label];
        
        
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    //    设置大小
    layout.itemSize=CGSizeMake(350, 300);
    //设置最小行间隔
    layout.minimumLineSpacing=15;
    //设置方向
    layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    
    CGFloat margin =15;
    
    layout.sectionInset=UIEdgeInsetsMake(0, margin, 0, margin);
    
    //创建一个collectionView 通过布局策略来创建
    UICollectionView* collect = [[UICollectionView alloc]initWithFrame:CGRectMake(0,50, self.view.frame.size.width, 290) collectionViewLayout:layout];
    collect.backgroundColor=[UIColor whiteColor];
    //设置是否可以接受点击事件
    collect.userInteractionEnabled=YES;
    collect.delegate =self;
    collect.dataSource=self;
    collect.tag=section;
    
    //    //注册item类型
    [collect registerNib:[UINib nibWithNibName:NSStringFromClass([shopcell class]) bundle:nil] forCellWithReuseIdentifier:@"shopCell"];
    
    collect.scrollEnabled=YES;
    
    //水平滑动条
    collect.showsHorizontalScrollIndicator=NO;

   [headview addSubview:collect];
         return headview;
  }
    return nil;
   
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CLViewController5 *Videoplay=[[CLViewController5 alloc]init];
    chuangyimodeul *model = self.neirongarray[indexPath.section][indexPath.row];
    
      Videoplay.playurl = model.playUrl;
    Videoplay.model = model;
    [self presentViewController:Videoplay animated:YES completion:nil];
    

}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    NSString *str =@"猜你喜欢 >";
    return str;
    
}

@end
