//
//  UITableViewController+table_m.h
//  test
//
//  Created by gnway on 2018/9/20.
//  Copyright © 2018年 com.gnway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "tableViewController.h"

@interface tableViewController () <UITableViewDelegate, UITableViewDataSource, UIViewControllerRestoration>
@end

@implementation tableViewController

-(id) init
{
  self = [super initWithStyle:UITableViewStylePlain];
  
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
  
  self.tableView.rowHeight = 56.0f;
  self.tableView.estimatedRowHeight = 56.0f;
  
  self.restorationClass = [self class];
  self.restorationIdentifier = NSStringFromClass([self class]);
  
  return self;
}

- (void) encodeRestorableStateWithCoder:(NSCoder *)coder
{
  
}

- (void) decodeRestorableStateWithCoder:(NSCoder *)coder
{
  
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"xxx"];
  
  [cell.textLabel setText:@"xxxx"];
  return cell;
}

@end

