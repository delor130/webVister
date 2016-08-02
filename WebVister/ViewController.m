//
//  ViewController.m
//  WebVister
//
//  Created by KennethDai on 7/25/16.
//  Copyright © 2016 KennethDai. All rights reserved.
//

#import "ViewController.h"
#import "WVTableViewCell.h"

@interface ViewController ()
{
    
    UITableView *viewsTableView;
    NSArray *urlList;
    WVMode displayMode;
    double cellHeight;
    UIScrollView *scrollView;
    double timeInterval;
}

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    viewsTableView = [[UITableView alloc] init];
    viewsTableView.delegate = self;
    viewsTableView.dataSource = self;
    urlList = @[@"http://www.baidu.com",@"http://www.bing.com",@"http://mail.126.com",@"http://www.google.com",@"http://www.baidu.com",@"http://www.bing.com",@"http://mail.126.com",@"http://www.google.com",@"http://www.baidu.com",@"http://www.bing.com",@"http://mail.126.com",@"http://www.google.com",@"http://www.baidu.com",@"http://www.bing.com",@"http://mail.126.com",@"http://www.google.com"];
    displayMode = WVDisplayOverview;
    self.navigationItem.title = @"WebVister";
    viewsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Mode" style:UIBarButtonItemStylePlain target:self action:@selector(switchMode)];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.leftBarButtonItem = leftButton;
    self.navigationItem.rightBarButtonItem = rightButton;
    
    scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    scrollView.scrollsToTop = YES;
    scrollView.backgroundColor = [UIColor redColor];
    [self.view addSubview:scrollView];
    [scrollView addSubview:viewsTableView];
    viewsTableView.scrollEnabled = NO;
    
    timeInterval = 10 * 60;
    //Min is 10 seconds, shouldn't be lower than that.
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:(timeInterval < 600) ? 600 : timeInterval  target:self selector:@selector(reloadWVData) userInfo:nil repeats:YES];
    [timer fire];
    
    //不让手机休眠.
    [UIApplication sharedApplication].idleTimerDisabled =YES;
}
                      
                      

- (void)viewDidAppear:(BOOL)animated
{
    [self updateViewsFrame];    
}

- (void)reloadWVData
{
    [viewsTableView reloadData];
    [self updateViewsFrame];
    NSLog(@"Data reloaded");
}
                      
- (void) updateViewsFrame
{
    double tableViewHeight = urlList.count * cellHeight + 10;
    CGRect frame = CGRectMake(5, 0, [UIScreen mainScreen].bounds.size.width - 10, tableViewHeight);
    viewsTableView.frame = frame;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, urlList.count * cellHeight);
}

- (void)switchMode
{
    WVMode mode = (displayMode == WVDisplayOverview)?WVDisplayDetails : WVDisplayOverview;
    displayMode = mode;
    [viewsTableView reloadData];
    [self viewDidAppear:YES];
}

- (WVTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = @"webViewCellID";
    WVTableViewCell *viewCell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!viewCell)
    {
        viewCell = [[NSBundle mainBundle] loadNibNamed:@"WVTableViewCell" owner:self options:nil].firstObject;
    }
    viewCell.backgroundColor = ((indexPath.row % 2) == 0) ? [UIColor whiteColor] : [UIColor grayColor];
    [viewCell loadViewWithUrl:urlList[indexPath.row]];
    [viewCell isWebViewHidden:(displayMode == WVDisplayOverview)];
    viewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return viewCell;    
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return urlList.count;
    
}

- (double)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (displayMode == WVDisplayOverview)
    {
        cellHeight = 36;
    } else {
        cellHeight = 150;
    }
    return cellHeight;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
