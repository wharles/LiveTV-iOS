//
//  ViewController.m
//  LiveTV
//
//  Created by Koudai on 15/12/17.
//  Copyright © 2015年 Charlies Wang. All rights reserved.
//

#import "TVListViewController.h"
#import "TVPlayerViewController.h"
#import "AboutViewController.h"
#import "Style1TableViewCell.h"
#import "GlobalMacro.h"

#import <HexColors/HexColor.h>

@interface TVListViewController ()

@end

@implementation TVListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.edgesForExtendedLayout = UIRectEdgeNone;
    [self getTVListFormJsonFile];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)getTVListFormJsonFile {
    NSString *path = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"tv.json"];
    //NSString *json = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    //NSLog(@"%@",json);
    NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    self.dataSource = json;
}

#pragma mark - TableView DataSource Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CellIdentifier";
    Style1TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[Style1TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    //add code here
    NSString *str = self.dataSource[indexPath.row][@"name"];
    cell.titleLabel.text = str;
    NSArray *hexColors = @[@"#0094FF", @"#E75F35", @"#4CB24C", @"#FF9400"];
    int x = arc4random() % 100;
    cell.cubeView.backgroundColor = [HXColor colorWithHexString:hexColors[x % hexColors.count]];
    cell.cubeLabel.textColor = [UIColor whiteColor];
    cell.cubeLabel.text = [str substringWithRange:NSMakeRange(0, 1)];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 66;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];// 取消选中
    TVPlayerViewController *tvVC = [[TVPlayerViewController alloc] init];
    tvVC.url = self.dataSource[indexPath.row][@"mobile"];
    tvVC.name = self.dataSource[indexPath.row][@"name"];
    [self presentViewController:tvVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
