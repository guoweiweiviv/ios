//
//  table.m
//  collectionViewTest
//
//  Created by gnway on 2018/12/4.
//  Copyright © 2018年 com.gnway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "table.h"

@interface table () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic) NSMutableArray *tableData;
@end

@implementation table

-(void) viewDidLoad
{
  [super viewDidLoad];
  [self makeTableData];
  self.tableView.estimatedRowHeight = 43.5;
  self.tableView.rowHeight  = 43.5;
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
  [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
}

-(void) makeTableData
{
  NSArray *arr0 = @[@"111", @"111", @"111", @"111", @"111", @"111", @"111", @"111", @"111"];
  NSArray *arr1 = @[@"222", @"222", @"222"];
  [self.tableData addObject:arr0];
  [self.tableData addObject:arr1];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
  return [self.tableData count];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  if ([self.tableData count] < section)
    return 0;
  return [[self.tableData objectAtIndex:section] count];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
  if (section == 0) {
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    return view;
  } else if (section == 1) {
    CGSize ss = [UIScreen mainScreen].bounds.size;
    UIView *twoBtns = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ss.width, 30.0f)];
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, ss.width * 0.5f, 30.0f)];
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(ss.width * 0.5f, 0, ss.width * 0.5f, 30.0f)];
    [btn1 setTitle:@"btn1btn1" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn1.tag = 999;
    [btn2 setTitle:@"btn2btn2" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn2.tag = 888;
    [btn1 addTarget:self action:@selector(switchSection1:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 addTarget:self action:@selector(switchSection1:) forControlEvents:UIControlEventTouchUpInside];
    
    [twoBtns addSubview:btn1];
    [twoBtns addSubview:btn2];
    return twoBtns;
  }
  return nil;
}

-(void) switchSection1:(id)sender
{
  UIButton *btn = (UIButton *)sender;
  if (btn.tag == 999) {
    //btn1
    NSArray *arr1 = @[@"222", @"222", @"222"];
    [self.tableData replaceObjectAtIndex:1 withObject:arr1];
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:1];
    [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationLeft];
  } else if (btn.tag == 888) {
    //btn2
    NSArray *arr1 = @[@"333", @"333", @"333", @"333", @"333", @"333", @"333", @"333", @"333"];
    [self.tableData replaceObjectAtIndex:1 withObject:arr1];
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:1];
    [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationRight];
  }
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
  if (section == 0)
    return CGFLOAT_MIN;
  else if (section == 1)
    return 30.0f;
  return CGFLOAT_MIN;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
  if (cell == nil)
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
  NSString *str = [[self.tableData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
  [cell.textLabel setText:str];
  return cell;
}

-(NSMutableArray *)tableData
{
  if (_tableData == nil)
    _tableData = [[NSMutableArray alloc] init];
  return _tableData;
}

@end
