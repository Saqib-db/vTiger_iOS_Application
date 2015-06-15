//
//  WGCalenderViewController.m
//  VirtualAgents-test
//
//  Created by saqib on 3/6/15.
//  Copyright (c) 2015 Muhammad Saqib Yaqeen. All rights reserved.
//

#import "WGCalenderViewController.h"
#import "WGPresentationViewController.h"
#import "ProgressHUD.h"
#import "LeadsTableViewCell.h"
#import "WGPresentationViewController.h"
#import "M13Checkbox.h"
#import "ProgressHUD.h"
#import "WGLeadsDetailsViewController.h"
#import "WGEditViewController.h"
#import "SVProgressHUD.h"
#import "Activity.h"


@interface WGCalenderViewController (){
    NSMutableDictionary *eventsByDate;
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
    
    NSString* UserAssigned;
    
    NSString *CurrentUser;
    
    NSMutableDictionary *Calenderdata;
    CKCalendarView *calendar;
    NSArray *_feedItems;
    
    NSArray *BackedUpArray;
    NSMutableData *receivedData;
    
    ActivityModel *_ActivityModel;


}

@end

@implementation WGCalenderViewController
@synthesize MenuBtn;
@synthesize ActionBtn;
@synthesize CalendarView;
@synthesize MDYsegment;





- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [WGViewController colorFromHexString:GreyColor];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.title=@"Calender";
    menuShowing=NO;
    
    //[MenuBtn setImage:[UIImage imageNamed:@"45_Menu-128.png"] forState:UIControlStateNormal];
    menuView=[WGPresentationViewController MakeMeuView];
    
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
    UIButton *subMenuItem1=(UIButton*)[subMenuView viewWithTag:1];
    UIButton *subMenuItem2=(UIButton*)[subMenuView viewWithTag:2];
    
    
    subMenuView.alpha=0;
    
    
    
    
    subMenuViewPresentation=[WGPresentationViewController MakeSubMeuViewPresentation];
    UIButton *subMenuViewPresentationItem1=(UIButton*)[subMenuViewPresentation viewWithTag:1];
    UIButton *subMenuViewPresentationItem2=(UIButton*)[subMenuViewPresentation viewWithTag:2];
    UIButton *subMenuViewPresentationItem3=(UIButton*)[subMenuViewPresentation viewWithTag:3];
    [subMenuViewPresentationItem1 addTarget:self action:@selector(GotoPresentation:) forControlEvents:UIControlEventTouchUpInside];
    [subMenuViewPresentationItem2 addTarget:self action:@selector(GotoPresentation:) forControlEvents:UIControlEventTouchUpInside];
    [subMenuViewPresentationItem3 addTarget:self action:@selector(GotoPresentation:) forControlEvents:UIControlEventTouchUpInside];
    
    subMenuViewPresentation.alpha=0;
    [MenuBtn addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    [ActionBtn addTarget:self action:@selector(showAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    [ProgressHUD show:@"Loading List..."];
    
    
    /*self.calendar = [JTCalendar new];
    {
        self.calendar.calendarAppearance.calendar.firstWeekday = 2; // Sunday == 1, Saturday == 7
        self.calendar.calendarAppearance.dayCircleRatio = 9. / 10.;
        self.calendar.calendarAppearance.ratioContentMenu = 2.;
        self.calendar.calendarAppearance.focusSelectedDayChangeMode = YES;
        
        // Customize the text for each month
        self.calendar.calendarAppearance.monthBlock = ^NSString *(NSDate *date, JTCalendar *jt_calendar){
            NSCalendar *calendar = jt_calendar.calendarAppearance.calendar;
            NSDateComponents *comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:date];
            NSInteger currentMonthIndex = comps.month;
            
            static NSDateFormatter *dateFormatter;
            if(!dateFormatter){
                dateFormatter = [NSDateFormatter new];
                dateFormatter.timeZone = jt_calendar.calendarAppearance.calendar.timeZone;
            }
            
            while(currentMonthIndex <= 0){
                currentMonthIndex += 12;
            }
            
            NSString *monthText = [[dateFormatter standaloneMonthSymbols][currentMonthIndex - 1] capitalizedString];
            
            return [NSString stringWithFormat:@"%ld\n%@", (long)comps.year, monthText];
        };
    }
    
    [self.calendar setMenuMonthsView:self.calendarMenuView];
    [self.calendar setContentView:self.calendarContentView];
    [self.calendar setDataSource:self];
    
    [self.calendar reloadData];*/
    
    
}

-(void)SetupCalender{
    // 0. Create a dictionary for the data source
    Calenderdata = [[NSMutableDictionary alloc] init];
    
    // 1. Wire up the data source and delegate.
    
    
    // 2. Create some events.
    
    for (int i=0; i<[_feedItems count]; i++) {
        Activity *Single_Activity=[_feedItems objectAtIndex:i];
        
        NSString *title = NSLocalizedString(Single_Activity.Subject, @"");
        NSDate *date = [NSDate dateWithDay:[Single_Activity.StartDay intValue] month:[Single_Activity.StartMonth intValue] year:[Single_Activity.StartYear intValue]];
        CKCalendarEvent *releaseUpdatedCalendarKit = [CKCalendarEvent eventWithTitle:title andDate:date andInfo:nil];
        Calenderdata[date] = @[releaseUpdatedCalendarKit];
        
        
        
    }
    
    
    
    
    /*NSString *title = NSLocalizedString(@"Release MBCalendarKit 2.2.4", @"");
    NSDate *date = [NSDate dateWithDay:14 month:03 year:2015];
    CKCalendarEvent *releaseUpdatedCalendarKit = [CKCalendarEvent eventWithTitle:title andDate:date andInfo:nil];
    
    NSString *title2 = NSLocalizedString(@"The Hunger Games: Mockingjay, Part 1", @"");
    NSDate *date2 = [NSDate dateWithDay:21 month:03 year:2015];
    CKCalendarEvent *mockingJay = [CKCalendarEvent eventWithTitle:title2 andDate:date2 andInfo:nil];
    
    NSString *title3 = NSLocalizedString(@"Integrate MBCalendarKit", @"");
    NSDate *date3 = date2;
    CKCalendarEvent *integrationEvent = [CKCalendarEvent eventWithTitle:title3 andDate:date3 andInfo:nil];
    
    //    4.  Add the events to the backing dictionary.
    //        The keys are NSDate objects that must
    //        match the ones passed data source method.
    Calenderdata[date] = @[releaseUpdatedCalendarKit];
    Calenderdata[date2] = @[mockingJay, integrationEvent];     // multiple events on one date.
    
    // 1. Instantiate a CKCalendarView
    
    // 2. Optionally, set up the datasource and delegates
    
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    */
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    //CKCalendarViewController *calendar = [CKCalendarViewController new];
    
    calendar=[[CKCalendarView alloc]initWithMode:CKCalendarViewModeMonth];
    
    // 2. Optionally, set up the datasource and delegates
    [calendar setDelegate:self];
    [calendar setDataSource:self];
    
    
    
    //UINavigationController *navigationController =
    //[[UINavigationController alloc] initWithRootViewController:calendar];
    // 3. Present the calendar
    //[self presentViewController:calendar animated:YES completion:nil];
    //[self.navigationController popToViewController:calendar animated:YES];
    
    [CalendarView addSubview:calendar];
    


}

-(void)viewWillAppear:(BOOL)animated{
    
    subMenuShowing=NO;
    subMenuShowingPresentation=NO;
    _feedItems = [[NSArray alloc] init];
    BackedUpArray=[[NSArray alloc] init];
    // Create new HomeModel object and assign it to _homeModel variable
    _ActivityModel = [[ActivityModel alloc] init];
    
    // Set this view controller object as the delegate for the home model object
    _ActivityModel.delegate = self;
    
    // Call the download items method of the home model object
    [_ActivityModel downloadItems];
    
    NSLog(@"Downloaded feed is  : %@",_ActivityModel);
    NSUserDefaults *Preference=[NSUserDefaults standardUserDefaults];
    
    CurrentUser=[Preference objectForKey:@"CurrentUser"];
    
    
    
    [SVProgressHUD showWithStatus:@"Loading List..." maskType:SVProgressHUDMaskTypeBlack];
    
    
    
    
}

-(IBAction)indexChanged:(UISegmentedControl *)sender
{
    switch (self.MDYsegment.selectedSegmentIndex)
    {
        case 0:
            [calendar setDisplayMode:CKCalendarViewModeMonth];
            break;
        case 1:
            [calendar setDisplayMode:CKCalendarViewModeWeek];
            break;
        case 2:
            [calendar setDisplayMode:CKCalendarViewModeDay];
            break;
        default:
            break; 
    } 
}

#pragma mark - CKCalendarViewDataSource

- (NSArray *)calendarView:(CKCalendarView *)calendarView eventsForDate:(NSDate *)date
{
    
    return  Calenderdata[date];
    
}

#pragma mark -
#pragma mark -Menus and Sub Menus

-(void)showMenu{
    [calendar reload];
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
                             
                             //[snapShot addGestureRecognizer:slideLeft];
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
            
            //[snapShot addGestureRecognizer:slideLeft];
            
            
            [self.view addGestureRecognizer:slideLeft];
            
            
            
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
#pragma mark -Navigation to Pages

-(void)GotoPage:(UIButton *) sender{
    
    if (sender.tag==1) {
        [self performSegueWithIdentifier: @"Calender-Dashboard" sender: self];
        
    }
    else if(sender.tag==2){
        
        //[[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(orientationChanged:)    name:UIDeviceOrientationDidChangeNotification  object:nil];
        //[[UIDevice currentDevice] setValue:[NSNumber numberWithInteger: UIInterfaceOrientationLandscapeRight]forKey:@"orientation"];
        
        [self performSegueWithIdentifier: @"Leads-Presentation" sender: self];
        [self.view setAlpha:0.4];
        [ProgressHUD show:@"Please wait..."];
        
        
        
    }
    else if(sender.tag==3){
        [self performSegueWithIdentifier: @"Leads-Training" sender: self];
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
        //[self performSegueWithIdentifier: @"Dashboard-Leads" sender: self];
    }
    else if(sender.tag==10){
        
        [self performSegueWithIdentifier: @"Leads-Presentation" sender: self];
        
    }
    else if(sender.tag==11){
        
        [self performSegueWithIdentifier: @"Leads-Presentation" sender: self];
        
    }
    else if(sender.tag==12){
        
        [self performSegueWithIdentifier: @"Leads-Presentation" sender: self];
        
    }
    else{
        NSLog(@"Something has gone wrong in the click menu at =  %@",sender);
        
    }
    
    
    
    
    
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [self.view setAlpha:0.4];
    [ProgressHUD show:@"Please wait..."];
    
    if([segue.identifier isEqualToString:@"Leads-LeadsDetails"]){
        UINavigationController *navController = (UINavigationController *)segue.destinationViewController;
        WGLeadsDetailsViewController *controller = (WGLeadsDetailsViewController *)navController.topViewController;
    }
    else if ([segue.identifier isEqualToString:@"Leads-Edit"])
    {
        UINavigationController *navController = (UINavigationController *)segue.destinationViewController;
        WGEditViewController *controller = (WGEditViewController *)navController.topViewController;
    }
    
    NSUserDefaults *PreviousPagePreference=[NSUserDefaults standardUserDefaults];
    [PreviousPagePreference setObject:@"Leads" forKey:@"PageName"];
    
    
    [PreviousPagePreference synchronize];
    
    
}
-(void)Insertion{
    
    [self performSegueWithIdentifier: @"Leads-Insert" sender: self];
    
}

-(void)GotoPresentation:(UIButton *) sender{
    NSUserDefaults *PreviousPagePreference=[NSUserDefaults standardUserDefaults];
    if (sender.tag==1) {            //for the slides
        NSLog(@"going to the slides");
        
        [PreviousPagePreference setObject:@"Slides" forKey:@"SubMeunName"];
        [self performSegueWithIdentifier: @"Leads-Presentation" sender: self];
        
    }
    else if(sender.tag==2) {            //for the videos
        NSLog(@"going to the videos");
        [PreviousPagePreference setObject:@"Videos" forKey:@"SubMeunName"];
        [self performSegueWithIdentifier: @"Leads-Presentation" sender: self];
    }
    else if(sender.tag==3) {            //for the websites
        NSLog(@"going to the websites");
        [PreviousPagePreference setObject:@"Websites" forKey:@"SubMeunName"];
        [self performSegueWithIdentifier: @"Leads-Presentation" sender: self];
        
    }
    [PreviousPagePreference synchronize];
    
}

-(void)itemsDownloaded:(NSArray *)items
{
    // This delegate method will get called when the items are finished downloading
    NSMutableArray *itemsArray=[[NSMutableArray alloc] init];
    
    // Set the downloaded items to the array
    for (int i=0; i<[items count]; i++) {
        Activity *sActivity=[items objectAtIndex:i];
        //if ([sActivity.AssigendTo isEqualToString:CurrentUser]) {
        [itemsArray addObject:sActivity];
        //}
        
        
    }
    
    _feedItems = [NSArray arrayWithArray:itemsArray];
    BackedUpArray=_feedItems;
    
    
    
    [self SetupCalender];
    // Reload the table view
    [calendar reload];
    [ProgressHUD show:@"Loading List..."];
    
    [SVProgressHUD dismiss];
    
}


@end
