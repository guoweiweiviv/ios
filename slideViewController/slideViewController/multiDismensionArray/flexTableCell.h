//
//  flexTableCell.h
//  slideViewController
//
//  Created by gnway on 2018/11/28.
//  Copyright © 2018年 com.gnway. All rights reserved.
//

#ifndef flexTableCell_h
#define flexTableCell_h
#import <UIKit/UIKit.h>

@interface flexTableCell : UITableViewCell
@property IBOutlet UILabel *txtLabel;
@property IBOutlet UIImageView *selectFlag;

-(void) selectMe:(BOOL) flag;
@end

#endif /* flexTableCell_h */
