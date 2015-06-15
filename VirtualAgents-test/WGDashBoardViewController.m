//
//  WGDashBoardViewController.m
//  VirtualAgents-test
//
//  Created by saqib on 12/10/14.
//  Copyright (c) 2014 Muhammad Saqib Yaqeen. All rights reserved.
//

#import "WGDashBoardViewController.h"
#import "WGViewController.h"
#import "WGPresentationViewController.h"
#import "ProgressHUD.h"

@interface WGDashBoardViewController (){
    BOOL menuShowing;
    UIView *menuView;
    UIView *snapShot;
    UIView *subMenuView;
    UIView *subMenuViewPresentation;
    UIButton *MenuItem2;
    UIButton *MenuItem3;
    UIButton *MenuItem4;
    UIButton *MenuItem5;
    BOOL subMenuShowing;
    BOOL subMenuShowingPresentation;
    

}

@end

@implementation WGDashBoardViewController
@synthesize menuBtn;
@synthesize MoveableView;
@synthesize TitleTxt;

#pragma mark -
#pragma mark -LifeCycle functions

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
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [WGViewController colorFromHexString:GreyColor];
    self.navigationController.navigationBar.translucent = YES;
    menuShowing=NO;

    [menuBtn setImage:[UIImage imageNamed:@"nav-icon.png"] forState:UIControlStateNormal];
    menuView=[WGPresentationViewController MakeMeuView];
    [TitleTxt setTextColor:[WGViewController colorFromHexString:BlueColor]];
    
    UIButton *MenuItem1=(UIButton*)[menuView viewWithTag:1];
    MenuItem2=(UIButton*)[menuView viewWithTag:2];
    MenuItem3=(UIButton*)[menuView viewWithTag:3];
    MenuItem4=(UIButton*)[menuView viewWithTag:4];
    MenuItem5=(UIButton*)[menuView viewWithTag:5];

    [MenuItem1 addTarget:self action:@selector(GotoPage:) forControlEvents:UIControlEventTouchUpInside];
    //[MenuItem2 addTarget:self action:@selector(GotoPage:) forControlEvents:UIControlEventTouchUpInside];
    //[MenuItem3 addTarget:self action:@selector(GotoPage:) forControlEvents:UIControlEventTouchUpInside];
    [MenuItem2 addTarget:self action:@selector(showsubMenuPresentation) forControlEvents:UIControlEventTouchUpInside];
    [MenuItem3 addTarget:self action:@selector(showsubMenu) forControlEvents:UIControlEventTouchUpInside];
    [MenuItem4 addTarget:self action:@selector(GotoPage:) forControlEvents:UIControlEventTouchUpInside];
    [MenuItem5 addTarget:self action:@selector(GotoPage:) forControlEvents:UIControlEventTouchUpInside];
    
    subMenuView=[WGPresentationViewController MakeSubMeuView];
    UIButton *subMenuItem1=(UIButton*)[subMenuView viewWithTag:21];
    UIButton *subMenuItem2=(UIButton*)[subMenuView viewWithTag:22];
    [subMenuItem1 addTarget:self action:@selector(GotoPage:) forControlEvents:UIControlEventTouchUpInside];
    [subMenuItem2 addTarget:self action:@selector(GotoPage:) forControlEvents:UIControlEventTouchUpInside];

    
    subMenuView.alpha=0;
    

    
    
    subMenuViewPresentation=[WGPresentationViewController MakeSubMeuViewPresentation];
    UIButton *subMenuViewPresentationItem1=(UIButton*)[subMenuViewPresentation viewWithTag:1];
    UIButton *subMenuViewPresentationItem2=(UIButton*)[subMenuViewPresentation viewWithTag:2];
    UIButton *subMenuViewPresentationItem3=(UIButton*)[subMenuViewPresentation viewWithTag:3];
    [subMenuViewPresentationItem1 addTarget:self action:@selector(GotoPresentation:) forControlEvents:UIControlEventTouchUpInside];
    [subMenuViewPresentationItem2 addTarget:self action:@selector(GotoPresentation:) forControlEvents:UIControlEventTouchUpInside];
    [subMenuViewPresentationItem3 addTarget:self action:@selector(GotoPresentation:) forControlEvents:UIControlEventTouchUpInside];

    subMenuViewPresentation.alpha=0;

    
}
-(void)viewWillAppear:(BOOL)animated{
    
    
    
    [menuBtn addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];

    subMenuShowing=NO;
    subMenuShowingPresentation=NO;
    
    NSUserDefaults *Preference=[NSUserDefaults standardUserDefaults];
    
    NSString *User=[Preference objectForKey:@"CurrentUser"];
    NSLog(@"the logged in user is : %@",User);
    
    
    
    
}
#pragma mark -
#pragma mark -Navigation to Pages

-(void)GotoPage:(UIButton *) sender{
    
    if (sender.tag==1) {
        //[self performSegueWithIdentifier: @"Dashboard-Presentation" sender: self];
        
    }
    else if(sender.tag==2){
        
        //[[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(orientationChanged:)    name:UIDeviceOrientationDidChangeNotification  object:nil];
        //[[UIDevice currentDevice] setValue:[NSNumber numberWithInteger: UIInterfaceOrientationLandscapeRight]forKey:@"orientation"];
        
        [self performSegueWithIdentifier: @"Dashboard-Presentation" sender: self];
        [self.view setAlpha:0.4];
        [ProgressHUD show:@"Please wait..."];
        
        
        
    }
    else if(sender.tag==3){
        [self performSegueWithIdentifier: @"Dashboard-Training" sender: self];
        [self.view setAlpha:0.4];
        [ProgressHUD show:@"Please wait..."];
        
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
    else if(sender.tag==5){
        [self performSegueWithIdentifier: @"Dashboard-Leads" sender: self];
    }
    else if(sender.tag==10){
        
        [self performSegueWithIdentifier: @"Dashboard-Presentation" sender: self];
        
    }
    else if(sender.tag==11){
        
        [self performSegueWithIdentifier: @"Dashboard-Presentation" sender: self];
        
    }
    else if(sender.tag==12){
        
        [self performSegueWithIdentifier: @"Dashboard-Presentation" sender: self];
        
    }
    else if(sender.tag==21){
        
        [self performSegueWithIdentifier: @"Dashboard-Activities" sender: self];
        
    }else if(sender.tag==22){
        
        [self performSegueWithIdentifier: @"Dashboard-Calender" sender: self];
        
    }
    else{
        NSLog(@"Something has gone wrong in the click menu at =  %@",sender);
        
    }
    
    
    
    
    
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [self.view setAlpha:0.4];
    [ProgressHUD show:@"Please wait..."];
    NSUserDefaults *PreviousPagePreference=[NSUserDefaults standardUserDefaults];
    [PreviousPagePreference setObject:@"Dashboard" forKey:@"PageName"];
    
    
    [PreviousPagePreference synchronize];
    
    
}

-(void)GotoPresentation:(UIButton *) sender{
    NSUserDefaults *PreviousPagePreference=[NSUserDefaults standardUserDefaults];
    if (sender.tag==1) {            //for the slides
        NSLog(@"going to the slides");
        
        [PreviousPagePreference setObject:@"Slides" forKey:@"SubMeunName"];
        [self performSegueWithIdentifier: @"Dashboard-Presentation" sender: self];
        
    }
    else if(sender.tag==2) {            //for the videos
        NSLog(@"going to the videos");
        [PreviousPagePreference setObject:@"Videos" forKey:@"SubMeunName"];
        [self performSegueWithIdentifier: @"Dashboard-Presentation" sender: self];
    }
    else if(sender.tag==3) {            //for the websites
        NSLog(@"going to the websites");
        [PreviousPagePreference setObject:@"Websites" forKey:@"SubMeunName"];
        [self performSegueWithIdentifier: @"Dashboard-Presentation" sender: self];
        
    }
    [PreviousPagePreference synchronize];

}

#pragma mark -
#pragma mark -Menus and Sub Menus

-(void)showMenu{
    
    
    if (subMenuShowing) {
        [self showsubMenu];
    }
    if (subMenuShowingPresentation) {
        [self showsubMenuPresentation];
    }
    
    UISwipeGestureRecognizer *slideLeft;

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
                             [slideLeft addTarget:self action:nil];
                             slideLeft.direction=UISwipeGestureRecognizerDirectionLeft;
                             
                             [snapShot addGestureRecognizer:slideLeft];
                             slideLeft.enabled=NO;
                             
                             
                             
                         }
         ];
        menuShowing=NO;

        
    }
    else{

        if (snapShot==nil) {
            snapShot=[self.view snapshotViewAfterScreenUpdates:NO];
            [snapShot setBackgroundColor:[UIColor whiteColor]];
            
            
            slideLeft =[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(showMenu)];
            slideLeft.direction=UISwipeGestureRecognizerDirectionLeft;

            [snapShot addGestureRecognizer:slideLeft];
            
            
            [self.view addGestureRecognizer:slideLeft];
            
            
            
            [self.view addSubview:snapShot];
            [self.view bringSubviewToFront:snapShot];
            
            

        }
        [self.view bringSubviewToFront:snapShot];
        [self.view addSubview:menuView];
        CGRect newFrame = menuView.frame;
        CGRect newSelfFrame=MoveableView.frame;
        CGRect newMAinFrame=self.view.frame;
        newMAinFrame.origin.x +=200;
        newSelfFrame.origin.x +=200;
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
    if (subMenuShowingPresentation){
        [self showsubMenuPresentation];
    }
    if (!subMenuShowing) {
        [MenuItem3 setEnabled:NO];
        //[MenuItem3 setImage:[UIImage imageNamed:@"tie-Normal.png"] forState:UIControlStateNormal];
        //[MenuItem3 setImage:[UIImage imageNamed:@"tie-Highlighted.png"] forState:UIControlStateHighlighted];
        //[MenuItem3 setImage:[UIImage imageNamed:@"tie-Normal.png"] forState:UIControlStateDisabled];
        //[MenuItem3 setBackgroundImage:[UIImage imageNamed:@"menu-background-highlighted-new"] forState:UIControlStateHighlighted];
        [MenuItem3 setBackgroundImage:[UIImage imageNamed:@"menu-background-Normal-new"] forState:UIControlStateNormal];
        [MenuItem3 setBackgroundImage:[UIImage imageNamed:@"menu-background-Normal-new"] forState:UIControlStateDisabled];
        //[MenuItem3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.view addSubview:subMenuView];
        CGRect newLogOutFrame = MenuItem4.frame;
        newLogOutFrame.origin.y += 100;
        CGRect newLeadsFrame = MenuItem5.frame;
        newLeadsFrame.origin.y += 100;

        [UIView animateWithDuration:0.25
                         animations:^{
                             MenuItem4.frame = newLogOutFrame;
                             MenuItem5.frame = newLeadsFrame;
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
        //[MenuItem3 setImage:[UIImage imageNamed:@"tie-Highlighted.png"] forState:UIControlStateNormal];
        //[MenuItem3 setImage:[UIImage imageNamed:@"tie-Normal.png"] forState:UIControlStateHighlighted];
        //[MenuItem3 setImage:[UIImage imageNamed:@"tie-Normal.png"] forState:UIControlStateDisabled];
        [MenuItem3 setBackgroundImage:[UIImage imageNamed:@"menu-background-Normal-new"] forState:UIControlStateHighlighted];
        [MenuItem3 setBackgroundImage:[UIImage imageNamed:@"menu-background-grey"] forState:UIControlStateNormal];
        //[MenuItem3 setBackgroundImage:[UIImage imageNamed:@"menu-background-highlighted-new"] forState:UIControlStateDisabled];
        //[MenuItem3 setTitleColor:[WGViewController colorFromHexString:MenuText] forState:UIControlStateNormal];
        CGRect newLogOutFrame = MenuItem4.frame;
        newLogOutFrame.origin.y -= 100;
        CGRect newLeadsFrame = MenuItem5.frame;
        newLeadsFrame.origin.y -= 100;
        [UIView animateWithDuration:0.25
                         animations:^{
                             MenuItem4.frame = newLogOutFrame;
                             MenuItem5.frame = newLeadsFrame;
                             subMenuView.alpha=0;
                         }
                         completion:^(BOOL finished){
                             subMenuShowing=NO;
                             [MenuItem3 setEnabled:YES];
                         }
         ];
    }
}
-(void)showsubMenuPresentation{
    if (subMenuShowing) {
        [self showsubMenu];
    }
    if (!subMenuShowingPresentation) {
        [MenuItem2 setEnabled:NO];
        //[MenuItem2 setImage:[UIImage imageNamed:@"tie-Highlighted.png"] forState:UIControlStateNormal];
        //[MenuItem2 setImage:[UIImage imageNamed:@"tie-Normal.png"] forState:UIControlStateHighlighted];
        //[MenuItem2 setImage:[UIImage imageNamed:@"tie-Highlighted.png"] forState:UIControlStateDisabled];
        [MenuItem2 setBackgroundImage:[UIImage imageNamed:@"menu-background-Normal-new"] forState:UIControlStateHighlighted];
        [MenuItem2 setBackgroundImage:[UIImage imageNamed:@"menu-background-Normal-new"] forState:UIControlStateNormal];
        [MenuItem2 setBackgroundImage:[UIImage imageNamed:@"menu-background-Normal-new"] forState:UIControlStateDisabled];
        [MenuItem2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:subMenuViewPresentation];
        CGRect newTrainingFrame = MenuItem3.frame;
        newTrainingFrame.origin.y += 150;
        CGRect newLogOutFrame = MenuItem4.frame;
        newLogOutFrame.origin.y += 150;
        CGRect newLeadsFrame = MenuItem5.frame;
        newLeadsFrame.origin.y += 150;
        [UIView animateWithDuration:0.25
                         animations:^{
                             MenuItem3.frame = newTrainingFrame;
                             MenuItem4.frame = newLogOutFrame;
                             MenuItem5.frame = newLeadsFrame;
                             subMenuViewPresentation.alpha=1;
                         }
                         completion:^(BOOL finished){
                             subMenuShowingPresentation=YES;
                             [MenuItem2 setEnabled:YES];
                         }
         ];
    }
    else{
        [MenuItem2 setEnabled:NO];
        //[MenuItem2 setImage:[UIImage imageNamed:@"tie-Highlighted.png"] forState:UIControlStateNormal];
        //[MenuItem2 setImage:[UIImage imageNamed:@"tie-Normal.png"] forState:UIControlStateHighlighted];
        //[MenuItem2 setImage:[UIImage imageNamed:@"tie-Highlighted.png"] forState:UIControlStateDisabled];
        [MenuItem2 setBackgroundImage:[UIImage imageNamed:@"menu-background-Normal-new"] forState:UIControlStateHighlighted];
        [MenuItem2 setBackgroundImage:[UIImage imageNamed:@"menu-background-grey"] forState:UIControlStateNormal];
        [MenuItem2 setBackgroundImage:[UIImage imageNamed:@"menu-background-grey"] forState:UIControlStateDisabled];
        //[MenuItem2 setTitleColor:[WGViewController colorFromHexString:MenuText] forState:UIControlStateNormal];
        CGRect newTrainingFrame = MenuItem3.frame;
        newTrainingFrame.origin.y -= 150;
        CGRect newLogOutFrame = MenuItem4.frame;
        newLogOutFrame.origin.y -= 150;
        CGRect newLeadsFrame = MenuItem5.frame;
        newLeadsFrame.origin.y -= 150;
        [UIView animateWithDuration:0.25
                         animations:^{
                             MenuItem3.frame = newTrainingFrame;
                             MenuItem4.frame = newLogOutFrame;
                             MenuItem5.frame = newLeadsFrame;
                             subMenuViewPresentation.alpha=0;
                         }
                         completion:^(BOOL finished){
                             subMenuShowingPresentation=NO;
                             [MenuItem2 setEnabled:YES];
                         }
         ];
    }
}

#pragma mark -
#pragma mark -Miscs

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
