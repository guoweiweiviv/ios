//
//  ViewController.m
//  collectionViewTest
//
//  Created by gnway on 2018/11/16.
//  Copyright © 2018年 com.gnway. All rights reserved.
//

#import <Foundation/NSURLSession.h>
#import "ViewController.h"
#import "XYcollectionView.h"
#import "table.h"

@interface ViewController ()
@property (nonatomic) NSURLSession *session;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
//  [self testURLSession];
  }

-(void) viewDidAppear:(BOOL)animated
{
  CGSize ss = [UIScreen mainScreen].bounds.size;
  XYcollectionView *view = [[XYcollectionView alloc] initWithFrame:CGRectMake(0, 0, ss.width, ss.height)];
  [self.view addSubview:view];
  
//  [self testTable];
}

-(void) testTable
{
  table *vc = [[table alloc] init];
  vc.modalPresentationStyle = UIModalPresentationFullScreen;
  [self presentViewController:vc animated:YES completion:nil];
}

-(void) testURLSession
{
//  NSURLSessionConfiguration *config = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"com.gnway.xxx"];
  NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
  self.session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:nil];
  [[self.session dataTaskWithURL:[NSURL URLWithString:@"https://www.baidu.com"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    NSLog(@"xxx");
  }] resume];
}


@end
