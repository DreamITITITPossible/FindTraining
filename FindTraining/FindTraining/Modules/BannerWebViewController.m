//
//  BannerWebViewController.m
//  FindTraining
//
//  Created by Jiang on 16/9/23.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import "BannerWebViewController.h"

@interface BannerWebViewController ()
<
UIWebViewDelegate
>
@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, retain) UIActivityIndicatorView *activity;
@end

@implementation BannerWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = YES;
    UIBarButtonItem *backItem = [UIBarButtonItem getBarButtonItemWithImageName:@"navigator_btn_back" HighLightedImageName:@"navigator_btn_back" targetBlock:^{
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    self.navigationItem.leftBarButtonItem = backItem;
    // Do any additional setup after loading the view.
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.targetUrl]];
    [self.view addSubview:_webView];
    _webView.delegate = self;
    _webView.scalesPageToFit = YES;
    [_webView loadRequest:request];
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"正在加载");
    // 常用的加载: MBProgressHUD SVProgressHUD
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    view.tag = 10086;
    view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:view];
    _activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activity.frame = CGRectMake(0, 0, 50, 50);
    _activity.center = view.center;
    [_activity startAnimating];
    [view addSubview:_activity];
    // 可以自定义一个返回按钮 在button点击方法里写下面调用
    //    [_webView goBack];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"加载完成");
    [_activity stopAnimating];
    UIView *view = (UIView *)[self.view viewWithTag:10086];
    [view removeFromSuperview];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"失败");
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"request : %@, navigationType : %ld", request, navigationType);
    return YES;
}
- (void)setTargetUrl:(NSString *)targetUrl {
    if (_targetUrl != targetUrl) {
        _targetUrl = targetUrl;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
