//
//  ViewController.m
//  wkwebview
//
//  Created by gnway on 2018/11/13.
//  Copyright © 2018年 com.gnway. All rights reserved.
//

#import "ViewController.h"
#import "wkwebviewTest.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}

-(void) viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  wkwebviewTest *vc = [[wkwebviewTest alloc] init];
  vc.modalPresentationStyle = UIModalPresentationFullScreen;
  [self presentViewController:vc animated:YES completion:nil];
}


@end
