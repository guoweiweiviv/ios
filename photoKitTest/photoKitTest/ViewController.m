//
//  ViewController.m
//  photoKitTest
//
//  Created by gnway on 2018/10/10.
//  Copyright © 2018年 com.gnway. All rights reserved.
//

#import "ViewController.h"
#import <Photos/Photos.h>
#import "ELCImagePickerController.h"
#import <CoreServices/CoreServices.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}

-(void) viewDidAppear:(BOOL)animated
{
//  [self getAlbums];
  [self selectImages];
}

-(void) selectImages
{
  //多选照片
  ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initImagePicker];
  
  elcPicker.maximumImagesCount = NSIntegerMax; //Set the maximum number of images to select to 100
  elcPicker.returnsOriginalImage = YES; //Only return the fullScreenImage, not the fullResolutionImage
  elcPicker.returnsImage = YES; //Return UIimage if YES. If NO, only return asset location information
  elcPicker.onOrder = NO; //For multiple image selection, display and return order of selected images
  elcPicker.mediaTypes = @[(NSString *)kUTTypeImage, (NSString *)kUTTypeMovie]; //Supports image and movie types
//  elcPicker.imagePickerDelegate = self;
  
  [self presentViewController:elcPicker animated:YES completion:nil];
}

-(void) getAlbums
{
  NSArray *collectionsFetchResults;
  NSMutableArray *localizedTitles = [[NSMutableArray alloc] init];
  
  //相机胶卷
  PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil];
  
  //ituns同步的相册
  PHFetchResult *syncedAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumSyncedAlbum options:nil];
  
  //本地相册
  PHFetchResult *userCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil];
  
  [PHPhotoLibrary sharedPhotoLibrary] ;
  
  // Add each PHFetchResult to the array
  collectionsFetchResults = @[smartAlbums, userCollections, syncedAlbums];
  for (int i = 0; i < collectionsFetchResults.count; i ++) {
    
    PHFetchResult *fetchResult = collectionsFetchResults[i];
    
    for (int x = 0; x < fetchResult.count; x ++) {
      
      PHAssetCollection *collection = fetchResult[x];
      [localizedTitles addObject:collection.localizedTitle];
      NSLog(@"%lu", (unsigned long)[[self fetchAssetsInAssetCollection:collection ascending:YES] count]);
    }
  }
  NSLog(@"%@", localizedTitles);
}

- (PHFetchResult *)fetchAssetsInAssetCollection:(PHAssetCollection *)assetCollection ascending:(BOOL)ascending
{
  PHFetchOptions *option = [[PHFetchOptions alloc] init];
  option.predicate = [NSPredicate predicateWithFormat:@"mediaType == %d", PHAssetMediaTypeVideo];
  
  option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:ascending]];
  PHFetchResult *result = [PHAsset fetchAssetsInAssetCollection:assetCollection options:option];
  return result;
}

#pragma mark ---   获取asset相对应的照片
-(void)getImageByAsset:(PHAsset *)asset makeSize:(CGSize)size makeResizeMode:(PHImageRequestOptionsResizeMode)resizeMode completion:(void (^)(UIImage *))completion{
  
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
  //param：targetSize 即你想要的图片尺寸，若想要原尺寸则可输入PHImageManagerMaximumSize
  [[PHCachingImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeAspectFit options:option resultHandler:^(UIImage * _Nullable image, NSDictionary * _Nullable info) {
    completion(image);
  }];
  
}


@end
