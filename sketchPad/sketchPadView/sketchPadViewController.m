//
//  sketchPadView.m
//  sketchPad
//
//  Created by gnway on 2018/10/24.
//  Copyright © 2018年 com.gnway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sketchPadViewController.h"
#import "CustomerBezierPath.h"

@interface notepadView ()
@property (nonatomic) NSMutableArray *lineArray;
@end

@implementation notepadView
-(instancetype) initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  [self setBackgroundColor:[UIColor clearColor]];
  return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  //1、每次触摸的时候都应该去创建一条贝塞尔曲线
  CustomerBezierPath *path = [CustomerBezierPath new];
  //2、移动画笔
  UITouch *touch = [touches anyObject];
  CGPoint point = [touch locationInView:self];
  [path moveToPoint:point];
  //设置线宽
  path.lineWidth = 2.0f;
  //狮子颜色
  //  path.color = self.lineColor;//保存线条当前颜色
  if (!self.lineArray) {
    self.lineArray = [NSMutableArray new];
  }
  [self.lineArray addObject:path];
  
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
  CustomerBezierPath *path = self.lineArray.lastObject;
  UITouch *touch = [touches anyObject];
  CGPoint point = [touch locationInView:self];
  [path addLineToPoint:point];
  //重新绘制
  [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{
  //遍历数组，绘制曲线
  if(self.lineArray.count > 0){
    for (CustomerBezierPath *path in self.lineArray) {
      [path.color setStroke];
      [path setLineCapStyle:kCGLineCapRound];
      [path stroke];
    }
  }
}

-(UIImage *) saveToImg
{
  UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0.0);
  [self.layer renderInContext:UIGraphicsGetCurrentContext()];
  
  UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
  
  UIGraphicsEndImageContext();
  return img;
}
@end

@interface sketchPadViewController ()
@property IBOutlet UIButton *cancel;
@property IBOutlet UIButton *redo;
@property IBOutlet UIButton *back;
@property IBOutlet UIButton *done;
@property IBOutlet notepadView *notePad;

- (IBAction) cancelAct:(id)sender;
-(IBAction) doneAct:(id)sender;
- (IBAction) redoAct:(id)sender;
-(IBAction) backAct:(id)sender;
@end

@implementation sketchPadViewController

-(id) init
{
  self = [super initWithNibName:@"sketchPadViewController" bundle:nil];
  return self;
}

-(void) viewDidLoad
{
  [self.view setBackgroundColor:[UIColor whiteColor]];

  [self configBtn1:_cancel];
  [self configBtn1:_redo];
  [self configBtn1:_back];
  [self configBtn2:_done];
}

-(void) configBtn1:(UIButton *)btn
{
  //Base style for 椭圆 1
  [btn setBackgroundColor:[UIColor whiteColor]];
  btn.layer.cornerRadius = 23.0f;
  [btn setTitleColor:[UIColor colorWithRed:60.0f/255.0f green:158.0f/255.0f blue:250.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
  [btn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
}

-(void) configBtn2:(UIButton *)btn
{
  [btn setBackgroundColor:[UIColor colorWithRed:60.0f/255.0f green:158.0f/255.0f blue:250.0f/255.0f alpha:1.0f]];
  btn.layer.cornerRadius = 23.0f;
  [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  [btn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
}

//支持旋转
-(BOOL)shouldAutorotate{
  return YES;
}


- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
  return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
}
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
  return UIInterfaceOrientationLandscapeLeft; //横屏进入
}

-(IBAction)cancelAct:(id)sender
{
  [self.notePad.lineArray removeLastObject];
  [self.notePad setNeedsDisplay];
}

- (IBAction) redoAct:(id)sender
{
  [self.notePad.lineArray removeAllObjects];
  [self.notePad setNeedsDisplay];
}

-(IBAction) backAct:(id)sender
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)doneAct:(id)sender
{
  UIImage *img = [self.notePad saveToImg];

}
@end
