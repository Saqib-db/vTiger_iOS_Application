//
//  WGTrainingViewController.m
//  VirtualAgents-test
//
//  Created by saqib on 12/1/14.
//  Copyright (c) 2014 Muhammad Saqib Yaqeen. All rights reserved.
//

#import "WGTrainingViewController.h"
#import "WGPresentationViewController.h"
#import "WGViewController.h"
#import "WGPage1ViewController.h"
#import "WGPage1ViewController.h"
#import "TFHpple.h"
#import "ProgressHUD.h"
#import "TFHpple.h"
#import "MediaPlayer/MediaPlayer.h"


@interface WGTrainingViewController ()

@end

@implementation WGTrainingViewController
{
    NSArray *tableData;
    BOOL menuShowing;
    UIView *menuView;
    NSURL *fileURL;
    UIView *snapShot;

}
@synthesize tableObj;
@synthesize menuBtn;
@synthesize welomeText;
@synthesize videoBtn;
@synthesize PdfBtn;
@synthesize PPtBtn;
@synthesize testBtn;
@synthesize MainWebView;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)previewController
{
    return 30;
}

// returns the item that the preview controller should preview
- (id)previewController:(QLPreviewController*)previewController previewItemAtIndex:(NSInteger)idx
{
    return fileURL;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    MainWebView.backgroundColor=[UIColor whiteColor];
    self.view.backgroundColor=[UIColor whiteColor];
    
    NSURL *ImagesUrl = [NSURL URLWithString:@"http://virtualdev.ca/clients/rep/slides/"];
    NSData *ImageHtmlData = [NSData dataWithContentsOfURL:ImagesUrl];
    
    // 2
    TFHpple *ImageParser = [TFHpple hppleWithHTMLData:ImageHtmlData];
    NSString *imagesSearchString = @"//a"; // grabbs all image tags
    NSArray *node = [ImageParser searchWithXPathQuery:imagesSearchString];
    NSString *SearchString;
    NSMutableArray *OnlySpecificImagesFormat=[[NSMutableArray alloc]init];
    
    for (TFHppleElement *ele in node) {
        SearchString=[ele objectForKey:@"href"];
        if ([SearchString containsString:@".pdf"]||[SearchString containsString:@".PDF"]) {
            
            [OnlySpecificImagesFormat addObject:[NSString stringWithFormat:@"%@%@",ImagesUrl,SearchString]];
            
            
        }
    }
    
    
    NSLog(@"node dat is %@",OnlySpecificImagesFormat);
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    fileURL=[NSURL URLWithString:[OnlySpecificImagesFormat objectAtIndex:0]];
    
    QLPreviewController *pController=[[QLPreviewController alloc] init];
    pController.dataSource=self;
    //[[self navigationController] pushViewController:pController animated:YES];
    [videoBtn setTag:10];
    [videoBtn addTarget:self action:@selector(GotoPage:) forControlEvents:UIControlEventTouchUpInside];
    [PdfBtn setTag:11];
    [PdfBtn addTarget:self action:@selector(GotoPage:) forControlEvents:UIControlEventTouchUpInside];
    [PPtBtn setTag:12];
    [PPtBtn addTarget:self action:@selector(GotoPage:) forControlEvents:UIControlEventTouchUpInside];
    
    [testBtn setTag:13];

    [testBtn addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];

    
    
    //tableData = [NSArray arrayWithObjects:@"Egg Benedict", @"Mushroom Risotto", @"Full Breakfast", @"Hamburger", @"Ham and Egg Sandwich", @"Creme Brelee", @"White Chocolate Donut", @"Starbucks Coffee", @"Vegetable Curry", @"Instant Noodle with Egg", @"Noodle with BBQ Pork", @"Japanese Noodle with Pork", @"Green Tea", @"Thai Shrimp Cake", @"Angry Birds Cake", @"Ham and Cheese Panini", nil];

    menuView=[WGPresentationViewController MakeMeuView];
    
    UIButton *MenuItem1=(UIButton*)[menuView viewWithTag:1];
    UIButton *MenuItem2=(UIButton*)[menuView viewWithTag:2];
    UIButton *MenuItem3=(UIButton*)[menuView viewWithTag:3];
    UIButton *MenuItem4=(UIButton*)[menuView viewWithTag:4];

    [MenuItem1 addTarget:self action:@selector(GotoPage:) forControlEvents:UIControlEventTouchUpInside];
    [MenuItem2 addTarget:self action:@selector(GotoPage:) forControlEvents:UIControlEventTouchUpInside];
    [MenuItem3 addTarget:self action:@selector(GotoPage:) forControlEvents:UIControlEventTouchUpInside];
    [MenuItem4 addTarget:self action:@selector(GotoPage:) forControlEvents:UIControlEventTouchUpInside];

    [self.view setBackgroundColor:[WGViewController colorFromHexString:MainBackgroundColor]];


    [welomeText setTextColor:[WGViewController colorFromHexString:TextColor]];
    int count = 30;
    NSMutableArray *returnArray = [[NSMutableArray alloc] initWithCapacity:count];
    for (int i=1;i<=30;i++) {
        NSString *string = [NSString stringWithFormat:@"Traing %i",i];
        [returnArray addObject: string];
    }

    tableData=[NSArray arrayWithArray:returnArray];
    
    self.navigationController.navigationBar.barTintColor = [WGViewController colorFromHexString:NavigationBar];
    self.navigationController.navigationBar.translucent = YES;
    
    
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 320.0f, 50.0f)];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = view.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor purpleColor] CGColor], (id)[[UIColor blackColor] CGColor], nil];
    [view.layer insertSublayer:gradient atIndex:0];
    //[self.view addSubview:view];
    
    
    
    
    [self.view bringSubviewToFront:MainWebView];
    
    MainWebView.delegate=self;
    
    NSURL *url = [NSURL URLWithString:[OnlySpecificImagesFormat objectAtIndex:0]];//http://www.iosres.com/"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [MainWebView loadRequest:request];
    
    
    
    // Do any additional setup after loading the view.
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    NSLog(@"started");
    [self.view setAlpha:0.4];
    [ProgressHUD show:@"Please wait..."];
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    NSLog(@"Page loaded successfully");
    [self.view setAlpha:1];
    [ProgressHUD dismiss];
    
    
    
}
-(void)GotoPage:(UIButton *) sender{
    
    if (sender.tag==1) {
        [self performSegueWithIdentifier: @"Training-Dashboard" sender: self];


    }
    else if(sender.tag==2){
        //[[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(orientationChanged:)    name:UIDeviceOrientationDidChangeNotification  object:nil];
       // [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger: UIInterfaceOrientationLandscapeRight]forKey:@"orientation"];
        [self performSegueWithIdentifier: @"Training-Presentation" sender: self];
        [self.view setAlpha:0.4];
        [ProgressHUD show:@"Please wait..."];

        
    }
    else if(sender.tag==3){
        
        
    }
    else if(sender.tag==4){
        /*WGViewController* infoController = [self.storyboard instantiateViewControllerWithIdentifier:@"Login"];
         [self.navigationController pushViewController:infoController animated:NO];*/
        
        WGViewController* infoController = [self.storyboard instantiateViewControllerWithIdentifier:@"Login"];
        NSMutableArray *viewControllers = [NSMutableArray arrayWithArray: self.navigationController.viewControllers];
        [viewControllers removeObjectIdenticalTo:self];
        [viewControllers addObject:infoController];
        [self.navigationController setViewControllers: viewControllers animated: YES];
        
        
        
    }
    else if (sender.tag==10) {
        [self performSegueWithIdentifier: @"Training-Video" sender: self];
        
        
    }
    else if (sender.tag==11) {
        [self performSegueWithIdentifier: @"Training-Pdf" sender: self];
        
        
    }
    else if (sender.tag==12) {
        [self performSegueWithIdentifier: @"Training-Ppt" sender: self];
        
        
    }
    else{
        NSLog(@"Something has gone wrong in the click menu at =  %@",sender);

    }

    
    
    
    
}
- (void)orientationChanged:(NSNotification *)notification{
    NSLog(@"Orientation changed here....");
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    NSLog(@"segue id %@",sender);
    //[segue.destinationViewController setKll:@"training"];
       /*WGPage1ViewController *destViewController = segue.destinationViewController;
    WGPage1ViewController *w=[[WGPage1ViewController alloc]init];
    
        destViewController.parent = @"training";*/
    
}




-(void)viewWillAppear:(BOOL)animated{
    
    [menuBtn addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];

    
}
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
-(void)test{
    
    
    
   /* CGRect newFrame = self.view.frame;
    
    newFrame.origin.x += 200;
    [UIView animateWithDuration:0.25
                     animations:^{
                         self.view.frame = newFrame;
                     }];*/

    
   /* NSURL *ImagesUrl = [NSURL URLWithString:@"http://virtualdev.ca/clients/rep/slides/"];
    NSData *ImageHtmlData = [NSData dataWithContentsOfURL:ImagesUrl];
    
    // 2
    TFHpple *ImageParser = [TFHpple hppleWithHTMLData:ImageHtmlData];
    NSString *imagesSearchString = @"//a"; // grabbs all image tags
    NSArray *node = [ImageParser searchWithXPathQuery:imagesSearchString];
    NSString *SearchString;
    NSMutableArray *OnlySpecificImagesFormat=[[NSMutableArray alloc]init];

    for (TFHppleElement *ele in node) {
        SearchString=[ele objectForKey:@"href"];
        if ([SearchString containsString:@".png"]) {
            
            [OnlySpecificImagesFormat addObject:[NSString stringWithFormat:@"%@%@",ImagesUrl,SearchString]];
            
            
        }
    }
    
    
    NSLog(@"node dat is %@",OnlySpecificImagesFormat);*/

    
    
    
    
    
   
    
    
    
    
    
    
    
    
}

- (IBAction)SignOut:(id)sender {
    
    
    UITabBarController *tbc = [self.storyboard instantiateViewControllerWithIdentifier:@"Login"];
    tbc.selectedIndex=0;
    [self presentViewController:tbc animated:YES completion:nil];
}
@end
