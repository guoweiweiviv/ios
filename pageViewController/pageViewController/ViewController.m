//
//  ViewController.m
//  pageViewController
//
//  Created by gnway on 2019/2/25.
//  Copyright © 2019年 com.gnway. All rights reserved.
//

#import "ViewController.h"
#import "XYpageViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}

-(void) viewDidAppear:(BOOL)animated
{
  XYpageViewController *vc = [[XYpageViewController alloc] init];
  vc.modalPresentationStyle = UIModalPresentationFullScreen;
  [self presentViewController:vc animated:YES completion:nil];
}

@end
