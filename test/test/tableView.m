//
//  UITableViewController+table_m.h
//  test
//
//  Created by gnway on 2018/9/20.
//  Copyright © 2018年 com.gnway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "tableView.h"

@interface tableView () <UITableViewDelegate, UITableViewDataSource>
@end

@implementation tableView

-(id) initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
  self = [super initWithFrame:frame style:style];
  
  self.delegate = self;
  self.dataSource = self;
  
  self.rowHeight = 56.0f;
  self.estimatedRowHeight = 56.0f;
  
//  self.restorationClass = [self class];
  self.restorationIdentifier = NSStringFromClass([self class]);
  
  UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, 200, 50)];
  [tf setBackgroundColor:[UIColor greenColor]];
  tf.tag = 1999;
  [self addSubview:tf];
  
  return self;
}


// encodeRestorableStateWithCoder is called when the app is suspended to the background
- (void)encodeRestorableStateWithCoder:(NSCoder *)coder
{
  NSLog(@"Child2ViewController: encodeRestorableStateWithCoder");
  
  UITextField *tf = [self viewWithTag:1999];
  
  [coder encodeObject:tf.text forKey:@"txt"];
  [super encodeRestorableStateWithCoder:coder];
}

// decodeRestorableStateWithCoder is called when the app is re-launched
- (void)decodeRestorableStateWithCoder:(NSCoder *)coder
{
  // important: don't affect our views just yet, we might be not visible or we aren't the current
  // view controller, save off our ivars and restore our text view in viewWillAppear
  //
  NSLog(@"Child2ViewController: decodeRestorableStateWithCoder");
  UITextField *tf = [self viewWithTag:1999];
  tf.text = [coder decodeObjectForKey:@"txt"];
  [super decodeRestorableStateWithCoder:coder];
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

