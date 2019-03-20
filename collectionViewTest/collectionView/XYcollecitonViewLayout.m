//
//  XYcollecitonLayout.m
//  collectionViewTest
//
//  Created by gnway on 2018/12/6.
//  Copyright © 2018年 com.gnway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYcollectionViewLayout.h"

@implementation XYcollecitonViewLayout

- (void)prepareLayout
{
  [super prepareLayout];
}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
  NSMutableArray * attributes = [[NSMutableArray alloc]init];
  //遍历设置每个item的布局属性
  for (int i=0; i<[self.collectionView numberOfItemsInSection:0]; i++) {
    [attributes addObject:[self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]]];
  }
  return attributes;
}

- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
  UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
  attr.size = CGSizeMake(80, 80);
  CGSize ss = [self collectionViewContentSize];
  NSInteger n = ss.width / 90;
  NSInteger row = indexPath.row / n;
  NSInteger column = indexPath.row % n;
  attr.center = CGPointMake(45 + column * 90, 45  + row * 90);
  return attr;
}

-(CGSize)collectionViewContentSize
{
  CGSize ss = [UIScreen mainScreen].bounds.size;
  NSInteger n = [self.collectionView numberOfItemsInSection:0];
  NSInteger row = ss.width * 2 / 90;
  NSInteger column = (n /  row) + (n % row ? 1 : 0);
  return CGSizeMake(ss.width*2, column * 90);
}

//返回yes，则一有变化就会刷新布局
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
  return YES;
  
}

@end
