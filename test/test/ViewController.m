//
//  ViewController.m
//  test
//
//  Created by gnway on 2018/9/7.
//  Copyright © 2018年 com.gnway. All rights reserved.
//

#import "ViewController.h"
#import "testVC.h"
#import "nav.h"

@interface ViewController ()
@property (nonatomic) obj *oo;

@end



@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.restorationIdentifier = @"xxxxx";
  self.restorationClass = [self class];
  // Do any additional setup after loading the view, typically from a nib.
  
}

-(void) viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
}


-(void) viewDidAppear:(BOOL)animated
{
  testVC *tVC = [[testVC alloc] init];
  tVC.i = 1;
  nav *nv = [[nav alloc] initWithRootViewController:tVC];
  nv.navigationBar.translucent = YES;
  nv.modalPresentationStyle = UIModalPresentationOverFullScreen;
  nv.modalPresentationCapturesStatusBarAppearance = YES;
  [self presentViewController:nv animated:YES completion:nil];
}

-(void) objBtn:(id)sender
{
  [self test];
}

-(void) test
{
  obj *oo1 = [[obj alloc] init];
  objxx *oo = [[objxx alloc] init];
  __weak typeof(oo) weakOO = oo;
  [oo done:^(obj *ooo) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      NSLog(@"ooo %@", ooo);
      NSLog(@"oo %@", weakOO);
    });
  } obj:oo1];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end

@implementation obj
-(id) init
{
  self = [super init];
  return self;
}

-(void) dealloc
{
  NSLog(@"obj dealloc");
}


@end

@implementation objxx
-(id) init
{
  self = [super init];
  return self;
}

-(void) dealloc
{
  NSLog(@"objxxx dealloc");
}

-(void) done:(void (^)(obj *))callback obj:(obj *)obj
{
  if (callback)
    callback(obj);
}
@end
