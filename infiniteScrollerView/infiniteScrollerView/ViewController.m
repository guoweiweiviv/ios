//
//  ViewController.m
//  infiniteScrollerView
//
//  Created by gnway on 2018/12/18.
//  Copyright © 2018年 com.gnway. All rights reserved.
//

#import "ViewController.h"
#import "infiniteScrollViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}

-(void) viewDidAppear:(BOOL)animated
{
  infinteScrollViewController *vc = [[infinteScrollViewController alloc] init];
  vc.modalPresentationStyle = UIModalPresentationFullScreen;
  [self presentViewController:vc animated:YES completion:nil];
}

@end
