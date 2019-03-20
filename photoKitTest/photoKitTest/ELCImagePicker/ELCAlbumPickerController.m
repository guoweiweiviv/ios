//
//  AlbumPickerController.m
//
//  Created by ELC on 2/15/11.
//  Copyright 2011 ELC Technologies. All rights reserved.
//

#import "ELCAlbumPickerController.h"
#import "ELCImagePickerController.h"
#import "ELCAssetTablePicker.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import <Photos/Photos.h>

@interface ELCAlbumPickerController ()

//@property (nonatomic, strong) ALAssetsLibrary *library;

@end

@implementation ELCAlbumPickerController

//Using auto synthesizers

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{
  [super viewDidLoad];

  [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

 // [self setTitle:@"载入中..." color:nil];
  
  UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self.parent action:@selector(cancelImagePicker)];
  [cancelButton setTintColor:[UIColor colorWithRed:51.0f/255.0f green:51.0f/255.0f blue:51.0f/255.0f alpha:1.0]];
  
  [self.navigationItem setRightBarButtonItem:cancelButton];
  
  [self showAlbums];
}

-(void) showAlbums
{
  NSMutableArray *tempArray = [[NSMutableArray alloc] init];
  self.assetGroups = tempArray;
  //相机胶卷
  PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil];
  
  //ituns同步的相册
  PHFetchResult *syncedAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumSyncedAlbum options:nil];
  
  //本地相册
  PHFetchResult *userCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil];
  
  // Add each PHFetchResult to the array
  NSArray *collectionsFetchResults = @[smartAlbums, userCollections, syncedAlbums];
  for (int i = 0; i < collectionsFetchResults.count; i ++) {
    
    PHFetchResult *fetchResult = collectionsFetchResults[i];
    
    for (int x = 0; x < fetchResult.count; x ++) {
      
      PHAssetCollection *collection = fetchResult[x];
      [tempArray addObject:collection];
//      NSLog(@"%lu", (unsigned long)[[self fetchAssetsInAssetCollection:collection ascending:YES] count]);
    }
  }
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];


//  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableView) name:ALAssetsLibraryChangedNotification object:nil];
  [self.tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
//  [[NSNotificationCenter defaultCenter] removeObserver:self name:ALAssetsLibraryChangedNotification object:nil];
}

- (void)reloadTableView
{
  [self.tableView reloadData];
  //	[self.navigationItem setTitle:NSLocalizedString(@"Select an Album", nil)];
 // [self setTitle:@"选择相册" color:nil];
}

- (BOOL)shouldSelectAsset:(ELCAsset *)asset previousCount:(NSUInteger)previousCount
{
  return [self.parent shouldSelectAsset:asset previousCount:previousCount];
}

- (BOOL)shouldDeselectAsset:(ELCAsset *)asset previousCount:(NSUInteger)previousCount
{
  return [self.parent shouldDeselectAsset:asset previousCount:previousCount];
}

- (void)selectedAssets:(NSArray*)assets
{
  [_parent selectedAssets:assets];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  // Return the number of sections.
  return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  // Return the number of rows in the section.
  return [self.assetGroups count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"Cell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
  }
  

  PHAssetCollection *g = (PHAssetCollection *)[self.assetGroups objectAtIndex:indexPath.row];
  PHFetchResult *rst = [self fetchAssetsInAssetCollection:g ascending:NO];
  NSInteger gCount = [rst count];
  NSString *gTitle = [g localizedTitle];
  if (g.assetCollectionType == PHAssetCollectionTypeSmartAlbum)
    gTitle = @"相机胶卷";
  cell.textLabel.text = [NSString stringWithFormat:@"%@ (%ld)",gTitle, (long)gCount];
  PHAsset *asset = rst.firstObject;
 // UIImage* image = [UIImage imageWithCGImage:[g posterImage]];
 // image = [self resize:image to:CGSizeMake(78, 78)];
 // [cell.imageView setImage:image];
  [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
  
  return cell;
}

- (PHFetchResult *)fetchAssetsInAssetCollection:(PHAssetCollection *)assetCollection ascending:(BOOL)ascending
{
  PHFetchOptions *option = [[PHFetchOptions alloc] init];
  option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:ascending]];
  PHFetchResult *result = [PHAsset fetchAssetsInAssetCollection:assetCollection options:option];
  return result;
}

// Resize a UIImage. From http://stackoverflow.com/questions/2658738/the-simplest-way-to-resize-an-uiimage
- (UIImage *)resize:(UIImage *)image to:(CGSize)newSize {
  //UIGraphicsBeginImageContext(newSize);
  // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
  // Pass 1.0 to force exact pixel size.
  UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
  [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
  UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return newImage;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  ELCAssetTablePicker *picker = [[ELCAssetTablePicker alloc] initWithNibName: nil bundle: nil];
  picker.parent = self;
  
  picker.assetGroup = [self.assetGroups objectAtIndex:indexPath.row];
//  [picker.assetGroup setAssetsFilter:[self assetFilter]];
  
  picker.assetPickerFilterDelegate = self.assetPickerFilterDelegate;
  
  [self.navigationController pushViewController:picker animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 95;
}

@end

