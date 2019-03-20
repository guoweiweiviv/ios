//
//  ViewController.m
//  shareExtension
//
//  Created by gnway on 2019/4/26.
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

-(void) viewDidAppear:(BOOL)animated
{
  NSString *shareText = @"sharetitle";
  UIImage *shareImage = [UIImage imageNamed:@"167x167.png"];
  NSURL *shareURL = [NSURL URLWithString:@"https://www.baidu.com/"];
  NSArray *activityItems = [[NSArray alloc] initWithObjects:shareText, shareImage, shareURL, nil];
  
  UIActivityViewController *vc = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
  
  UIActivityViewControllerCompletionWithItemsHandler myBlock = ^(UIActivityType activityType, BOOL completed, NSArray *returnedItems, NSError *activityError) {
    NSLog(@"%@",activityType);
    if (completed) {
      NSLog(@"分享成功");
    } else {
      NSLog(@"分享失败");
    }
    [vc dismissViewControllerAnimated:YES completion:nil];
  };
  
  vc.completionWithItemsHandler = myBlock;
  
  [self presentViewController:vc animated:YES completion:nil];
}


@end
