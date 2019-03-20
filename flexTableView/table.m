//
//  table.m
//  flexTableView
//
//  Created by gnway on 2018/11/9.
//  Copyright © 2018年 com.gnway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "table.h"
#import "flexTableCell.h"
#import "flexTableCell2.h"
#import "flexTableCell3.h"

@interface table () <UITextViewDelegate, UITableViewDelegate, UITableViewDataSource>
@end

@implementation table

-(instancetype) initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
  self = [super initWithFrame:frame style:style];
  self.estimatedRowHeight = 44.0f;
  self.rowHeight  = UITableViewAutomaticDimension;
  self.delegate = self;
  self.dataSource = self;
  
  [self registerClass:[flexTableCell3 class] forCellReuseIdentifier:@"flexTableCell3"];
   [self registerClass:[flexTableCell2 class] forCellReuseIdentifier:@"flexTableCell2"];
  return self;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 100;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (indexPath.row % 2 == 0) {
 // flexTableCell3 *cell = [self.tableView dequeueReusableCellWithIdentifier:@"flexTableCell3"];
  flexTableCell2 *cell = [self dequeueReusableCellWithIdentifier:@"flexTableCell2"];
 // cell.tView.delegate = self;
 // cell.tView1.delegate = self;
  [cell configCell:nil];
  return cell;
  } else {
     flexTableCell3 *cell = [self dequeueReusableCellWithIdentifier:@"flexTableCell3"];
   // flexTableCell2 *cell = [self.tableView dequeueReusableCellWithIdentifier:@"flexTableCell2"];
    // cell.tView.delegate = self;
    // cell.tView1.delegate = self;
    [cell configCell:nil];
    return cell;
  }
  return nil;
}

-(void) textViewDidChange:(UITextView *)textView
{
  [self performBatchUpdates:^{
    
  } completion:^(BOOL finished) {
    
  }];
}

-(void) updateConstraints
{
  [self layoutIfNeeded];
  CGSize size = self.contentSize;
 // self.tableViewHeight.constant = min(300, self.tableView.contentSize.height)
 // self.constraints
  NSArray *arr = [self constraints];
  NSLayoutConstraint *heightConstraint = nil;
  for (NSLayoutConstraint *constraint in arr) {
    if (constraint.firstItem == self && constraint.firstAttribute == NSLayoutAttributeHeight)
      heightConstraint = constraint;
  }
  
  if (heightConstraint == nil) {
    heightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:size.height];
    [heightConstraint setPriority:UILayoutPriorityRequired];
    [self addConstraint:heightConstraint];
  }
  heightConstraint.constant = size.height;
  [super updateConstraints];
}

@end
