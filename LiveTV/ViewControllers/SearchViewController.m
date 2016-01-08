//
//  SearchViewController.m
//  LiveTV
//
//  Created by Charlies Wang on 15/12/19.
//  Copyright © 2015年 Charlies Wang. All rights reserved.
//

#import "SearchViewController.h"
#import "RequestManager.h"
#import "SearchItem.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
//#import "Masonry.h"

@interface SearchViewController ()

@end

@implementation SearchViewController {
    NSInteger pageIndex;
    UIActivityIndicatorView *_lodingView;
    UIView *footView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //搜索框
    CGFloat width = self.view.bounds.size.width;
    UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 36)];
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(8, 5, width - 16, 26)];
    textField.background = [UIImage imageNamed:@"Line"];
    textField.delegate = self;
    textField.placeholder = @"搜索内容";
    [searchView addSubview:textField];
    self.tableView.tableHeaderView = searchView;
    
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
    
    [[[RACObserve([RequestManager sharedManager], searchResult) ignore:nil] deliverOn:RACScheduler.mainThreadScheduler] subscribeNext:^(NSArray *searchResult) {
        if (pageIndex == 0) {
            self.dataSource = searchResult;
        } else {
            NSMutableArray *array = [NSMutableArray arrayWithArray:self.dataSource];
            [array addObjectsFromArray:searchResult];
            self.dataSource = searchResult;
        }
        pageIndex++;
        [self.tableView reloadData];
    }];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@"\n"]) {
        
        //这里写按了ReturnKey 按钮后的代码
        NSString* searchText = [textField.text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSLog(@"%@",searchText);
        if(searchText) {
            pageIndex = 0;
            [[RequestManager sharedManager] startRequestWithRequestId:RequestTypeSearch parameter:@[searchText,@(pageIndex + 1)]];
            return NO;
        }
    }
    return YES;
}

#pragma mark - TableView DataSource Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellIdentifier = @"CellIdentifier";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    //add code here
    SearchItem *item = self.dataSource[indexPath.row];
    cell.textLabel.text = item.albumName;
    return cell;
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
                              //[[RequestManager sharedManager] startRequestWithRequestId:RequestTypeSearch parameter:@[@"",@(pageIndex + 1)]];
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

@end
