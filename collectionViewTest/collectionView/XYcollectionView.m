//
//  XYcollectionView.m
//  collectionViewTest
//
//  Created by gnway on 2018/11/16.
//  Copyright © 2018年 com.gnway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYcollectionView.h"
#import "XYcollectionViewCell.h"
#import "XYcollectionViewLayout.h"

@interface XYcollectionView () <UICollectionViewDelegate, UICollectionViewDataSource>
@end

@implementation XYcollectionView

-(id) initWithFrame:(CGRect)frame
{
  XYcollecitonViewLayout  *layout = [[XYcollecitonViewLayout alloc] init];
  self = [super initWithFrame:frame collectionViewLayout:layout];
  [self configView];
  return self;
}

-(id) initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
  self = [super initWithFrame:frame collectionViewLayout:layout];
  [self configView];
  return self;
}

-(void) configView
{
  [self setBackgroundColor:[UIColor greenColor]];
  self.dataSource = self;
  self.delegate = self;
  
  UINib *cell_nib = [UINib nibWithNibName:@"XYcollectionViewCell" bundle:nil];
  [self registerNib:cell_nib forCellWithReuseIdentifier:@"XYcollectionViewCell"];
  [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
  [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView"];
  
//  [self setPagingEnabled:YES];
}

//after loaded
-(void) awakeFromNib
{
  [super awakeFromNib];
}

-(NSInteger) numberOfSections
{
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return 100;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  XYcollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XYcollectionViewCell" forIndexPath:indexPath];
  [cell configCell:@{@"indexPath":indexPath}];
  return cell;
}

// The view that is returned must be retrieved from a call to -dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
  if (kind == UICollectionElementKindSectionHeader) {
     UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
    return headerView;
  } else if (kind == UICollectionElementKindSectionFooter) {
    UICollectionReusableView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
    return footView;
  }
  return nil;
}

@end
