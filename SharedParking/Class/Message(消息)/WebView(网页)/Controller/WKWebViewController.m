//
//  WKWebViewController.m
//  yimaxingtianxia
//
//  Created by lingbao on 2017/6/30.
//  Copyright © 2017年 lingbao. All rights reserved.
//

#import "WKWebViewController.h"
#import<WebKit/WebKit.h>
@interface WKWebViewController ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>
@property (nonatomic,strong)WKWebView *webView;
@property (strong, nonatomic) UIProgressView *progressView;


@end

@implementation WKWebViewController
#pragma mark ---------------LifeCycle-------------------------/
- (void)dealloc {
    
    if ([self isViewLoaded]) {
        [self.webView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
    }
    [self.webView setNavigationDelegate:nil];
    [self.webView setUIDelegate:nil];

}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
}

- (id)initWithWebStr:(NSString *)webStr withTitle:(NSString *)title{
    self = [super init];
    if (self) {
        _webStr = webStr;
        _titleStr = title;
        
    }
    return self;
}
- (instancetype)initWithHTMLString:(NSString *)string baseURL:(NSURL *)baseURL withTitle:(NSString *)title
{
    self = [super init];
    if (self) {
        _baseURL = baseURL;
        _htmlString = string;
        _titleStr = title;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
}

- (void)initView{
    [self.view addSubview:self.webView];
    [self.view addSubview:self.progressView];
    
    [self.webView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:NSKeyValueObservingOptionNew context:NULL];
    
    if (_titleStr) {
        self.title = _titleStr;
    }
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self deleteWebCache];
    
    if (_webStr) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_webStr]]];
        
    }
    if (_htmlString) {
        [self.webView loadHTMLString:self.htmlString baseURL:self.baseURL];
    }

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

#pragma mark ---------------Event-------------------------/
- (void)deleteWebCache {
    [WSProgressHUD show];
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
        NSSet *websiteDataTypes
        = [NSSet setWithArray:@[
                                WKWebsiteDataTypeDiskCache,
                                //WKWebsiteDataTypeOfflineWebApplicationCache,
                                WKWebsiteDataTypeMemoryCache,
                                //WKWebsiteDataTypeLocalStorage,
                                //WKWebsiteDataTypeCookies,
                                //WKWebsiteDataTypeSessionStorage,
                                //WKWebsiteDataTypeIndexedDBDatabases,
                                //WKWebsiteDataTypeWebSQLDatabases
                                ]];
        //// All kinds of data
        //NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
        //// Date from
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        //// Execute
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
            // Done
        }];
        
    } else {
        
        NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *cookiesFolderPath = [libraryPath stringByAppendingString:@"/Cookies"];
        NSError *errors;
        [[NSFileManager defaultManager] removeItemAtPath:cookiesFolderPath error:&errors];
        
    }
    [WSProgressHUD dismiss];
}
// 添加KVO监听
#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))] && object == self.webView) {
        [self.progressView setAlpha:1.0f];
        [self.progressView setProgress:self.webView.estimatedProgress animated:YES];
        @weakify(self);
        if(self.webView.estimatedProgress >= 1.0f) {
            @strongify(self);
            [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                
                [self.progressView setProgress:0.0f animated:NO];
            }];
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (UIButton *)setGrayNavBackButton{
    //返回按钮
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 30, 20, 20)];
    [backButton setImage:[UIImage imageNamed:@"grayback"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backToSuperView) forControlEvents:UIControlEventTouchUpInside];
    return backButton;
}

#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    DLog(@"页面开始加载时调用");
    //    [WSProgressHUD showWithStatus:@"加载中"];
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    DLog(@"当内容开始返回时调用");
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    DLog(@"页面加载完成之后调用");
    if (!self.titleStr) {
        [webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable title, NSError * _Nullable error) {
            if (!_titleStr) {
                self.title = title;
//                self.lastUrl = [self.webView.URL absoluteString];
            }
        }];
    }
}


// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation {
    DLog(@"页面加载失败时调用");
    [WSProgressHUD showImage:nil status:@"加载失败"];
}

#pragma mark -- JS交互
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {

}

#pragma mark ---------------Lazy-------------------------/
- (WKWebView *)webView{
    if (!_webView) {
        // js配置
        WKUserContentController *userContentController = [[WKUserContentController alloc] init];
        // WKWebView的配置
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        configuration.userContentController = userContentController;
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kBodyHeight) configuration:configuration];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        _webView.allowsBackForwardNavigationGestures = YES;
        _webView.scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    return _webView;
}

- (UIProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.frame = CGRectMake(0, 0, self.view.width, 4);
        _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleBottomMargin;
        _progressView.progress = 0.f;
    }
    return _progressView;
}
@end
