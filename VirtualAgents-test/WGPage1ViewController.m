//
//  WGPage1ViewController.m
//  VirtualAgents-test
//
//  Created by saqib on 12/5/14.
//  Copyright (c) 2014 Muhammad Saqib Yaqeen. All rights reserved.
//

#import "WGPage1ViewController.h"

@interface WGPage1ViewController (){
}

@end

@implementation WGPage1ViewController
@synthesize kll;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor purpleColor];
    
    
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"\U000025C0\U0000FE0E" style:UIBarButtonItemStyleBordered target:self action:@selector(goingBack)];
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationItem.title=@"Page 1";
    UIWebView *webView=[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 768 , 1024)];
    
    NSURL *url = [NSURL URLWithString:@"http://playit.pk/watch?v=MRYzW3BSj0I"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    [self.view addSubview:webView];
    // Do any additional setup after loading the view.
}
-(void)goingBack{
    //if ([kll isEqualToString:@"training"]) {
        [self performSegueWithIdentifier: @"Page1-Training" sender: self];

   // }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
