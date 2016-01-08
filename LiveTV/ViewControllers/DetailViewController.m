//
//  DetailViewController.m
//  LiveTV
//
//  Created by Charlies Wang on 15/12/19.
//  Copyright © 2015年 Charlies Wang. All rights reserved.
//

#import "DetailViewController.h"
#import "GlobalMacro.h"
#import "RequestManager.h"
#import "TVPlayerViewController.h"
#import "VideoDetail.h"
#import "ItemCollectionViewCell.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "UIImageView+WebCache.h"
#import "Masonry.h"
#import <HexColors/HexColor.h>

@interface DetailViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UIImageView *titleImageView;

@end

@implementation DetailViewController {
    NSArray *dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [HXColor colorWithHexString:SELECTEDCOLOR];
    self.title = self.video.albumName;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    CGFloat height = (11.0f / 8.0f) * ((self.view.bounds.size.width - 36.0f) / 2.0f);
    CGFloat spacing = 8.0f;
    CGFloat margin = 4.0f;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    UIView *container = [UIView new];
    [scrollView addSubview:container];
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(scrollView);
        make.width.mas_equalTo(scrollView);
    }];
    
    UIView *rightView = [UIView new];
    rightView.backgroundColor = MAINCOLOR;
    self.titleImageView = [UIImageView new];
    [self.titleImageView sd_setImageWithURL:[NSURL URLWithString:self.video.picture12] placeholderImage:nil];
    [container addSubview:self.titleImageView];
    [container addSubview:rightView];
    [self.titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(container.mas_left).with.offset(spacing);
        make.right.equalTo(rightView.mas_left).with.offset(-spacing);
        make.height.mas_equalTo(height);
        make.width.mas_equalTo(rightView);
        make.top.equalTo(container.mas_top).with.offset(spacing);
    }];
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleImageView.mas_right).with.offset(spacing);
        make.right.equalTo(container).with.offset(-spacing);
        make.height.mas_equalTo(self.titleImageView);
        make.width.mas_equalTo(self.titleImageView);
        make.top.equalTo(container.mas_top).with.offset(spacing);
    }];
    
    //简介的view
    NSString *strText = [NSString stringWithFormat:@"简介：%@", self.video.albumDesc];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont fontWithName:@"AvenirNextCondensed-Regular" size:15] forKey:NSFontAttributeName];
    CGSize size = [strText boundingRectWithSize:CGSizeMake(self.view.bounds.size.width - 24, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    UIView *descView = [UIView new];
    descView.backgroundColor = MAINCOLOR;
    [container addSubview:descView];
    [descView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(container).with.offset(spacing);
        make.right.equalTo(container).with.offset(-spacing);
        make.height.mas_equalTo(size.height + 8);
        make.top.equalTo(self.titleImageView.mas_bottom).with.offset(spacing);
    }];
    
    UILabel *descLabel = [UILabel new];
    descLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-Regular" size:15];
    descLabel.text = strText;
    descLabel.numberOfLines = 0;
    descLabel.textColor = MAINFONTCOLOR;
    [descView addSubview:descLabel];
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(descView).with.insets(UIEdgeInsetsMake(margin, margin, margin, margin));
    }];
    
    //确定是水平滚动，还是垂直滚动
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.collectionView.dataSource=self;
    self.collectionView.delegate=self;
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
    
    //注册Cell，必须要有
    [self.collectionView registerClass:[ItemCollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    self.collectionView.backgroundColor = MAINCOLOR;
    [container addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(container).with.offset(spacing);
        make.right.equalTo(container).with.offset(-spacing);
        make.height.mas_equalTo(@(56)).priorityLow();
        make.top.equalTo(descLabel.mas_bottom).with.offset(spacing);
    }];
    
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.collectionView.mas_bottom);
    }];
    
    //右边view的标签们
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.numberOfLines = 0;
    titleLabel.textColor = MAINFONTCOLOR;
    titleLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-Regular" size:15];
    titleLabel.text = [NSString stringWithFormat:@"类型：%@", self.video.cateName];
    [rightView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(rightView.mas_left).with.offset(margin);
        make.top.equalTo(rightView.mas_top).with.offset(margin);
        make.right.equalTo(rightView.mas_right).with.offset(-margin);
    }];
    UILabel *yearLabel = [UILabel new];
    yearLabel.textColor = MAINFONTCOLOR;
    yearLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-Regular" size:15];
    if ([self.video.year isEqual:@"0"]) {
        yearLabel.text = [NSString stringWithFormat:@"更新：%@", self.video.showDate];
    } else {
        yearLabel.text = [NSString stringWithFormat:@"年份：%@", self.video.year];
    }
    [rightView addSubview:yearLabel];
    [yearLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(rightView.mas_left).with.offset(margin);
        make.top.equalTo(titleLabel.mas_bottom).with.offset(spacing);
        make.right.equalTo(rightView.mas_right);
        make.height.mas_equalTo(@(21));
    }];
    UILabel *mainActorLabel = [UILabel new];
    mainActorLabel.textColor = MAINFONTCOLOR;
    mainActorLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-Regular" size:15];
    mainActorLabel.numberOfLines = 0;
    if (self.video.mainActor == nil) {
        mainActorLabel.text = [NSString stringWithFormat:@"嘉宾：%@", self.video.guest];
    } else {
        mainActorLabel.text = [NSString stringWithFormat:@"主演：%@", self.video.mainActor];
    }

    [rightView addSubview:mainActorLabel];
    [mainActorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(rightView.mas_left).with.offset(margin);
        make.top.equalTo(yearLabel.mas_bottom).with.offset(spacing);
        make.right.equalTo(rightView.mas_right).with.offset(-margin);
    }];
    UILabel *directorLabel = [UILabel new];
    directorLabel.textColor = MAINFONTCOLOR;
    directorLabel.numberOfLines = 0;
    directorLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-Regular" size:15];
    if (self.video.director == nil) {
        directorLabel.text = [NSString stringWithFormat:@"地区：%@", self.video.area];
    } else {
        directorLabel.text = [NSString stringWithFormat:@"导演：%@", self.video.director];
    }
    [rightView addSubview:directorLabel];
    [directorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(rightView.mas_left).with.offset(margin);
        make.top.equalTo(mainActorLabel.mas_bottom).with.offset(spacing);
        make.right.equalTo(rightView.mas_right).with.offset(-margin);
    }];
    UILabel *scoreLabel = [UILabel new];
    scoreLabel.textColor = MAINFONTCOLOR;
    scoreLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-Regular" size:15];
    scoreLabel.text = [NSString stringWithFormat:@"评分：%@", self.video.scoreTip];
    [rightView addSubview:scoreLabel];
    [scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(rightView.mas_left).with.offset(margin);
        make.top.equalTo(directorLabel.mas_bottom).with.offset(spacing);
        make.right.equalTo(rightView.mas_right).with.offset(-margin);
    }];
    
    [[RequestManager sharedManager] startRequestWithRequestId:RequestTypeDetail parameter:@[@(self.video.aid)]];
    
    [[[RACObserve([RequestManager sharedManager], videoDetail) ignore:nil] deliverOn:RACScheduler.mainThreadScheduler]
     subscribeNext:^(NSArray* videos) {
         dataSource = videos;
         //修改高度
         CGFloat width = self.view.bounds.size.width;
         CGFloat numOfcell = floor((width - 16.0) / 58.0);
         CGFloat height = ceil(dataSource.count / numOfcell) * 58;
         [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
             make.height.mas_equalTo(@(height));
         }];
         [self.collectionView reloadData];
     }];
}


#pragma mark -- UICollectionViewDataSource

//定义展示的UICollectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (dataSource.count <= 50) {
        return dataSource.count;
    } else {
        return dataSource.count + 1;
    }
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"UICollectionViewCell";
    ItemCollectionViewCell * cell = (ItemCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    if(indexPath.row <= dataSource.count) {
        VideoDetail *detail = dataSource[indexPath.row];
        cell.title = [NSString stringWithFormat:@"%ld", (long)detail.videoOrder];
    } else {
        cell.title = @"更多";
    }
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(48, 48);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

#pragma mark --UICollectionViewDelegate

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    TVPlayerViewController *tvVC = [[TVPlayerViewController alloc] init];
    VideoDetail *videoDetail = dataSource[indexPath.row];
    tvVC.url = [NSString stringWithFormat:@"%@%@", videoDetail.urlHigh, DOWNLOADSTRING];
    tvVC.name = videoDetail.videoName;
    [self presentViewController:tvVC animated:YES completion:nil];
}

//返回这个UICollectionView是否可以被选择
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
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
