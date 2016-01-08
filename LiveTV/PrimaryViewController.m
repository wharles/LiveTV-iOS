//
//  BaseViewController.m
//  ZhihuDaily
//
//  Created by Koudai on 15/12/9.
//  Copyright © 2015年 Charlies Wang. All rights reserved.
//

#import "PrimaryViewController.h"
#import "RequestManager.h"
#import "GlobalMacro.h"
#import "Style2TableViewCell.h"
#import "UIImageView+WebCache.h"
#import "Video.h"
#import "DetailViewController.h"

#import <HexColors/HexColor.h>

@interface PrimaryViewController ()

@end

@implementation PrimaryViewController {
    UIActivityIndicatorView *_lodingView;
    NSInteger pageIndex;
    UIView *footView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //防止tableview最后一行被tabbar挡住
    self.tabBarController.edgesForExtendedLayout = UIRectEdgeNone;
    
    //loading more
    float x = 0, y = 0;
    float w = self.view.bounds.size.width;
    float h = 44;
    footView = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    _lodingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _lodingView.center = footView.center;
    _lodingView.tag = 10;
    _lodingView.hidesWhenStopped = YES;
    [footView addSubview:_lodingView];
    self.tableView.tableFooterView = footView;
    
    //pull to refresh control
    self.refreshControl = [[UIRefreshControl alloc]init];
    self.refreshControl.backgroundColor = [UIColor whiteColor];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    self.refreshControl.tintColor = [HXColor colorWithHexString:BARTINTCOLOR alpha:0.3];
    [self.tableView addSubview:self.refreshControl];
    //监听下拉刷新事件
    [[self.refreshControl rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(id x) {
        self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"刷新中..."];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.refreshRequest(x);
        });
    }];
}

- (void)refreshComplete {
    [self.refreshControl endRefreshing];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
}

- (void)registerRequestWithSignal:(RACSignal *)signal requestId:(NSInteger)requestId channelId:(NSInteger) channelId {
    [[RequestManager sharedManager] startRequestWithRequestId:requestId parameter:@[@(channelId),@(pageIndex + 1)]];
    
    self.refreshRequest = ^(id x) {
        pageIndex = 0;
        [[RequestManager sharedManager] startRequestWithRequestId:requestId parameter:@[@(channelId),@(pageIndex + 1)]];
    };
    self.loadMore = ^{
        [[RequestManager sharedManager] startRequestWithRequestId:requestId parameter:@[@(channelId),@(pageIndex + 1)]];
    };
    [[signal deliverOn:RACScheduler.mainThreadScheduler]
     subscribeNext:^(NSArray* videos) {
         if (pageIndex == 0) {
             self.dataSource = videos;
         } else {
             NSMutableArray *array = [NSMutableArray arrayWithArray:self.dataSource];
             [array addObjectsFromArray:videos];
             self.dataSource = array;
         }
         pageIndex++;
         [self.tableView reloadData];
         [self refreshComplete];
     }];
}

#pragma mark - TableView DataSource Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataSource.count % 2 == 0) {
        return self.dataSource.count / 2;
    } else {
        return self.dataSource.count / 2 + 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Style2CellIdentifier";
    Style2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[Style2TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    //add code here
    Video *leftVideo = self.dataSource[2 * indexPath.row];
    cell.leftTitle.text = leftVideo.albumName;
    cell.leftImageLabel.text = [NSString stringWithFormat:@"  %@", leftVideo.recommendTip == nil ? leftVideo.tip : leftVideo.recommendTip];
    [cell.leftImageView sd_setImageWithURL:[NSURL URLWithString:leftVideo.picture16] placeholderImage:[UIImage imageNamed:@"default.png"]];
    cell.leftDetail.text = [NSString stringWithFormat:@"评分：%@", leftVideo.scoreTip];
    
    cell.leftClicked = ^(id x) {
        DetailViewController *detailVC = [[DetailViewController alloc] init];
        detailVC.video = leftVideo;
        [self.navigationController pushViewController:detailVC animated:YES];
    };
    
    //防止数组越界
    if (self.dataSource.count > 2 * indexPath.row + 1) {
        Video *rightVideo = self.dataSource[2 * indexPath.row + 1];
        cell.rightTitle.text = rightVideo.albumName;
        cell.rightImageLabel.text = [NSString stringWithFormat:@"  %@", rightVideo.recommendTip == nil ? rightVideo.tip : rightVideo.recommendTip];
        [cell.rightImageView sd_setImageWithURL:[NSURL URLWithString:rightVideo.picture16] placeholderImage:[UIImage imageNamed:@"default.png"]];
        cell.rightDetail.text = [NSString stringWithFormat:@"评分：%@", rightVideo.scoreTip];
        cell.rightClicked = ^(id x) {
            DetailViewController *detailVC = [[DetailViewController alloc] init];
            detailVC.video = rightVideo;
            [self.navigationController pushViewController:detailVC animated:YES];
        };
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 158;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    BOOL endOfTable = (scrollView.contentOffset.y >= (self.dataSource.count / 2 * 158 - scrollView.frame.size.height));
    //load more data when end of table
    if(endOfTable && !scrollView.isDragging && !scrollView.isDecelerating){
        self.tableView.tableFooterView = footView;
        [(UIActivityIndicatorView*)[footView viewWithTag:10]startAnimating];
        [_lodingView startAnimating];
        //延时2s更新数据
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)),
                       dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                           @synchronized(self) {
                               self.loadMore();
                           }
                           dispatch_async(dispatch_get_main_queue(), ^{
                               [_lodingView stopAnimating];
                           });
                       });
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
