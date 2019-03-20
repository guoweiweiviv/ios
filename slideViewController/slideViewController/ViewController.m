//
//  ViewController.m
//  slideViewController
//
//  Created by gnway on 2018/11/26.
//  Copyright © 2018年 com.gnway. All rights reserved.
//

#import "ViewController.h"
#import "multiDismensionArrayVC.h"

@interface ViewController ()
@property IBOutlet UIButton *btn;
@property IBOutlet UILabel *label;
@property IBOutlet UIControl  *bbtn;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.

}

-(void) viewDidAppear:(BOOL)animated
{
  return;
  multiDismensionArrayVC *vc = [[multiDismensionArrayVC alloc] init];
  UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
  nav.modalPresentationStyle = UIModalPresentationOverFullScreen;
  [self presentViewController:nav animated:YES completion:nil];
}

@end
