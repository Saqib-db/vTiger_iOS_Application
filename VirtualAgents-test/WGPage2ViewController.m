//
//  WGPage2ViewController.m
//  VirtualAgents-test
//
//  Created by saqib on 12/8/14.
//  Copyright (c) 2014 Muhammad Saqib Yaqeen. All rights reserved.
//

#import "WGPage2ViewController.h"
#import "WGViewController.h"
#import "WGPresentationViewController.h"




@interface WGPage2ViewController (){
    BOOL menuShowing;
    UIView *menuView;
}

@end

@implementation WGPage2ViewController
@synthesize menuBtn;





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
    
    
    self.navigationItem.title=@"Page 2";
    UIWebView *webView=[[UIWebView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.height , self.view.frame.size.width)];
    webView.delegate=self;
    
    NSURL *url = [NSURL URLWithString:@"http://www.docdroid.net/mwgo/reach-presentation-updated.pdf.html"];//http://www.iosres.com/"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    [self.view addSubview:webView];
    
    
    [menuBtn setImage:[UIImage imageNamed:@"Menu-button-ios.png"] forState:UIControlStateNormal];
    
    menuView=[WGPresentationViewController MakeMeuView];
    
    UIButton *MenuItem1=(UIButton*)[menuView viewWithTag:1];
    UIButton *MenuItem2=(UIButton*)[menuView viewWithTag:2];
    UIButton *MenuItem3=(UIButton*)[menuView viewWithTag:3];
    
    [MenuItem1 addTarget:self action:@selector(GotoPage:) forControlEvents:UIControlEventTouchUpInside];
    [MenuItem2 addTarget:self action:@selector(GotoPage:) forControlEvents:UIControlEventTouchUpInside];
    [MenuItem3 addTarget:self action:@selector(GotoPage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view setBackgroundColor:[WGViewController colorFromHexString:@"#FDE8A7"]];
    
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    
    [menuBtn addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    
    
}


-(void)GotoPage:(UIButton *) sender{
    
    if (sender.tag==1) {
        [self performSegueWithIdentifier: @"Pdf-Dashboard" sender: self];
        
        
    }
    else if(sender.tag==2){
        [self performSegueWithIdentifier: @"Pdf-Presentation" sender: self];
        
        
    }
    else if(sender.tag==3){
        
        [self performSegueWithIdentifier: @"Pdf-Training" sender: self];
        
    }
    else if(sender.tag==4){
        
        
        
    }
    else if(sender.tag==5){
        
        NSLog(@"Leads Clicked");
        
    }
    else{
        NSLog(@"Something has gone wrong in the click menu at =  %@",sender);
        
    }
    
    
    
    
    
}
-(void)showMenu{
    
    
    if (menuShowing) {
        
        CGRect newFrame = menuView.frame;
        newFrame.origin.x -= 200;
        [UIView animateWithDuration:0.25
                         animations:^{
                             menuView.frame = newFrame;
                         }];
        menuShowing=NO;
        
        
    }
    else{
        [self.view addSubview:menuView];
        CGRect newFrame = menuView.frame;
        newFrame.origin.x += 200;
        [UIView animateWithDuration:0.25
                         animations:^{
                             menuView.frame = newFrame;
                         }];
        
        
        menuShowing=YES;
    }
    
}


- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    NSLog(@"started");
    
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    NSLog(@"Page loaded successfully");
    
    
    
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
