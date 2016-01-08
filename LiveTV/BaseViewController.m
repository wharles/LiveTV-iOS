//
//  BaseViewController.m
//  LiveTV
//
//  Created by Koudai on 15/12/29.
//  Copyright © 2015年 Charlies Wang. All rights reserved.
//

#import "BaseViewController.h"
#import <HexColors/HexColor.h>
#import "GlobalMacro.h"

@interface BaseViewController ()

@end

@implementation BaseViewController {
    NSString* navTitle;
}

- (nullable id)initWithTitle:(nullable NSString*)title image:(nullable UIImage *)image selectedImage:(nullable UIImage *)selectedImage {
    if (self = [super init]) {
        
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        navTitle = title;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //初始化TableView
    self.tableView = [[UITableView alloc] init];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.pagingEnabled = YES;
    self.tableView.separatorColor = [HXColor colorWithHexString:SPLITLINECOLOR];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 8, 0, 8);
    [self.view addSubview:self.tableView];
}

#pragma mark - View Settings

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (navTitle) {
        self.tabBarController.title = [NSString stringWithFormat:@"CW视频·%@", navTitle];
    } else {
        self.tabBarController.title = @"CW视频";
    }
}

#pragma mark - data source 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGRect bounds = self.view.bounds;
    self.tableView.frame = bounds;
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
