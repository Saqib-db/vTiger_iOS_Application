//
//  WGPresentationViewController.m
//  VirtualAgents-test
//
//  Created by saqib on 12/1/14.
//  Copyright (c) 2014 Muhammad Saqib Yaqeen. All rights reserved.
//

#import "WGPresentationViewController.h"
#import "SMPageControl.h"
#import <QuartzCore/QuartzCore.h>
#include<unistd.h>
#include<netdb.h>
#import "WGViewController.h"
#import "TFHpple.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ProgressHUD.h"
#import "WGViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface WGPresentationViewController (){
    UIView *rootView;
    EAIntroView *intro;
    int chker;
    BOOL menuShowing;
    UIView *menuView;
    UITableView *tableView;
    NSArray *menuItems;
    UIView *snapShot;
    UIView *subMenuView;
    UIButton *MenuItem2;
    UIButton *MenuItem3;
    UIButton *MenuItem4;
    BOOL subMenuShowing;
    MPMoviePlayerController *controller;
    NSString *SubmenuOptionSelected;
}
@end

@implementation WGPresentationViewController
@synthesize MenuBtn;
@synthesize leftBtn;
@synthesize rightBtn;
@synthesize PreviousPage;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }

    return self;
}

#pragma mark -
#pragma mark -LifeCycle functions
- (void)viewDidLoad
{
    
    NSUserDefaults *PreviousPagePreference=[NSUserDefaults standardUserDefaults];
    
    PreviousPage=[PreviousPagePreference objectForKey:@"PageName"];
    SubmenuOptionSelected=[PreviousPagePreference objectForKey:@"SubMeunName"];
    
    NSLog(@"previous page was : %@ and Menu is %@",PreviousPage,SubmenuOptionSelected);
    
    
    
    
    
    menuItems=[NSArray arrayWithObjects:@"Sub1",@"Anotherview",@"About", nil];
    chker=0;
    [super viewDidLoad];
    rootView = self.view;
    menuShowing=NO;
    
    [MenuBtn setImage:[UIImage imageNamed:@"45_Menu-128.png"] forState:UIControlStateNormal];
    menuView=[WGPresentationViewController MakeMeuView];
    CGRect newFrame = menuView.frame;
    newFrame.origin.y -= 16;
    menuView.frame =newFrame;
    
    UIButton *MenuItem1=(UIButton*)[menuView viewWithTag:1];
    MenuItem2=(UIButton*)[menuView viewWithTag:2];
    MenuItem3=(UIButton*)[menuView viewWithTag:3];
    MenuItem4=(UIButton*)[menuView viewWithTag:4];
    
    [MenuItem1 addTarget:self action:@selector(GotoPage:) forControlEvents:UIControlEventTouchUpInside];
    //[MenuItem2 addTarget:self action:@selector(GotoPage:) forControlEvents:UIControlEventTouchUpInside];
    //[MenuItem3 addTarget:self action:@selector(GotoPage:) forControlEvents:UIControlEventTouchUpInside];
    //[MenuItem2 addTarget:self action:@selector(showsubMenuPresentation) forControlEvents:UIControlEventTouchUpInside];
    
    [MenuItem3 addTarget:self action:@selector(showsubMenu) forControlEvents:UIControlEventTouchUpInside];
    [MenuItem4 addTarget:self action:@selector(GotoPage:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //UIButton *subMenuItem1=(UIButton*)[subMenuView viewWithTag:1];
    //UIButton *subMenuItem2=(UIButton*)[subMenuView viewWithTag:2];
    
    subMenuView=[WGPresentationViewController MakeSubMeuView];
    CGRect newFramesubMenuView = subMenuView.frame;
    newFramesubMenuView.origin.y -= 16;
    subMenuView.frame =newFramesubMenuView;
    
    
    subMenuView.alpha=0;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.barTintColor = [WGViewController colorFromHexString:NavigationBar];
    self.navigationController.navigationBar.translucent = YES;
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Server Unreachable"
                                  message:@"Cannot reach the server. This may result in outdated data. Would you like to proceed?"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"Proceed"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Try Again"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    [alert addAction:ok];
    [alert addAction:cancel];
    
    
    BOOL netWork=[self isNetworkAvailable];
    if (!netWork) {
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    
    
    
    
    if (chker==0) {
        [self showIntroWithCustomPages];
    }
    [MenuBtn addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    
    [leftBtn addTarget:self action:@selector(PreviousSlide) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn addTarget:self action:@selector(NextSlide) forControlEvents:UIControlEventTouchUpInside];
    [self.view setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark -EA introView and navigation

- (void)showIntroWithCustomPages {
    NSMutableArray *array=[[NSMutableArray alloc]init];
    
    
    if ([SubmenuOptionSelected isEqualToString:@"Slides"]) {
        NSLog(@"Please Show Slides");
        NSURL *ImagesUrl = [NSURL URLWithString:WebDirectory];
        NSData *ImageHtmlData = [NSData dataWithContentsOfURL:ImagesUrl];
        
        // 2
        TFHpple *ImageParser = [TFHpple hppleWithHTMLData:ImageHtmlData];
        NSString *imagesSearchString = @"//a"; // grabbs all image tags
        NSArray *node = [ImageParser searchWithXPathQuery:imagesSearchString];
        NSString *SearchString;
        NSMutableArray *OnlySpecificImagesFormat=[[NSMutableArray alloc]init];
        for (TFHppleElement *ele in node) {
            SearchString=[ele objectForKey:@"href"];
            if ([SearchString containsString:@".jpg"]||[SearchString containsString:@".png"]||[SearchString containsString:@".JPG"]||[SearchString containsString:@".PNG"]) {
                [OnlySpecificImagesFormat addObject:[NSString stringWithFormat:@"%@%@",ImagesUrl,SearchString]];
            }
        }
        NSLog(@"node dat is %@",OnlySpecificImagesFormat);
        for(int i=1;i<=[OnlySpecificImagesFormat count];i++){
            
            EAIntroPage *page0 = [EAIntroPage page];
            page0.title = [NSString stringWithFormat:@"Slide number : %i",i];
            
            page0.titleColor=[WGViewController colorFromHexString:TextColor];
            page0.descColor=[WGViewController colorFromHexString:TextColor];
            
            
            page0.titleIconView=[[UIImageView alloc] init];
            
            
            
            
            if (self.view.frame.size.width>self.view.frame.size.height) {
                page0.titleIconView.frame = rootView.bounds;
                
            }
            else{
                page0.titleIconView.frame = CGRectMake(0, 0, self.view.frame.size.height,self.view.frame.size.width );
                
            }
            UIImageView *SliderImage=[[UIImageView alloc] initWithFrame:CGRectMake(0, -30, page0.titleIconView.frame.size.width, page0.titleIconView.frame.size.height)];
            [SliderImage setImageWithURL:[NSURL URLWithString:[OnlySpecificImagesFormat objectAtIndex:i-1]] placeholderImage:[UIImage imageNamed:@"PleaseWait.gif"]];
            
            
            page0.titleIconView.contentMode = UIViewContentModeScaleAspectFit;
            
            SliderImage.contentMode = UIViewContentModeScaleAspectFit;
            
            [page0.titleIconView addSubview:SliderImage];
            
            [array addObject:page0];
            
            
        }
    }
    else if ([SubmenuOptionSelected isEqualToString:@"Videos"]) {
        NSLog(@"Please Show Websites");
        EAIntroPage *pageVideo = [EAIntroPage page];
        pageVideo.title = [NSString stringWithFormat:@"Slide number : %i",[array count]];
        
        
        
        pageVideo.customView=[[UIImageView alloc] initWithFrame:rootView.bounds];
        pageVideo.customView.userInteractionEnabled = YES ;
        
        
        NSURL *urlVideos = [NSURL URLWithString:WebSiteVideo];
        controller= [[MPMoviePlayerController alloc]initWithContentURL:urlVideos];
        
        self.mc = controller; //Super important
        controller.view.frame = self.view.bounds; //Set the size
        
        [pageVideo.customView addSubview:controller.view]; //Show the view
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayBackDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:controller];
        [controller play];
        [array addObject:pageVideo];
    }
    else if ([SubmenuOptionSelected isEqualToString:@"Websites"]) {
        NSLog(@"Please Show Videos");
        EAIntroPage *pageweb = [EAIntroPage page];
        pageweb.title = [NSString stringWithFormat:@"Slide number : %i",[array count]];
        
        UIWebView *sliderWebsite=[[UIWebView alloc] initWithFrame:rootView.bounds];
        
        sliderWebsite.delegate=self;
        sliderWebsite.backgroundColor=[UIColor whiteColor];
        NSURL *url = [NSURL URLWithString:WebSite];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [sliderWebsite loadRequest:request];
        
        pageweb.customView=[[UIImageView alloc] initWithFrame:rootView.bounds];
        pageweb.customView.userInteractionEnabled = YES ;
        
        [pageweb.customView addSubview:sliderWebsite];
        [pageweb.customView bringSubviewToFront:sliderWebsite];
        
        [array addObject:pageweb];
        
    }
    
    [ProgressHUD show:@"Please wait..."];
    
    chker=1;
    NSArray *simplearray=[NSArray arrayWithArray:array];
    
    
    
    
    intro = [[EAIntroView alloc] initWithFrame:rootView.bounds andPages:@[]];
    intro.bgImage = [UIImage imageNamed:@"screen-background (1)"];
    intro.backgroundColor=[UIColor whiteColor];
    intro.skipButton.tintColor=[UIColor blackColor];
    
    intro.pages=simplearray;
    
    intro.pageControlY = 250.0f;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [btn setFrame:CGRectMake((320-230)/2, [UIScreen mainScreen].bounds.size.height - 50, 230, 40)];
    
    /*if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
     {
     
     }
     else{
     [btn setFrame:CGRectMake((320-230)/2, [UIScreen mainScreen].bounds.size.height - 360, 230, 40)];
     
     }*/
    
    
    [btn setTitle:@"SKIP NOW" forState:UIControlStateNormal];
    [btn setTitleColor:[WGViewController colorFromHexString:@"663609"] forState:UIControlStateNormal];
    btn.layer.borderWidth = 2.0f;
    btn.layer.cornerRadius = 10;
    btn.layer.borderColor = [[WGViewController colorFromHexString:@"663609"] CGColor];
    intro.skipButton = btn;
    intro.backgroundColor=[WGViewController colorFromHexString:ButtonsBackgroundColor];
    [intro setDelegate:self];
    [intro setDelegate:self];
    [intro showInView:rootView animateDuration:0.3];
    
    
    
    [self.view bringSubviewToFront:leftBtn];
    [self.view bringSubviewToFront:rightBtn];
    //[self.navigationController setNavigationBarHidden:!self.navigationController.navigationBarHidden animated:YES];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [backButton setImage:[UIImage imageNamed:@"left-arrow.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    [ProgressHUD dismiss];
}
- (void)introDidFinish:(EAIntroView *)introView {
    NSLog(@"Presentation Finished");
    
    
    /*UIButton *backButtonMenu = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
     [backButtonMenu setImage:[UIImage imageNamed:@"45_Menu-128.png"] forState:UIControlStateNormal];
     [backButtonMenu addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButtonMenu];*/
    
    chker=0;
}

-(void)NextSlide{
    NSLog(@"total is %i",[intro.pages count]);
    [intro setCurrentPageIndex:intro.currentPageIndex+1 animated:YES];
    if ([intro.pages count]==intro.currentPageIndex+1) {
        [intro hideWithFadeOutDuration:0.3];
    }
}
-(void)PreviousSlide{
    NSLog(@"Last");
    [intro setCurrentPageIndex:intro.currentPageIndex-1 animated:YES];
}
- (IBAction)AgainFunction:(id)sender {
    [ProgressHUD show:@"Please wait..."];
    [self showIntroWithCustomPages];
    
}
- (void)intro:(EAIntroView *)introView pageAppeared:(EAIntroPage *)page withIndex:(NSInteger)pageIndex{
    NSLog(@"page number of index is %i",pageIndex);
    
}

#pragma mark -
#pragma mark -Navigation to Pages


-(void)GotoPage:(UIButton *) sender{
    if (sender.tag==1) {
        [self performSegueWithIdentifier: @"Presentation-Dashboard" sender: self];
    }
    else if(sender.tag==2){
    }
    else if(sender.tag==3){
        [self performSegueWithIdentifier: @"Presentation-Training" sender: self];
        [self.view setAlpha:0.4];
        [ProgressHUD show:@"Please wait..."];
    }
    else if(sender.tag==4){
        WGViewController* infoController = [self.storyboard instantiateViewControllerWithIdentifier:@"Login"];
        NSMutableArray *viewControllers = [NSMutableArray arrayWithArray: self.navigationController.viewControllers];
        [viewControllers removeObjectIdenticalTo:self];
        [viewControllers addObject:infoController];
        [self.navigationController setViewControllers: viewControllers animated: YES];
    }
    else{
        NSLog(@"Something has gone wrong in the click menu at =  %@",sender);
    }
}
-(void)backAction{
    
    NSString *previosController=self.PreviousPage;
    NSString *SegueIdentifier=[NSString stringWithFormat:@"Presentation-%@",previosController];
    
    
    [self performSegueWithIdentifier: SegueIdentifier sender: self];
    
    
}


#pragma mark -
#pragma mark -Menu and Sub menu Showing


-(void)showMenu{
    if (menuShowing) {
        CGRect newFrame = menuView.frame;
        newFrame.origin.x -= 200;
        CGRect newFrame1 = snapShot.frame;
        newFrame1.origin.x -=200;
        [UIView animateWithDuration:0.25
                         animations:^{
                             menuView.frame = newFrame;
                             snapShot.frame = newFrame1;
                         }
                         completion:^(BOOL finished){
                             [self.view sendSubviewToBack:snapShot];
                             [snapShot removeFromSuperview];
                             snapShot=nil;
                         }
         ];
        menuShowing=NO;
    }
    else{
        if (snapShot==nil) {
            snapShot=[self.view snapshotViewAfterScreenUpdates:NO];
            [snapShot setBackgroundColor:[UIColor whiteColor]];
            [self.view addSubview:snapShot];
            [self.view bringSubviewToFront:snapShot];
        }
        [self.view bringSubviewToFront:snapShot];
        [self.view addSubview:menuView];
        CGRect newFrame = menuView.frame;
        CGRect newMAinFrame=self.view.frame;
        newMAinFrame.origin.x +=200;
        newFrame.origin.x += 200;
        
        CGRect newFrame1 = snapShot.frame;
        newFrame1.origin.x +=200;
        
        [UIView animateWithDuration:0.25
                         animations:^{
                             menuView.frame = newFrame;
                             snapShot.frame = newFrame1;
                         }];
        menuShowing=YES;
    }
    
}








-(void)showsubMenu{
    if (!subMenuShowing) {
        [MenuItem3 setEnabled:NO];
        [MenuItem3 setImage:[UIImage imageNamed:@"tie-Highlighted.png"] forState:UIControlStateNormal];
        [MenuItem3 setImage:[UIImage imageNamed:@"tie-Normal.png"] forState:UIControlStateHighlighted];
        [MenuItem3 setImage:[UIImage imageNamed:@"tie-Highlighted.png"] forState:UIControlStateDisabled];
        [MenuItem3 setBackgroundImage:[UIImage imageNamed:@"menu-background-Normal-new"] forState:UIControlStateHighlighted];
        [MenuItem3 setBackgroundImage:[UIImage imageNamed:@"menu-background-highlighted-new"] forState:UIControlStateNormal];
        [MenuItem3 setBackgroundImage:[UIImage imageNamed:@"menu-background-highlighted-new"] forState:UIControlStateDisabled];
        [MenuItem3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:subMenuView];
        CGRect newLogOutFrame = MenuItem4.frame;
        newLogOutFrame.origin.y += 100;
        [UIView animateWithDuration:0.25
                         animations:^{
                             MenuItem4.frame = newLogOutFrame;
                             subMenuView.alpha=1;
                         }
                         completion:^(BOOL finished){
                             subMenuShowing=YES;
                             [MenuItem3 setEnabled:YES];
                         }
         ];
    }
    else{
        [MenuItem3 setEnabled:NO];
        [MenuItem3 setImage:[UIImage imageNamed:@"tie-Normal.png"] forState:UIControlStateNormal];
        [MenuItem3 setImage:[UIImage imageNamed:@"tie-Highlighted.png"] forState:UIControlStateHighlighted];
        [MenuItem3 setImage:[UIImage imageNamed:@"tie-Normal.png"] forState:UIControlStateDisabled];
        [MenuItem3 setBackgroundImage:[UIImage imageNamed:@"menu-background-highlighted-new"] forState:UIControlStateHighlighted];
        [MenuItem3 setBackgroundImage:[UIImage imageNamed:@"menu-background-Normal-new"] forState:UIControlStateNormal];
        [MenuItem3 setBackgroundImage:[UIImage imageNamed:@"menu-background-Normal-new"] forState:UIControlStateDisabled];
        [MenuItem3 setTitleColor:[WGViewController colorFromHexString:TextColor] forState:UIControlStateNormal];
        CGRect newLogOutFrame = MenuItem4.frame;
        newLogOutFrame.origin.y -= 100;
        [UIView animateWithDuration:0.25
                         animations:^{
                             MenuItem4.frame = newLogOutFrame;
                             subMenuView.alpha=0;
                         }
                         completion:^(BOOL finished){
                             subMenuShowing=NO;
                             [MenuItem3 setEnabled:YES];
                         }
         ];
    }
}
#pragma mark -
#pragma mark -Webview and media player delgate methods

- (void) moviePlayBackDidFinish:(NSNotification*)notification
{
    
    NSLog(@"Movie has been watched allround");
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    NSLog(@"started");
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    NSLog(@"Page loaded successfully");
    [self.view setAlpha:1];
    [ProgressHUD dismiss];
    
    
    
}



#pragma mark -
#pragma mark -Miscs

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

-(BOOL)isNetworkAvailable
{
    char *hostname;
    struct hostent *hostinfo;
    hostname = "google.com";
    hostinfo = gethostbyname (hostname);
    if (hostinfo == NULL){
        NSLog(@"-> no connection!\n");
        return NO;
    }
    else{
        NSLog(@"-> connection established!\n");
        return YES;
    }
}


#pragma mark -
#pragma mark -Global Menu Making
+(UIView*)MakeMeuView{
    UIView *MenuViewMake=[[UIView alloc] initWithFrame:CGRectMake(-200, 60, 200, 1000)];
    [MenuViewMake setBackgroundColor:[WGViewController colorFromHexString:GreyColor]];
    UIButton *MenuItem1=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    [MenuItem1 setTitle:@"Home" forState:UIControlStateNormal];
    [MenuItem1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [MenuItem1 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    MenuItem1.titleLabel.font = [UIFont systemFontOfSize:20];
    MenuItem1.imageView.contentMode = UIViewContentModeScaleAspectFit;
    MenuItem1.titleEdgeInsets = UIEdgeInsetsMake(0, -50, 0, 0);
    MenuItem1.imageEdgeInsets = UIEdgeInsetsMake(10, -80 , 5, 0);
    MenuItem1.imageView.frame = CGRectMake(23, -50, MenuItem1.imageView.frame.size.width, MenuItem1.imageView.frame.size.height);
    [MenuItem1 setImage:[UIImage imageNamed:@"home.png"] forState:UIControlStateNormal];
    [MenuItem1 setImage:[UIImage imageNamed:@"home.png"] forState:UIControlStateHighlighted];
    //[MenuItem1 setBackgroundImage:[UIImage imageNamed:@"menu-background-Normal-new"] forState:UIControlStateNormal];
    [MenuItem1 setBackgroundImage:[UIImage imageNamed:@"menu-background-Normal-new"] forState:UIControlStateHighlighted];
    MenuItem1.tag=1;
    [[MenuItem1 layer] setBorderWidth:0.5f];
    [[MenuItem1 layer] setBorderColor:[UIColor blackColor].CGColor];
    [MenuViewMake addSubview:MenuItem1];
    UIButton *MenuItem2=[[UIButton alloc] initWithFrame:CGRectMake(0, 50, 200, 50)];
    [MenuItem2 setTitle:@"Presentation" forState:UIControlStateNormal];
    [MenuItem2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [MenuItem2 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    MenuItem2.titleLabel.font = [UIFont systemFontOfSize:20];
    MenuItem2.imageView.contentMode = UIViewContentModeScaleAspectFit;
    MenuItem2.titleEdgeInsets = UIEdgeInsetsMake(0, 05, 0, 0);
    MenuItem2.imageEdgeInsets = UIEdgeInsetsMake(10, -20 , 5, 0);
    MenuItem2.imageView.frame = CGRectMake(23, -50, MenuItem2.imageView.frame.size.width, MenuItem2.imageView.frame.size.height);
    [MenuItem2 setImage:[UIImage imageNamed:@"presentation.png"] forState:UIControlStateNormal];
    [MenuItem2 setImage:[UIImage imageNamed:@"presentation.png"] forState:UIControlStateHighlighted];
    //[MenuItem2 setBackgroundImage:[UIImage imageNamed:@"menu-background-Normal-new"] forState:UIControlStateNormal];
    MenuItem2.tag=2;
    [MenuItem2 setBackgroundImage:[UIImage imageNamed:@"menu-background-Normal-new"] forState:UIControlStateHighlighted];
    [[MenuItem2 layer] setBorderWidth:0.5f];
    [[MenuItem2 layer] setBorderColor:[UIColor blackColor].CGColor];
    [MenuViewMake addSubview:MenuItem2];
    UIButton *MenuItem3=[[UIButton alloc] initWithFrame:CGRectMake(0, 100, 200, 50)];
    [MenuItem3 setTitle:@"Activity" forState:UIControlStateNormal];
    [MenuItem3 setBackgroundImage:[UIImage imageNamed:@"menu-background-Hihglighted"] forState:UIControlStateHighlighted];
    [MenuItem3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [MenuItem3 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    MenuItem3.titleLabel.font = [UIFont systemFontOfSize:20];
    MenuItem3.imageView.contentMode = UIViewContentModeScaleAspectFit;
    MenuItem3.titleEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
    MenuItem3.imageEdgeInsets = UIEdgeInsetsMake(10, -60 , 5, 0);
    MenuItem3.imageView.frame = CGRectMake(23, -50, MenuItem3.imageView.frame.size.width, MenuItem3.imageView.frame.size.height);
    [MenuItem3 setImage:[UIImage imageNamed:@"training.png"] forState:UIControlStateNormal];
    [MenuItem3 setImage:[UIImage imageNamed:@"training.png"] forState:UIControlStateHighlighted];
    [MenuItem3 setBackgroundImage:[UIImage imageNamed:@"menu-background-Normal-new"] forState:UIControlStateHighlighted];
    //[MenuItem3 setBackgroundImage:[UIImage imageNamed:@"menu-background-Normal-new"] forState:UIControlStateNormal];
    MenuItem3.tag=3;
    [[MenuItem3 layer] setBorderWidth:0.5f];
    [[MenuItem3 layer] setBorderColor:[UIColor blackColor].CGColor];
    [MenuViewMake addSubview:MenuItem3];
    UIButton *MenuItem4=[[UIButton alloc] initWithFrame:CGRectMake(0, 200, 200, 50)];
    [MenuItem4 setTitle:@"Log Out" forState:UIControlStateNormal];
    [MenuItem4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [MenuItem4 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    MenuItem4.titleLabel.font = [UIFont systemFontOfSize:20];
    MenuItem4.imageView.contentMode = UIViewContentModeScaleAspectFit;
    MenuItem4.titleEdgeInsets = UIEdgeInsetsMake(0, -35, 0, 0);
    MenuItem4.imageEdgeInsets = UIEdgeInsetsMake(10, -60 , 5, 0);
    MenuItem4.imageView.frame = CGRectMake(23, -50, MenuItem4.imageView.frame.size.width, MenuItem4.imageView.frame.size.height);
    [MenuItem4 setImage:[UIImage imageNamed:@"logout.png"] forState:UIControlStateNormal];
    [MenuItem4 setImage:[UIImage imageNamed:@"logout.png"] forState:UIControlStateHighlighted];
    [MenuItem4 setBackgroundColor:[UIColor blackColor]];
    //[MenuItem4 setBackgroundImage:[UIImage imageNamed:@"menu-background-Normal-new"] forState:UIControlStateHighlighted];
    //[MenuItem4 setBackgroundImage:[UIImage imageNamed:@"menu-background-Normal-new"] forState:UIControlStateNormal];
    MenuItem4.tag=4;
    [[MenuItem4 layer] setBorderWidth:0.5f];
    [[MenuItem4 layer] setBorderColor:[UIColor blackColor].CGColor];
    [MenuViewMake addSubview:MenuItem4];
    
    UIButton *MenuItem5=[[UIButton alloc] initWithFrame:CGRectMake(0, 150, 200, 50)];
    [MenuItem5 setTitle:@"Leads" forState:UIControlStateNormal];
    [MenuItem5 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [MenuItem5 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    MenuItem5.titleLabel.font = [UIFont systemFontOfSize:20];
    MenuItem5.imageView.contentMode = UIViewContentModeScaleAspectFit;
    MenuItem5.titleEdgeInsets = UIEdgeInsetsMake(0, -50, 0, 0);
    MenuItem5.imageEdgeInsets = UIEdgeInsetsMake(10, -75 , 5, 0);
    MenuItem5.imageView.frame = CGRectMake(23, -50, MenuItem4.imageView.frame.size.width, MenuItem4.imageView.frame.size.height);
    [MenuItem5 setImage:[UIImage imageNamed:@"leads.png"] forState:UIControlStateNormal];
    [MenuItem5 setImage:[UIImage imageNamed:@"leads.png"] forState:UIControlStateHighlighted];
    //[MenuItem5 setBackgroundImage:[UIImage imageNamed:@"menu-background-Normal-new"] forState:UIControlStateHighlighted];
    //[MenuItem5 setBackgroundImage:[UIImage imageNamed:@"menu-background-Normal-new"] forState:UIControlStateHighlighted];

    //[MenuItem5 setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    MenuItem5.tag=5;
    [[MenuItem5 layer] setBorderWidth:0.5f];
    [[MenuItem5 layer] setBorderColor:[UIColor blackColor].CGColor];
    [MenuViewMake addSubview:MenuItem5];
    
    
    return MenuViewMake;
}
+(UIView*)MakeSubMeuView{
    UIView *MenuViewMake=[[UIView alloc] initWithFrame:CGRectMake(0, 210, 200, 100)];
    [MenuViewMake setBackgroundColor:[WGViewController colorFromHexString:NavigationBar]];
    
    UIButton *MenuItem3=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    [MenuItem3 setTitle:@"Activities" forState:UIControlStateNormal];
    [MenuItem3 setBackgroundImage:[UIImage imageNamed:@"menu-background-Hihglighted"] forState:UIControlStateHighlighted];
    [MenuItem3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [MenuItem3 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    MenuItem3.titleLabel.font = [UIFont systemFontOfSize:17];
    MenuItem3.imageView.contentMode = UIViewContentModeScaleAspectFit;
    MenuItem3.titleEdgeInsets = UIEdgeInsetsMake(0, 10, -10, 0);
    MenuItem3.imageEdgeInsets = UIEdgeInsetsMake(15, 0 , 5, 0);
    MenuItem3.imageView.frame = CGRectMake(23, -50, MenuItem3.imageView.frame.size.width, MenuItem3.imageView.frame.size.height);
    [MenuItem3 setImage:[UIImage imageNamed:@"training.png"] forState:UIControlStateNormal];
    //[MenuItem3 setImage:[UIImage imageNamed:@"tie-Normal.png"] forState:UIControlStateHighlighted];
    [MenuItem3 setBackgroundImage:[UIImage imageNamed:@"menu-background-Normal-new"] forState:UIControlStateHighlighted];
    //[MenuItem3 setBackgroundImage:[UIImage imageNamed:@"menu-background-Normal-new"] forState:UIControlStateNormal];
    MenuItem3.tag=21;
    [[MenuItem3 layer] setBorderWidth:0.5f];
    [[MenuItem3 layer] setBorderColor:[UIColor blackColor].CGColor];
    [MenuViewMake addSubview:MenuItem3];
    UIButton *MenuItem4=[[UIButton alloc] initWithFrame:CGRectMake(0, 50, 200, 50)];
    [MenuItem4 setTitle:@"Calender" forState:UIControlStateNormal];
    [MenuItem4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [MenuItem4 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    MenuItem4.titleLabel.font = [UIFont systemFontOfSize:17];
    MenuItem4.imageView.contentMode = UIViewContentModeScaleAspectFit;
    MenuItem4.titleEdgeInsets = UIEdgeInsetsMake(0, 10, -10, 0);
    MenuItem4.imageEdgeInsets = UIEdgeInsetsMake(15, 0 , 5, 0);
    MenuItem4.imageView.frame = CGRectMake(23, -50, MenuItem4.imageView.frame.size.width, MenuItem4.imageView.frame.size.height);
    [MenuItem4 setImage:[UIImage imageNamed:@"training.png"] forState:UIControlStateNormal];
    //[MenuItem4 setImage:[UIImage imageNamed:@"tie-Normal.png"] forState:UIControlStateHighlighted];
    [MenuItem4 setBackgroundImage:[UIImage imageNamed:@"menu-background-Normal-new"] forState:UIControlStateHighlighted];
    //[MenuItem4 setBackgroundImage:[UIImage imageNamed:@"menu-background-Normal-new"] forState:UIControlStateNormal];
    MenuItem4.tag=22;
    [[MenuItem4 layer] setBorderWidth:0.5f];
    [[MenuItem4 layer] setBorderColor:[UIColor blackColor].CGColor];
    [MenuViewMake addSubview:MenuItem4];
    UIView *EmptyWhiteView=[[UIView alloc] initWithFrame:CGRectMake(0, 200, 200, 800)];
    [EmptyWhiteView setBackgroundColor:[WGViewController colorFromHexString:NavigationBar]];
    [MenuViewMake addSubview:EmptyWhiteView];
    
    return MenuViewMake;
}
+(UIView*)MakeSubMeuViewPresentation{
    UIView *MenuViewMake=[[UIView alloc] initWithFrame:CGRectMake(0, 160, 200, 150)];
    [MenuViewMake setBackgroundColor:[WGViewController colorFromHexString:NavigationBar]];
    
    UIButton *MenuItem3=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    [MenuItem3 setTitle:@"Slides" forState:UIControlStateNormal];
    [MenuItem3 setBackgroundImage:[UIImage imageNamed:@"menu-background-Hihglighted"] forState:UIControlStateHighlighted];
    [MenuItem3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [MenuItem3 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    MenuItem3.titleLabel.font = [UIFont systemFontOfSize:17];
    MenuItem3.imageView.contentMode = UIViewContentModeScaleAspectFit;
    MenuItem3.titleEdgeInsets = UIEdgeInsetsMake(0, -20, -10, 0);
    MenuItem3.imageEdgeInsets = UIEdgeInsetsMake(15, -30 , 5, 0);
    MenuItem3.imageView.frame = CGRectMake(23, -50, MenuItem3.imageView.frame.size.width, MenuItem3.imageView.frame.size.height);
    [MenuItem3 setImage:[UIImage imageNamed:@"presentation.png"] forState:UIControlStateNormal];
    //[MenuItem3 setImage:[UIImage imageNamed:@"tie-Normal.png"] forState:UIControlStateHighlighted];
    [MenuItem3 setBackgroundImage:[UIImage imageNamed:@"menu-background-Normal-new"] forState:UIControlStateHighlighted];
    //[MenuItem3 setBackgroundImage:[UIImage imageNamed:@"menu-background-Normal-new"] forState:UIControlStateNormal];
    MenuItem3.tag=1;
    [MenuViewMake addSubview:MenuItem3];
    UIButton *MenuItem4=[[UIButton alloc] initWithFrame:CGRectMake(0, 50, 200, 50)];
    [MenuItem4 setTitle:@"Videos" forState:UIControlStateNormal];
    [MenuItem4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [MenuItem4 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    MenuItem4.titleLabel.font = [UIFont systemFontOfSize:17];
    MenuItem4.imageView.contentMode = UIViewContentModeScaleAspectFit;
    MenuItem4.titleEdgeInsets = UIEdgeInsetsMake(0, -15, -10, 0);
    MenuItem4.imageEdgeInsets = UIEdgeInsetsMake(15,-25 , 5, 0);
    MenuItem4.imageView.frame = CGRectMake(23, -50, MenuItem4.imageView.frame.size.width, MenuItem4.imageView.frame.size.height);
    [MenuItem4 setImage:[UIImage imageNamed:@"presentation.png"] forState:UIControlStateNormal];
    //[MenuItem4 setImage:[UIImage imageNamed:@"tie-Normal.png"] forState:UIControlStateHighlighted];
    [MenuItem4 setBackgroundImage:[UIImage imageNamed:@"menu-background-Normal-new"] forState:UIControlStateHighlighted];
    //[MenuItem4 setBackgroundImage:[UIImage imageNamed:@"menu-background-Normal-new"] forState:UIControlStateNormal];
    MenuItem4.tag=2;
    [MenuViewMake addSubview:MenuItem4];
    UIButton *MenuItem5=[[UIButton alloc] initWithFrame:CGRectMake(0, 100, 200, 50)];
    [MenuItem5 setTitle:@"Websites" forState:UIControlStateNormal];
    [MenuItem5 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [MenuItem5 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    MenuItem5.titleLabel.font = [UIFont systemFontOfSize:17];
    MenuItem5.imageView.contentMode = UIViewContentModeScaleAspectFit;
    MenuItem5.titleEdgeInsets = UIEdgeInsetsMake(0, 00, -10, 0);
    MenuItem5.imageEdgeInsets = UIEdgeInsetsMake(15, -10 , 5, 0);
    MenuItem5.imageView.frame = CGRectMake(23, -50, MenuItem5.imageView.frame.size.width, MenuItem5.imageView.frame.size.height);
    [MenuItem5 setImage:[UIImage imageNamed:@"presentation.png"] forState:UIControlStateNormal];
    //[MenuItem5 setImage:[UIImage imageNamed:@"tie-Normal.png"] forState:UIControlStateHighlighted];
    [MenuItem5 setBackgroundImage:[UIImage imageNamed:@"menu-background-Normal-new"] forState:UIControlStateHighlighted];
    //[MenuItem5 setBackgroundImage:[UIImage imageNamed:@"menu-background-Normal-new"] forState:UIControlStateNormal];
    MenuItem5.tag=3;

    [MenuViewMake addSubview:MenuItem5];
    
    UIView *EmptyWhiteView=[[UIView alloc] initWithFrame:CGRectMake(0, 200, 200, 800)];
    [EmptyWhiteView setBackgroundColor:[WGViewController colorFromHexString:NavigationBar]];
    
    return MenuViewMake;
}

@end
