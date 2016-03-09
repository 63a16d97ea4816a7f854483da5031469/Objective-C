//
//  ViewController.m
//  WebViewTesting
//
//  Created by Lei Cao on 9/3/16.
//  Copyright © 2016 Lei Cao (Tony). All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ViewController
NSTimer * timer;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.webView.delegate=self;
    
    NSString *urlString = @"http://www.g.com";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlRequest];
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"begin loading");
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeout:) userInfo:nil repeats:NO];
}

-(void)timeout:(id)sender{
    NSLog(@"the connection time out!");
}



- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [timer invalidate];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error{
    //Error 999 fire when stopLoading
        NSLog(@"the error:%@",error);
    [timer invalidate];//invalidate for other errors, not time out.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
