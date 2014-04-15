//
//  XQMainViewController.h
//  XQPullRefreshAndLoadMoreDemo
//
//  Created by HySoft on 14-2-24.
//  Copyright (c) 2014年 HySoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullTableView.h"

@interface XQMainViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,PullTableViewDelegate>
{
    PullTableView *_pullTableView;
}

@property (nonatomic,retain) PullTableView *pullTableView;

-(void)refreshTable;
-(void)loadMoreDataToTable;

@end
