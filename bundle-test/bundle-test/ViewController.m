//
//  ViewController.m
//  bundle-test
//
//  Created by gnway on 2019/5/22.
//  Copyright © 2019 com.gnway. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
}


-(void) viewWillAppear:(BOOL)animated
{
  UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.view.frame];
  [self.view addSubview:imgView];
  
  NSString *bundlePath = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:@"myBundle.bundle"];
  NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
//  NSString *imagePath = [bundle pathForResource:@"1" ofType:@"png"];
  NSString *imagePath = @"myBundle.bundle/1.png";
  UIImage *img = [UIImage imageNamed:imagePath];
}
@end
