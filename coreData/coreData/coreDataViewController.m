//
//  coreDataViewController.m
//  coreData
//
//  Created by gnway on 2018/9/29.
//  Copyright © 2018年 com.gnway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "coreDataViewController.h"
#import "coredataTools.h"
#import "Table1+CoreDataClass.h"

@interface coreDataViewController ()
@property (nonatomic)  coredataTools *tool;
@property (nonatomic) NSArray *coredata_id;
@end

@implementation coreDataViewController

-(void) viewDidLoad
{
  [super viewDidLoad];
  self.tableView.estimatedRowHeight = 56.0f;
  self.tableView.rowHeight = 56.0f;
  
  _tool = [coredataTools sharedInstance];
  [_tool loadDB:@"coreDataModel" stroeFilePath:@"coreDataModel.store"];
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tableNotify:) name:NSManagedObjectContextObjectsDidChangeNotification object:nil];
  
  UITextView *txtView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
  [txtView setBackgroundColor:[UIColor redColor]];
  [self.tableView setTableFooterView:txtView];
  [self.tableView setKeyboardDismissMode:UIScrollViewKeyboardDismissModeOnDrag];
}


-(void) viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  [self loadDataFromDB];
  
  NSLog(@"%p, %@", self.dict, self.dict);
  for (id key in [self.dict allKeys]) {
    NSLog(@"%p", key);
  }
  
  for (id val in [self.dict allValues]) {
    NSLog(@"%p", val);
  }
}

-(void) tableNotify:(NSNotification *)notify
{
  NSLog(@"%@", notify.name);
  NSDictionary *data =  notify.userInfo;
  if ([[data allKeys] containsObject:NSInsertedObjectsKey]) {
    NSManagedObject *obj = [data objectForKey:NSInsertedObjectsKey];
    NSLog(@"%@", obj);
  } else if ([[data allKeys] containsObject:NSUpdatedObjectsKey]) {
    NSArray *arr = [data objectForKey:NSUpdatedObjectsKey];
    
  }
 
  [self loadDataFromDB];
}

-(void) loadDataFromDB
{
  __weak typeof(self) weakSelf = self;
  [_tool dbActionBG:^bool(NSManagedObjectContext *context) {
    NSFetchRequest *request = [Table1 fetchRequest];
    request.resultType = NSManagedObjectIDResultType;
    NSError *err = nil;
    NSArray *rst = [context executeFetchRequest:request error:&err];
    if (!err) {
      NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:rst];
      weakSelf.coredata_id = arr;
      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         [weakSelf.tableView reloadData];
      });
     
    } else {
      NSLog(@"%@", err);
    }
    return NO;
  }];
}

-(void) changeObject
{
  [_tool dbActionBG:^bool(NSManagedObjectContext *context) {
    return NO;
  }];
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  if (self.coredata_id)
    return [self.coredata_id count];
  return 0;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
  if (cell == nil)
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];

  NSManagedObjectID *tab_id = [self.coredata_id objectAtIndex:indexPath.row];
  __block Table1 *tab1 = nil;
  [_tool dbActionWait:^bool(NSManagedObjectContext *context) {
    NSError *err = nil;
    Table1 *tab = [context existingObjectWithID:tab_id error:&err];
    if (!tab) {
      NSLog(@"%@", err);
    } else
      tab1 = tab;
    return NO;
  }];
//  NSLog(@"%@", tab1.item2);
  [cell.textLabel setText:tab1.item2];
//  [cell.detailTextLabel setText:@"222"];
  return cell;
}

@end
