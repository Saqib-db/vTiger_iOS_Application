//
//  WGActivitiesViewController.m
//  VirtualAgents-test
//
//  Created by saqib on 3/5/15.
//  Copyright (c) 2015 Muhammad Saqib Yaqeen. All rights reserved.
//

#import "WGActivitiesViewController.h"
#import "WGPresentationViewController.h"
#import "ProgressHUD.h"
#import "LeadsTableViewCell.h"
#import "WGPresentationViewController.h"
#import "Activity.h"
#import "M13Checkbox.h"
#import "ProgressHUD.h"
#import "WGLeadsDetailsViewController.h"
#import "WGEditViewController.h"
#import "SVProgressHUD.h"

@interface WGActivitiesViewController (){
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
    NSArray *_feedItems;
    
    Leads  *SelectedLead;
    UITextField *FirstNameInp;
    UITextField *LastNameInp;
    UITextField *CompanyInp;
    UITextField *AssignedtoInp;
    
    NSArray *BackedUpArray;
    NSMutableData *receivedData;
    NSString* UserAssigned;
    Leads *SingledLead;
    
    NSString *CurrentUser;
    ActivityModel *_ActivityModel;

}

@end

@implementation WGActivitiesViewController
@synthesize ActionBtn;
@synthesize MenuBtn;
@synthesize ActivitiesTable;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ActivitiesTable.dataSource=self;
    ActivitiesTable.delegate=self;
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [WGViewController colorFromHexString:GreyColor];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.title=@"Activities";
    
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_feedItems count]+2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier;
    
    LeadsTableViewCell *cell;
    
    M13Checkbox *allDefaults = [[M13Checkbox alloc] init];
    
    if (indexPath.row==0) {
        simpleTableIdentifier = @"LeadsTableViewCell";
        
        cell = (LeadsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LeadsTableCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            //cell.accessoryType = UITableViewCellAccessoryDetailButton;
            
        }
        
        
        
        UIFont* boldFont = [UIFont fontWithName:@"Arial-MT" size:20];
        
        
        cell.FirstNameTxt.text=@"Status";
        cell.LastNameTxt.text=@"Activity Type";
        cell.CompanyText.text=@"Subject";
        //cell.PrimaryPhoneText.text=@"Primary Phone";
        //cell.Website.text=@"Website";
        //cell.PrimaryEmailTxt.text=@"Primary Email";
        cell.AssignedToText.text=@"Assigned To";
        cell.backgroundColor=[WGViewController colorFromHexString:BlueColor];
        [cell.DeleteBtn removeFromSuperview];
        
        
        
        [cell.EditBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        
        
        [cell.EditBtn setBackgroundImage:[UIImage imageNamed:@"btnAdd"] forState:UIControlStateNormal];
        [cell.EditBtn addTarget:self action:@selector(Insertion) forControlEvents:UIControlEventTouchUpInside];
        //[cell.EditBtn removeFromSuperview];
        [cell.MarkBtn removeFromSuperview];
        
        
        
        
        
        
        [cell.CompleteDetailBtn removeFromSuperview];
        
        
        [cell.FirstNameTxt setFont:boldFont];
        [cell.LastNameTxt setFont:boldFont];
        [cell.CompanyText setFont:boldFont];
        [cell.AssignedToText setFont:boldFont];
        
        [cell.FirstNameTxt setTextColor:[UIColor whiteColor]];
        [cell.LastNameTxt setTextColor:[UIColor whiteColor]];
        [cell.CompanyText setTextColor:[UIColor whiteColor]];
        [cell.AssignedToText setTextColor:[UIColor whiteColor]];
        
        //Custom tint color
        M13Checkbox *stroke = [[M13Checkbox alloc] initWithFrame:CGRectMake(20, 10, allDefaults.frame.size.width, allDefaults.frame.size.height) title:nil checkHeight:30.0];
        stroke.strokeColor = [UIColor grayColor];
        stroke.tintColor=[UIColor whiteColor];
        stroke.uncheckedColor=[UIColor whiteColor];
        stroke.strokeWidth = 3.0;
        stroke.radius=0.0f;
        
        int tagvalue=indexPath.row;
        
        stroke.tag=tagvalue+1;
        [stroke addTarget:self action:@selector(selesctAllClicked) forControlEvents:UIControlEventTouchUpInside];
        
        [stroke autoFitWidthToText];
        [cell addSubview:stroke];
        
    }
    else if (indexPath.row==1) {
        simpleTableIdentifier = @"LeadsTableSearchCell";
        
        cell = (LeadsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LeadsTableSearchCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.FirstNameTF.layer.cornerRadius=-10.0f;
        cell.FirstNameTF.clipsToBounds = YES;
        
        
        FirstNameInp=cell.FirstNameTF;
        LastNameInp=cell.LastNameTF;
        CompanyInp=cell.CompanyTF;
        AssignedtoInp=cell.AssignedtoTF;
        
        [[cell.SearchBtn layer] setBorderWidth:2.0f];
        [[cell.SearchBtn layer] setBorderColor:[UIColor lightGrayColor].CGColor];
        
        [cell.FirstNameTF setTag:101];
        [cell.FirstNameTF addTarget:self action:@selector(searchItem:)forControlEvents:UIControlEventEditingChanged];
        [cell.SearchBtn addTarget:self action:@selector(ShowSearchResults) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    else{
        simpleTableIdentifier = @"LeadsTableViewCell";
        
        cell = (LeadsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LeadsTableCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            //cell.accessoryType = UITableViewCellAccessoryDetailButton;
            
        }
        Activity *singleActivity=nil;
        
        if ([_feedItems count]>=1) {
            int crntIndex=indexPath.row;
            singleActivity=_feedItems[crntIndex-2];
            
        }
        
        
        
        
        
        
        
        if (indexPath.row==0) {
            
            
            
        }
        else if(indexPath.row==1){
            
        }
        else{
            cell.FirstNameTxt.text=singleActivity.Status;
            cell.LastNameTxt.text=singleActivity.ActivityType;
            cell.CompanyText.text=singleActivity.Subject;
            //cell.PrimaryPhoneText.text=@"123-4567-7891";
            //cell.Website.text=@"www.abc.com";
            //cell.PrimaryEmailTxt.text=@"Lorem@abc.com";
            cell.AssignedToText.text=singleActivity.AssigendTo;
            
            
            allDefaults.frame = CGRectMake(25, 7, allDefaults.frame.size.width, allDefaults.frame.size.height);
            allDefaults.strokeColor = [UIColor grayColor];
            //[allDefaults addTarget:self action:@selector(nilSymbol) forControlEvents:UIControlEventValueChanged];
            allDefaults.uncheckedColor=[UIColor whiteColor];
            allDefaults.tintColor=[UIColor whiteColor];
            
            allDefaults.radius=0.0f;
            int tagvalue=indexPath.row;
            allDefaults.tag=tagvalue+1;
            [cell addSubview:allDefaults];
            
            
            [cell.CompleteDetailBtn setTag:tagvalue+10];
            [cell.EditBtn setTag:tagvalue+10];
            [cell.DeleteBtn setTag:tagvalue+10];
            
            
            [cell.CompleteDetailBtn addTarget:self action:@selector(ShowComplete:) forControlEvents:UIControlEventTouchUpInside];
            [cell.EditBtn addTarget:self action:@selector(Edit:) forControlEvents:UIControlEventTouchUpInside];
            [cell.DeleteBtn addTarget:self action:@selector(DeleteItem:) forControlEvents:UIControlEventTouchUpInside];
            
            
        }
        
        
        if([indexPath row] == ((NSIndexPath*)[[tableView indexPathsForVisibleRows] lastObject]).row){
            
        }
        
        
    }
    
    
    
    //cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    
    
    
    
    
    
    //cell.textLabel.text = @"saqib";
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 46;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    int sect=indexPath.section;
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==0) {
        
        /*M13Checkbox *stroke =(M13Checkbox*)[tableView viewWithTag:indexPath.row+1];
         if ([stroke isSelected]) {
         stroke.checkState=M13CheckboxStateUnchecked;
         stroke.selected=NO;
         
         for (int i=2; i<=[_feedItems count]+2; i++) {
         
         
         M13Checkbox *CheckBox=(M13Checkbox*)[tableView viewWithTag:i];
         CheckBox.selected=NO;
         CheckBox.checkState=M13CheckboxStateUnchecked;
         
         }
         }
         else{
         stroke.checkState=M13CheckboxStateChecked;
         stroke.selected=YES;
         
         for (int i=2; i<=[_feedItems count]+2; i++) {
         
         
         M13Checkbox *CheckBox=(M13Checkbox*)[tableView viewWithTag:i];
         CheckBox.selected=YES;
         CheckBox.checkState=M13CheckboxStateChecked;
         
         }
         
         
         
         }*/
        
        
    }
    else if (indexPath.row==1){
        
    }
    else{
        
        SelectedLead=_feedItems[indexPath.row-2];
        [self performSegueWithIdentifier: @"Leads-LeadsDetails" sender: self];
        /*
         M13Checkbox *CurrentCheckBox=(M13Checkbox*)[tableView viewWithTag:indexPath.row+1];
         
         M13Checkbox *SelectAllCeckBox=(M13Checkbox*)[tableView viewWithTag:1];
         if ([SelectAllCeckBox isSelected]) {
         SelectAllCeckBox.selected=NO;
         SelectAllCeckBox.checkState=M13CheckboxStateUnchecked;
         }
         
         if ([CurrentCheckBox isSelected]) {
         CurrentCheckBox.selected=NO;
         CurrentCheckBox.checkState=M13CheckboxStateUnchecked;
         }
         else{
         CurrentCheckBox.selected=YES;
         CurrentCheckBox.checkState=M13CheckboxStateChecked;
         }*/
    }
}


#pragma mark -
#pragma mark -Navigation to Pages

-(void)GotoPage:(UIButton *) sender{
    
    if (sender.tag==1) {
        [self performSegueWithIdentifier: @"Activities-Dashboard" sender: self];
        
    }
    else if(sender.tag==2){
        
        //[[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(orientationChanged:)    name:UIDeviceOrientationDidChangeNotification  object:nil];
        //[[UIDevice currentDevice] setValue:[NSNumber numberWithInteger: UIInterfaceOrientationLandscapeRight]forKey:@"orientation"];
        
        [self performSegueWithIdentifier: @"Activities-Presentation" sender: self];
        [self.view setAlpha:0.4];
        [ProgressHUD show:@"Please wait..."];
        
        
        
    }
    else if(sender.tag==3){
        [self performSegueWithIdentifier: @"Activities-Training" sender: self];
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
    else if(sender.tag==5){
        //[self performSegueWithIdentifier: @"Dashboard-Leads" sender: self];
    }
    else if(sender.tag==10){
        
        [self performSegueWithIdentifier: @"Activities-Presentation" sender: self];
        
    }
    else if(sender.tag==11){
        
        [self performSegueWithIdentifier: @"Activities-Presentation" sender: self];
        
    }
    else if(sender.tag==12){
        
        [self performSegueWithIdentifier: @"Activities-Presentation" sender: self];
        
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
        controller.RecievedLead =SelectedLead;
    }
    else if ([segue.identifier isEqualToString:@"Leads-Edit"])
    {
        UINavigationController *navController = (UINavigationController *)segue.destinationViewController;
        WGEditViewController *controller = (WGEditViewController *)navController.topViewController;
        controller.RecievedLead =SelectedLead;
    }
    
    NSUserDefaults *PreviousPagePreference=[NSUserDefaults standardUserDefaults];
    [PreviousPagePreference setObject:@"Activities" forKey:@"PageName"];
    
    
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
        [self performSegueWithIdentifier: @"Activities-Presentation" sender: self];
        
    }
    else if(sender.tag==2) {            //for the videos
        NSLog(@"going to the videos");
        [PreviousPagePreference setObject:@"Videos" forKey:@"SubMeunName"];
        [self performSegueWithIdentifier: @"Activities-Presentation" sender: self];
    }
    else if(sender.tag==3) {            //for the websites
        NSLog(@"going to the websites");
        [PreviousPagePreference setObject:@"Websites" forKey:@"SubMeunName"];
        [self performSegueWithIdentifier: @"Activities-Presentation" sender: self];
        
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
    
    
    
    
    // Reload the table view
    [ActivitiesTable reloadData];
    [ProgressHUD show:@"Loading List..."];
    
    [SVProgressHUD dismiss];
    
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
