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

@interface ViewController ()
@property (nonatomic) coredataTools *tool;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
  _tool = [coredataTools sharedInstance];
  [_tool loadDB:@"coreDataModel" stroeFilePath:@"coreDataModel.store"];
  
 // [self testCoreData];
  
  NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(changeDataForTest) userInfo:nil repeats:YES];

  [timer fire];
 // [self insetDataForTest];
}

-(void) viewDidAppear:(BOOL)animated
{
  coreDataViewController *table = [[coreDataViewController alloc] init];
  table.modalPresentationStyle = UIModalPresentationOverFullScreen;
  [self presentViewController:table animated:YES completion:nil];
}

-(void) testCoreData
{
  [_tool dbActionBGA:^bool(NSManagedObjectContext *context) {
    NSLog(@"dbActionBGA %@, main thread=%@", [NSThread currentThread], [NSThread mainThread]);
    sleep(2.0);
    NSLog(@"dbActionBGA %@, main thread=%@", [NSThread currentThread], [NSThread mainThread]);
    return NO;
  }];
  
  [_tool dbActionBGA:^bool(NSManagedObjectContext *context) {
    NSLog(@"dbActionBGA %@, main thread=%@", [NSThread currentThread], [NSThread mainThread]);
    sleep(2.0);
    NSLog(@"dbActionBGA %@, main thread=%@", [NSThread currentThread], [NSThread mainThread]);
    return NO;
  }];
  
  [_tool dbActionWait:^bool(NSManagedObjectContext *context) {
    NSLog(@"dbActionWait %@, main thread=%@", [NSThread currentThread], [NSThread mainThread]);
    sleep(2.0);
    NSLog(@"dbActionWait %@, main thread=%@", [NSThread currentThread], [NSThread mainThread]);
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
    
    [self.tool closeDB];

    return YES;
  }];


}

-(void) insetDataForTest
{
  [_tool dbActionBG:^bool(NSManagedObjectContext *context) {
 //   Table1 *t1= [NSEntityDescription insertNewObjectForEntityForName:@"Table1" inManagedObjectContext:context];
    Table1 *t1 = [[Table1 alloc] initWithContext:context];
    t1.item1 = 99;
    NSDate *now = [NSDate dateWithTimeIntervalSinceNow:0.0f];
    t1.item2 = [now description];
    [context insertObject:t1];
    NSError *err = nil;
    if (![context save:&err]) {
      NSLog(@"%@", err);
      return NO;
    }
    return YES;
  }];
}

@end
