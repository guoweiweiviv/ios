//
//  PhotoKitHelper.m
//  photoKitTest
//
//  Created by gnway on 2018/10/10.
//  Copyright © 2018年 com.gnway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhotoKitHelper.h"

@implementation PhotoKitHelper

+(NSArray *) getAlbums
{
  NSMutableArray *albums = [[NSMutableArray alloc] init];
  
  //相机胶卷
  PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil];
  
  //ituns同步的相册
  PHFetchResult *syncedAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumSyncedAlbum options:nil];
  
  //本地相册
  PHFetchResult *userCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil];
  
  [PHPhotoLibrary sharedPhotoLibrary] ;
  
  // Add each PHFetchResult to the array
  NSArray *collectionsFetchResults = @[smartAlbums, userCollections, syncedAlbums];
  for (int i = 0; i < collectionsFetchResults.count; i ++) {
    
    PHFetchResult *fetchResult = collectionsFetchResults[i];
    
    for (int x = 0; x < fetchResult.count; x ++) {
      
      PHAssetCollection *collection = fetchResult[x];
      [albums addObject:collection];
   //   NSLog(@"%lu", (unsigned long)[[self fetchAssetsInAssetCollection:collection ascending:YES] count]);
    }
  }
  return albums;
}

+ (PHFetchResult *)fetchAssetsInAssetCollection:(PHAssetCollection *)assetCollection mediaType:(PHAssetMediaType)mediaType ascending:(BOOL)ascending
{
  PHFetchOptions *option = [[PHFetchOptions alloc] init];
  option.predicate = [NSPredicate predicateWithFormat:@"mediaType == %d", mediaType];
  
  option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:ascending]];
  PHFetchResult *result = [PHAsset fetchAssetsInAssetCollection:assetCollection options:option];
  return result;
}

#pragma mark ---   获取asset相对应的照片
+(UIImage *)getImageByAsset:(PHAsset *)asset makeSize:(CGSize)size makeResizeMode:(PHImageRequestOptionsResizeMode)resizeMode
{
  
  PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
  /**
   resizeMode：对请求的图像怎样缩放。有三种选择：None，不缩放；Fast，尽快地提供接近或稍微大于要求的尺寸；Exact，精准提供要求的尺寸。
   deliveryMode：图像质量。有三种值：Opportunistic，在速度与质量中均衡；HighQualityFormat，不管花费多长时间，提供高质量图像；FastFormat，以最快速度提供好的质量。
   这个属性只有在 synchronous 为 true 时有效。
   */
  option.resizeMode = resizeMode;//控制照片尺寸
  option.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;//控制照片质量
  // 是否阻塞知道获取图片
  option.synchronous = YES;
  // 是否同步iCloud
  option.networkAccessAllowed = NO;
  
  __block UIImage *return_img = nil;
  //param：targetSize 即你想要的图片尺寸，若想要原尺寸则可输入PHImageManagerMaximumSize
  [[PHCachingImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeAspectFit options:option resultHandler:^(UIImage * _Nullable image, NSDictionary * _Nullable info) {
    return_img = image;
  }];
  return return_img;
}


@end
