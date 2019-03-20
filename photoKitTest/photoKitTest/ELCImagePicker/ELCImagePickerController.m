//
//  ELCImagePickerController.m
//  ELCImagePickerDemo
//
//  Created by ELC on 9/9/10.
//  Copyright 2010 ELC Technologies. All rights reserved.
//

#import "ELCImagePickerController.h"
#import "ELCAsset.h"
#import "ELCAssetCell.h"
#import "ELCAssetTablePicker.h"
#import "ELCAlbumPickerController.h"
#import <CoreLocation/CoreLocation.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <Photos/Photos.h>
#import "ELCConsole.h"

@implementation ELCImagePickerController

//Using auto synthesizers

- (id)initImagePicker
{
  ELCAlbumPickerController *albumPicker = [[ELCAlbumPickerController alloc] initWithStyle:UITableViewStylePlain];
  
  self = [super initWithRootViewController:albumPicker];
  if (self) {
    self.onOrder = YES;
    self.maximumImagesCount = 4;
    self.returnsImage = YES;
    self.returnsOriginalImage = YES;
    [albumPicker setParent:self];
    self.mediaTypes = @[(NSString *)kUTTypeImage, (NSString *)kUTTypeMovie];
  }
  return self;
}

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
  
  self = [super initWithRootViewController:rootViewController];
  if (self) {
    self.maximumImagesCount = 4;
    self.returnsImage = YES;
  }
  return self;
}

- (ELCAlbumPickerController *)albumPicker
{
  return self.viewControllers[0];
}

- (void)setMediaTypes:(NSArray *)mediaTypes
{
  self.albumPicker.mediaTypes = mediaTypes;
}

- (NSArray *)mediaTypes
{
  return self.albumPicker.mediaTypes;
}

- (void)cancelImagePicker
{
  if ([_imagePickerDelegate respondsToSelector:@selector(elcImagePickerControllerDidCancel:)]) {
    [_imagePickerDelegate performSelector:@selector(elcImagePickerControllerDidCancel:) withObject:self];
  }
}

- (BOOL)shouldSelectAsset:(ELCAsset *)asset previousCount:(NSUInteger)previousCount
{
  BOOL shouldSelect = previousCount < self.maximumImagesCount;
  if (!shouldSelect) {
    NSString *title = [NSString stringWithFormat:@"选择图片太多了!"];
    NSString *message = [NSString stringWithFormat:@"最多选择 %ld 张图片", self.maximumImagesCount];
    [[[UIAlertView alloc] initWithTitle:title
                                message:message
                               delegate:nil
                      cancelButtonTitle:nil
                      otherButtonTitles:@"确定", nil] show];
  }
  return shouldSelect;
}

- (BOOL)shouldDeselectAsset:(ELCAsset *)asset previousCount:(NSUInteger)previousCount;
{
  return YES;
}

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

- (void)selectedAssets:(NSArray *)assets
{
  NSMutableArray *returnArray = [[NSMutableArray alloc] init];
  
  for(ELCAsset *elcasset in assets) {
    PHAsset *asset = elcasset.asset;

    NSMutableDictionary *workingDictionary = [[NSMutableDictionary alloc] init];
    
    CLLocation* wgs84Location = asset.location;
    if (wgs84Location) {
      [workingDictionary setObject:wgs84Location forKey:ALAssetPropertyLocation];
    }
    
   [workingDictionary setObject:[NSNumber numberWithInt:asset.mediaType] forKey:UIImagePickerControllerMediaType];
    
    [self getImageByAsset:asset makeSize:CGSizeZero makeResizeMode:PHImageRequestOptionsResizeModeNone completion:^(UIImage *img) {
      if (img == nil)
        return;
      
      [workingDictionary setObject:img forKey:UIImagePickerControllerOriginalImage];
//      [workingDictionary setObject:[asset url] forKey:UIImagePickerControllerReferenceURL];
      
      [returnArray addObject:workingDictionary];
    }];
    
  }
  if (_imagePickerDelegate != nil && [_imagePickerDelegate respondsToSelector:@selector(elcImagePickerController:didFinishPickingMediaWithInfo:)]) {
    [_imagePickerDelegate performSelector:@selector(elcImagePickerController:didFinishPickingMediaWithInfo:) withObject:self withObject:returnArray];
  } else {
    [self popToRootViewControllerAnimated:NO];
  }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
  if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    return YES;
  } else {
    return toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
  }
}

- (BOOL)onOrder
{
  return [[ELCConsole mainConsole] onOrder];
}

- (void)setOnOrder:(BOOL)onOrder
{
  [[ELCConsole mainConsole] setOnOrder:onOrder];
}

@end
