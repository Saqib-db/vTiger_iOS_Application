//
//  WGPage3ViewController.m
//  VirtualAgents-test
//
//  Created by saqib on 12/10/14.
//  Copyright (c) 2014 Muhammad Saqib Yaqeen. All rights reserved.
//

#import "WGPage3ViewController.h"
#import "WGViewController.h"
#import "WGPresentationViewController.h"



@interface WGPage3ViewController (){
    BOOL menuShowing;
    UIView *menuView;
}

@end

@implementation WGPage3ViewController
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
    // Do any additional setup after loading the view.
    
    self.navigationItem.title=@"Page 3";
    UIWebView *webView=[[UIWebView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.height , self.view.frame.size.width)];
    webView.delegate=self;
    
    
    NSURL *url = [NSURL URLWithString:@"http://www.draak.net/media/presention_slides.ppt"];
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
    
    
    
    

}

-(void)viewWillAppear:(BOOL)animated{
    
    [menuBtn addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    
    
}


-(void)GotoPage:(UIButton *) sender{
    
    if (sender.tag==1) {
        [self performSegueWithIdentifier: @"PPT-Dashboard" sender: self];
        
        
    }
    else if(sender.tag==2){
        [self performSegueWithIdentifier: @"PPT-Presentation" sender: self];
        
        
    }
    else if(sender.tag==3){
        
        [self performSegueWithIdentifier: @"PPT-Training" sender: self];

    }
    else if(sender.tag==4){
        
        
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

-(void)showActions{
 
   
    
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
