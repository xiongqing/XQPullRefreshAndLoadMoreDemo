//
//  XQMainViewController.m
//  XQPullRefreshAndLoadMoreDemo
//
//  Created by HySoft on 14-2-24.
//  Copyright (c) 2014年 HySoft. All rights reserved.
//

#import "XQMainViewController.h"

@interface XQMainViewController ()

@end

@implementation XQMainViewController
@synthesize pullTableView = _pullTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(!self.pullTableView.pullTableIsRefreshing)
    {
        self.pullTableView.pullTableIsRefreshing = YES;
        [self performSelector:@selector(refreshTable) withObject:nil afterDelay:3.0f];
    }
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self setPullTableView:nil];
}

-(void)refreshTable
{NSLog(@"刷新");
    self.pullTableView.pullLastRefreshDate = [NSDate date];
    self.pullTableView.pullTableIsRefreshing = NO;
}

-(void)loadMoreDataToTable
{NSLog(@"加载更多");
    self.pullTableView.pullTableIsLoadingMore = NO;
}

-(void)loadView
{
    [super loadView];
    
//    self.pullTableView = [[PullTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        self.pullTableView = [[PullTableView alloc] initWithFrame:CGRectMake(0.f, 20.f, self.view.bounds.size.width, self.view.bounds.size.height-20.f) style:UITableViewStylePlain];
    }
    else
    {
        self.pullTableView = [[PullTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    }
    self.pullTableView.dataSource = self;
    self.pullTableView.delegate = self;
    self.pullTableView.pullDelegate = self;
    self.pullTableView.backgroundColor = [UIColor clearColor];
    self.pullTableView.backgroundView = nil;
    [self.view addSubview:self.pullTableView];
    [self.pullTableView release];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"Row %i", indexPath.row];
    
    return cell;
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"Section %i begins here!", section];
}

- (NSString *) tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"Section %i ends here!", section];
    
}

#pragma mark - PullTableViewDelegate

- (void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView
{
    [self performSelector:@selector(refreshTable) withObject:nil afterDelay:3.0f];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView
{
    [self performSelector:@selector(loadMoreDataToTable) withObject:nil afterDelay:3.0f];
}

@end
