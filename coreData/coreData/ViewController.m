//
//  ViewController.m
//  coreData
//
//  Created by gnway on 2018/9/28.
//  Copyright © 2018年 com.gnway. All rights reserved.
//

#import "ViewController.h"
#import "coreDataViewController.h"
#import "coredataTools.h"
#import "Table1+CoreDataClass.h"
#import "Table2+CoreDataClass.h"

@interface ViewController ()
@property (nonatomic) coredataTools *tool;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
  _tool = [coredataTools sharedInstance];
  [_tool loadDB:@"coreDataModel" stroeFilePath:@"coreDataModel.store"];
  
//  [self testCoreData];
//   [self insetDataForTest];
  
//  NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(changeDataForTest) userInfo:nil repeats:YES];

//  [timer fire];
 
  NSTimer *timer2 = [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(changeDataForTest2) userInfo:nil repeats:YES];
  
  [timer2 fire];
}

-(void) viewDidAppear:(BOOL)animated
{
  NSMutableDictionary *data =  [[NSMutableDictionary alloc] init];
  [data setObject:@"111" forKey:@"11"];
  NSMutableArray *arr = [[NSMutableArray alloc] init];
  [arr addObject:@"222"];
  [arr addObject:@"333"];
  [data setObject:arr forKey:@"222"];
  NSLog(@"%p, %@", data, data);
  for (id key in [data allKeys]) {
    NSLog(@"%p", key);
  }
  
  for (id val in [data allValues]) {
    NSLog(@"%p", val);
  }
  
  coreDataViewController *table = [[coreDataViewController alloc] init];
  table.dict = data;
  table.modalPresentationStyle = UIModalPresentationOverFullScreen;
  [self presentViewController:table animated:YES completion:nil];
}

-(void) testCoreData
{
  [_tool dbActionBGOnSameThread:^bool(NSManagedObjectContext *context) {
    NSLog(@"dbActionBGA %@, main thread=%@ 1111", [NSThread currentThread], [NSThread mainThread]);
    sleep(2.0);
    NSLog(@"dbActionBGA %@, main thread=%@ 2222", [NSThread currentThread], [NSThread mainThread]);
    return NO;
  }];
  
  [_tool dbActionBGOnSameThread:^bool(NSManagedObjectContext *context) {
    NSLog(@"dbActionBGA %@, main thread=%@ 3333", [NSThread currentThread], [NSThread mainThread]);
    sleep(2.0);
    NSLog(@"dbActionBGA %@, main thread=%@ 4444", [NSThread currentThread], [NSThread mainThread]);
    return NO;
  }];
  
  [_tool dbActionWait:^bool(NSManagedObjectContext *context) {
    NSLog(@"dbActionWait %@, main thread=%@", [NSThread currentThread], [NSThread mainThread]);
    sleep(2.0);
    NSLog(@"dbActionWait %@, main thread=%@", [NSThread currentThread], [NSThread mainThread]);
    return NO;
  }];
  
  [_tool dbActionBG:^bool(NSManagedObjectContext *context) {
    NSLog(@"dbActionBG %@, main thread=%@ 111", [NSThread currentThread], [NSThread mainThread]);
    sleep(2.0);
    NSLog(@"dbActionBG %@, main thread=%@ 222", [NSThread currentThread], [NSThread mainThread]);
    return NO;
  }];
  
  [_tool dbActionBG:^bool(NSManagedObjectContext *context) {
    NSLog(@"dbActionBG %@, main thread=%@   333", [NSThread currentThread], [NSThread mainThread]);
    sleep(2.0);
    NSLog(@"dbActionBG %@, main thread=%@  444", [NSThread currentThread], [NSThread mainThread]);
    return NO;
  }];
}

-(void) changeDataForTest
{
  [_tool dbActionBG:^(NSManagedObjectContext *context) {
    NSFetchRequest *request = [Table1 fetchRequest];
    NSError *err = nil;
    NSArray *rst = [context executeFetchRequest:request error:&err];
    if (rst == nil)
      return NO;
    for (Table1 *tt in rst) {
      NSDate *now = [NSDate dateWithTimeIntervalSinceNow:0.0f];
      tt.item2 = [now description];
    }
 
    if (![context save:&err]) {
      NSLog(@"%@", err);
      return NO;
    }
    
//    [self.tool closeDB];

    return YES;
  }];
}

-(void) changeDataForTest2
{
  [_tool dbActionBG:^(NSManagedObjectContext *context) {
    NSFetchRequest *request = [Table2 fetchRequest];
    NSError *err = nil;
    NSArray *rst = [context executeFetchRequest:request error:&err];
    if (rst == nil)
      return NO;
    for (Table2 *tt in rst) {
      NSDate *now = [NSDate dateWithTimeIntervalSinceNow:0.0f];
      tt.xxx = [now description];
    }
    
    if (![context save:&err]) {
      NSLog(@"%@", err);
      return NO;
    }
    
    return YES;
  }];
}

-(void) insetDataForTest
{
  [_tool dbActionWait:^bool(NSManagedObjectContext *context) {
    //already insert into context
    Table1 *t1 = [[Table1 alloc] initWithContext:context];
    t1.item1 = 99;
    NSDate *now = [NSDate dateWithTimeIntervalSinceNow:0.0f];
    t1.item2 = [now description];
//    [context insertObject:t1];
    NSError *err = nil;
    if (![context save:&err]) {
      NSLog(@"%@", err);
      return NO;
    }
    return YES;
  }];
}

@end
