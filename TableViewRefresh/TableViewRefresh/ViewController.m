//
//  ViewController.m
//  TableViewRefresh
//
//  Created by gnway on 2019/3/13.
//  Copyright © 2019年 com.gnway. All rights reserved.
//

#import "ViewController.h"
#import "XYUIScrollView.h"
#import "MJRefresh.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
@property (nonatomic) XYUIScrollView *scrollView;
@property (nonatomic) XYUIScrollView *insideScrollView;
@property (nonatomic) UITableView *tableView;
@property (nonatomic) UIView *view2;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
   self.scrollView = [[XYUIScrollView alloc] initWithFrame:CGRectMake(0, 100, 200, 300)];
  [self.scrollView setBackgroundColor:[UIColor yellowColor]];

  self.insideScrollView = [[XYUIScrollView alloc] initWithFrame:CGRectMake(0, 0, 200, 300)];
  [self.insideScrollView setBackgroundColor:[UIColor redColor]];
  [self.insideScrollView setPagingEnabled:YES];
  self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 200, 400) style:UITableViewStylePlain];
  [self.tableView setBackgroundColor:[UIColor greenColor]];
  [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
  self.tableView.rowHeight = 43.5;
  self.tableView.estimatedRowHeight = 43.5;
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
  [self.tableView setBounces:YES];
  [self.tableView setAlwaysBounceVertical:YES];
 // self.tableView.delaysContentTouches = NO;
  
  self.view2 = [[UIView alloc] initWithFrame:CGRectMake(200, 0, 200, 300)];
  [self.view2 setBackgroundColor:[UIColor blueColor]];
  
  [self.insideScrollView addSubview:self.tableView];
//  [self.insideScrollView addSubview:self.view2];
  [self.insideScrollView setContentSize:CGSizeMake(400, 300)];
  [self.insideScrollView  setBounces:YES];
  [self.insideScrollView setAlwaysBounceVertical:YES];
  self.insideScrollView.delaysContentTouches = NO;
  
  [self.scrollView addSubview:self.insideScrollView];
  [self.scrollView setContentSize:CGSizeMake(200, 300)];
  [self.scrollView setBounces:YES];
  [self.scrollView setAlwaysBounceVertical:YES];
  [self.view addSubview:self.scrollView];
  
  [self makePullUpdate];
}

-(void) makePullUpdate
{
  __weak typeof(self) weakSelf = self;
  __unsafe_unretained UIScrollView *scrollView = self.scrollView;
  scrollView.delaysContentTouches = NO;
  scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
    
    
  }];
  scrollView.mj_footer.automaticallyChangeAlpha = YES;
}

-(void) endMJRefreshing
{
  __unsafe_unretained UIScrollView *scrollView = self.scrollView;
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    // 结束刷新
    [scrollView.mj_header endRefreshing];
  });
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 200;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
  if (cell == nil)
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
  cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
  return cell;
}


-(void) viewWillAppear:(BOOL)animated
{

}

-(void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
  NSLog(@"%@", scrollView);
}


@end
