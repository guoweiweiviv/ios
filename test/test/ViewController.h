//
//  ViewController.h
//  test
//
//  Created by gnway on 2018/9/7.
//  Copyright © 2018年 com.gnway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@end

@interface obj : NSObject
@property NSInteger iii;
@end

@interface objxx : NSObject
@property NSInteger iii;
-(void) done:(void (^)(obj *))callback obj:(obj *)obj;
@end
