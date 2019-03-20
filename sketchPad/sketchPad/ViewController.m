//
//  ViewController.m
//  sketchPad
//
//  Created by gnway on 2018/10/24.
//  Copyright © 2018年 com.gnway. All rights reserved.
//

#import "ViewController.h"
#import "sketchPadViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(UIStatusBarStyle) preferredStatusBarStyle
{
  return UIStatusBarStyleDefault;
}

-(BOOL) prefersStatusBarHidden
{
  return NO;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.view setBackgroundColor:[UIColor yellowColor]];
  // Do any additional setup after loading the view, typically from a nib.
}

//支持旋转
 -(BOOL)shouldAutorotate{
      return YES;
}

 //支持的方向
 - (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
  return UIInterfaceOrientationMaskPortrait;
}

-(UIInterfaceOrientation) preferredInterfaceOrientationForPresentation
{
  return UIInterfaceOrientationPortrait;
}

-(void) viewDidAppear:(BOOL)animated
{
  UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 40)];
  [btn setBackgroundColor:[UIColor grayColor]];
  [btn addTarget:self action:@selector(go2Sign:) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:btn];
}

-(void) go2Sign:(id)sender
{
  sketchPadViewController *vc = [[sketchPadViewController alloc] init];
  vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
  [self presentViewController:vc animated:YES completion:nil];
}
@end
