//
//  flexHeightButton.h
//  slideViewController
//
//  Created by gnway on 2018/11/27.
//  Copyright © 2018年 com.gnway. All rights reserved.
//

#ifndef flexHeightButton_h
#define flexHeightButton_h
#import <UIKit/UIKit.h>

@interface flexHeightButton : UIView
@property IBOutlet UILabel *label;
@property IBOutlet UIButton *btn;

-(void) setTitle:(NSString *)title;
@end

#endif /* flexHeightButton_h */
