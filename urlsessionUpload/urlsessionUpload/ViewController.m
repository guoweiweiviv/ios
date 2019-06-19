//
//  ViewController.m
//  urlsessionUpload
//
//  Created by gnway on 2019/6/14.
//  Copyright © 2019 com.gnway. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>

@interface ViewController ()
@property (nonatomic) NSURLSession *session;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
}


-(void) viewWillAppear:(BOOL)animated
{

  [self test2];
}

-(void) test2
{
  NSString *urlString = @"https://supportest.kingdee.com/osp2016/agent/upload.php";
  NSString *string = @"1111111111";
  NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
  NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:urlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    [formData appendPartWithFileData:data
                                name:@"file"
                            fileName:@"1.txt" mimeType:@"text/html"];
  } error:nil];
  
  AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
  
  NSURLSessionUploadTask *uploadTask;
  uploadTask = [manager
                uploadTaskWithStreamedRequest:request
                progress:^(NSProgress * _Nonnull uploadProgress) {
                  // This is not called back on the main queue.
                  // You are responsible for dispatching to the main queue for UI updates
                 // dispatch_async(dispatch_get_main_queue(), ^{
                    //Update the progress view
                 //   [progressView setProgress:uploadProgress.fractionCompleted];
                 // });
                }
                completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                  if (error) {
                    NSLog(@"Error: %@", error);
                  } else {
                    NSLog(@"%@ %@", response, responseObject);
                  }
                }];
  
  [uploadTask resume];
}

@end
