

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
#import "wkwebviewTest.h"

@interface wkwebviewTest () <WKScriptMessageHandler, WKNavigationDelegate>
@property (nonatomic) WKWebView *webView;
@property (nonatomic) NSString *url;
@end

@implementation wkwebviewTest
-(void) viewDidLoad
{
  [super viewDidLoad];
  _url = @"http://danyy.top/href_test.html";
  CGRect frame = [UIScreen mainScreen].bounds;
  _webView = [[WKWebView alloc] initWithFrame:frame];
  [self.view addSubview:_webView];
  NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_url]];
  [_webView loadRequest:request];
  _webView.navigationDelegate = self;
  [self addJScachter];
}

-(void) addJScachter
{
  WKUserContentController *userContentController = [[WKUserContentController alloc] init];
  
  [userContentController addScriptMessageHandler:self name:@"objc"];
  _webView.configuration.userContentController = userContentController;
  
}

-(void) dealloc
{
  [[_webView configuration].userContentController removeScriptMessageHandlerForName:@"objc"];
}

-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
  NSURLRequest * request = navigationAction.request;
  NSLog(@"%@",request.URL.absoluteString);
  
  // 判断请求头是否是 https://www.baidu.com 如果是就不在请求加载跳转
  WKNavigationActionPolicy  actionPolicy = WKNavigationActionPolicyAllow;
  if ([request.URL.absoluteString hasPrefix:@"objc://pay_done"]) {
    
    actionPolicy = WKNavigationActionPolicyCancel;
    
  }
  // 必须这样执行，不然会崩
  decisionHandler(actionPolicy);
}

#pragma mark -- WKScriptMessageHandler
-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
  //JS调用OC方法
  //message.boby就是JS里传过来的参数
  NSLog(@"body:%@",message.body);

}

@end
