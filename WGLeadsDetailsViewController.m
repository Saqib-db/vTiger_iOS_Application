//
//  WGLeadsDetailsViewController.m
//  VirtualAgents-test
//
//  Created by saqib on 1/23/15.
//  Copyright (c) 2015 Muhammad Saqib Yaqeen. All rights reserved.
//

#import "WGLeadsDetailsViewController.h"
#import "Leads.h"
#import "WGLeadsDetailsFullViewController.h"
#import "WGEditViewController.h"
#import "ProgressHUD.h"
#import "CommentTableViewCell.h"
#import "Comments.h"


@interface WGLeadsDetailsViewController (){
    UIView *MoreDropDown;
    
    UIButton *DeleteBtn;
    UIButton *DuplicateBtn;
    NSArray *_feedItems;
    CommentsModel *_userModel;
    NSString *CommentIdAtInstance;
    
    
    
    
}

@end

@implementation WGLeadsDetailsViewController
@synthesize MenuBtn;
@synthesize PreviousPage;
@synthesize DescriptionViewOuter;

@synthesize FullNameTxt;
@synthesize Fullname;
@synthesize DesignationTxt;
@synthesize Designation;


@synthesize FirstNameLbl;
@synthesize LastNameLbl;
@synthesize PrimaryPhoneLbl;
@synthesize CompanyLbl;
@synthesize LeadSrcLbl;
@synthesize PrimayEmailSrcLbl;
@synthesize WebsiteLbl;
@synthesize AssignedToLbl;
@synthesize CityLbl;
@synthesize CountryLbl;
@synthesize CreatedOnLbl;
@synthesize ModifiedOnLbl;

@synthesize RecievedLead;
@synthesize ScrollView;
@synthesize CommentViewOuter;
@synthesize NoCommentView;
@synthesize DetailOuterView;
@synthesize ShowFullBtn;
@synthesize EditBtn;
@synthesize SendEmailBtn;
@synthesize ConvertLeadBtn;
@synthesize MoreBtn;
@synthesize SettingBtn;
@synthesize FirstColumnView;
@synthesize FirstColumnDynamicView;
@synthesize SecondColumnDynamicView;
@synthesize SecontColumnView;
@synthesize CommentTF;
@synthesize CommentView;
@synthesize PostBtn;

@synthesize CommentsTable;


- (void)viewDidLoad {
    [super viewDidLoad];
    ScrollView.contentSize =CGSizeMake(955 , 1053);
    MoreDropDown=[WGGlobalFunctions GlobalMakeDropDownMenu];
    DeleteBtn=(UIButton*)[MoreDropDown viewWithTag:1];
    DuplicateBtn=(UIButton*)[MoreDropDown viewWithTag:2];
    [DeleteBtn addTarget:self action:@selector(deletePostRequest) forControlEvents:UIControlEventTouchUpInside];
    [DuplicateBtn addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    
    PostBtn.tag=101;
    [PostBtn addTarget:self action:@selector(InsertCommentChild:) forControlEvents:UIControlEventTouchUpInside];


    [MoreDropDown setAlpha:0.0];
    
    [self.view addSubview:MoreDropDown];
    
    [FullNameTxt setText:[NSString stringWithFormat:@"%@ %@",RecievedLead.FirstName,RecievedLead.LastName]];
    [DesignationTxt setText:[NSString stringWithFormat:@"%@ at %@",RecievedLead.Designation,RecievedLead.Company] ];
    
    [FirstNameLbl setText:RecievedLead.FirstName];
    [LastNameLbl setText:RecievedLead.LastName];
    [PrimaryPhoneLbl setText:RecievedLead.PrimaryPhone];
    [CompanyLbl setText:RecievedLead.Company];
    [LeadSrcLbl setText:RecievedLead.LeadSource];
    [PrimayEmailSrcLbl setText:RecievedLead.PrimaryEmail];
    [WebsiteLbl setText:RecievedLead.Website];
    [AssignedToLbl setText:RecievedLead.AssignedTo];
    [CityLbl setText:RecievedLead.City];
    [CountryLbl setText:RecievedLead.Country];
    [CreatedOnLbl setText:RecievedLead.CreatedOn];
    [ModifiedOnLbl setText:RecievedLead.ModifiedOn];
    [ShowFullBtn setBackgroundColor:[WGViewController colorFromHexString:GreyColor]];
    [PostBtn setBackgroundColor:[WGViewController colorFromHexString:GreyColor]];

    
    NSUserDefaults *PreviousPagePreference=[NSUserDefaults standardUserDefaults];
    
    PreviousPage=[PreviousPagePreference objectForKey:@"PageName"];

    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [WGViewController colorFromHexString:GreyColor];
    self.navigationController.navigationBar.translucent = YES;
    [self createBorders:DescriptionViewOuter];
    
    [self createBorders:EditBtn];
    [self createBorders:SendEmailBtn];
    [self createBorders:ConvertLeadBtn];
    [self createBorders:MoreBtn];
    [self createBorders:SettingBtn];
    //[self createBorders:FirstColumnDynamicView];
   // [self createBorders:FirstColumnView];
    //[self createBorders:SecontColumnView];
    //[self createBorders:SecondColumnDynamicView];
    [self createBorders:PostBtn];

    
    //[self createShadows:CommentViewOuter];
    //[self createShadows:NoCommentView];
    [MoreBtn setTag:1];
    
    

    [MenuBtn addTarget:self action:@selector(GoBack) forControlEvents:UIControlEventTouchUpInside];
    [ShowFullBtn addTarget:self action:@selector(GotoFullDetail) forControlEvents:UIControlEventTouchUpInside];
    [ConvertLeadBtn addTarget:self action:@selector(sendPostRequest) forControlEvents:UIControlEventTouchUpInside];
    [MoreBtn addTarget:self action:@selector(ShowDropDown:) forControlEvents:UIControlEventTouchUpInside];
    
    [EditBtn addTarget:self action:@selector(GotoEdit) forControlEvents:UIControlEventTouchUpInside];
    
    
    CommentsTable.dataSource=self;
    CommentsTable.delegate=self;
    
    
    
    
    //[self myMethod];
    _feedItems = [[NSArray alloc] init];
    
    // Create new HomeModel object and assign it to _homeModel variable
    _userModel = [[CommentsModel alloc] init];
    
    // Set this view controller object as the delegate for the home model object
    _userModel.delegate = self;
    
    // Call the download items method of the home model object
    [_userModel downloadItems:RecievedLead.LeadId];
    
    

//deletePostRequest
    // Do any additional setup after loading the view.
}
-(void)sendPostRequest{
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Doyou want to Convert the current Lead?"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:@"YES"
                                                    otherButtonTitles:@"NO",nil];
    actionSheet.tag=1;
    
    [actionSheet showInView:self.view];
}
-(void)deletePostRequest{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Are You sure about Deleting the current Lead?"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:@"YES"
                                                    otherButtonTitles:@"NO",nil];
    actionSheet.tag=3;
    
    [actionSheet showInView:self.view];
    
    [actionSheet showFromRect:MoreBtn.frame inView:self.view animated:YES];
}
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag==1) {
        if (buttonIndex == [actionSheet destructiveButtonIndex])
        {
            NSData *dummydata=[self postDataToUrl:@"http://virtualdev.ca/clients/rep/ConvertLead.php" :@"1" :RecievedLead.LeadId];
            NSLog(@"Response %@",dummydata);
            
        }
        else if (buttonIndex == [actionSheet cancelButtonIndex])
        {
            
        }
    }
    else if (actionSheet.tag==2){
        
        
        
        
    }
    else if (actionSheet.tag==3){
        if (buttonIndex == [actionSheet destructiveButtonIndex])
        {
            NSString *dummydata=[self postDataToUrlforDelete:@"http://virtualdev.ca/clients/rep/DeleteLead.php" :@"1" :RecievedLead.LeadId];
            NSLog(@"Response %@",dummydata);
            
            [self ShowAfterDeletionMessgae:dummydata];

            
            
            

            
        }
        else if (buttonIndex == [actionSheet cancelButtonIndex])
        {

        }
        
            
    }
    else if (actionSheet.tag==101){
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 101){
        [self performSegueWithIdentifier: @"LeadsDetails-Leads" sender: self];
    }
    else if(alertView.tag == 10){
        
        if (buttonIndex==0) {
            NSLog(@"Posting Cancelled");
            
        }
        else if(buttonIndex==1){
            NSLog(@"New Edited Comment is %@",[alertView textFieldAtIndex:1].text);
            
            
            
            NSString *ResultGot=[self postDataToEditComment:@"http://virtualdev.ca/clients/rep/updat_comment.php" :[alertView textFieldAtIndex:1].text :[alertView textFieldAtIndex:0].text :CommentIdAtInstance];
            if ([ResultGot isEqualToString:@"YES"]) {
                //[self performSegueWithIdentifier: @"Edit-Leads" sender: self];
                [_userModel downloadItems:RecievedLead.LeadId];
                [CommentsTable reloadData];

            
            

        
            }
        }
    }
    else if(alertView.tag == 11){
        
        if (buttonIndex==0) {
            NSLog(@"Posting Cancelled");
            
        }
        else if(buttonIndex==1){
            NSLog(@"New Comment is %@",[alertView textFieldAtIndex:0].text);
            
            NSString *ResultGot=[self postDataToInsertComment:@"http://virtualdev.ca/clients/rep/coment_insertion.php" :[alertView textFieldAtIndex:0].text];
            if ([ResultGot isEqualToString:@"YES"]) {
                //[self performSegueWithIdentifier: @"Edit-Leads" sender: self];
                [_userModel downloadItems:RecievedLead.LeadId];
                [CommentsTable reloadData];

                
            }
            else{
                NSLog(@"Something has gone terribly wrong here...");
                //[self performSegueWithIdentifier: @"Edit-Leads" sender: self];
            }
        }
    }
}
-(NSString *)postDataToInsertComment:(NSString*)urlString :(NSString *)CommentText{
    NSUserDefaults *Preference=[NSUserDefaults standardUserDefaults];
    
    NSString *UserId=[Preference objectForKey:@"CurrentUserId"];
    
    NSData* responseData = nil;
    NSURL *url=[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    responseData = [NSMutableData data] ;
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    NSString *bodydata=[NSString stringWithFormat:@"user_id=%@&comment=%@&lead_number=%@&parent_comments=%@&customer=%@&reasontoedit=%@",UserId ,CommentText,RecievedLead.LeadId,@"",@"",@""];
    
    [request setHTTPMethod:@"POST"];
    
    NSData *req=[NSData dataWithBytes:[bodydata UTF8String] length:[bodydata length]];
    [request setHTTPBody:req];
    NSLog(@"request data is %@",req);
    
    NSURLResponse* response;
    NSError* error = nil;
    responseData = [NSURLConnection sendSynchronousRequest:request     returningResponse:&response error:&error];
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    NSLog(@"Edit response is %@",responseString);

    
    
    
    return @"YES";
}

-(NSString *)postDataToEditComment:(NSString*)urlString :(NSString *)CommentText :(NSString *)EditReason :(NSString *)ComentId{
    NSUserDefaults *Preference=[NSUserDefaults standardUserDefaults];
    
    NSString *UserId=[Preference objectForKey:@"CurrentUserId"];
    
    NSData* responseData = nil;
    NSURL *url=[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    responseData = [NSMutableData data] ;
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    NSString *bodydata=[NSString stringWithFormat:@"comment_id=%@&user_id=%@&comment=%@&reason_edit=%@",ComentId, UserId , CommentText, EditReason];
    
    [request setHTTPMethod:@"POST"];
    
    NSData *req=[NSData dataWithBytes:[bodydata UTF8String] length:[bodydata length]];
    [request setHTTPBody:req];
    NSLog(@"request data is %@",req);
    
    NSURLResponse* response;
    NSError* error = nil;
    responseData = [NSURLConnection sendSynchronousRequest:request     returningResponse:&response error:&error];
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    NSLog(@"Edit response is %@",responseString);
    
    
    
    
    return @"YES";
}

-(void)ShowAfterDeletionMessgae:(NSString*)msg{
    UIAlertView *actionSheetdeleted = [[UIAlertView alloc]initWithTitle:@"Response" message:[NSString stringWithFormat:@"%@",msg] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];    actionSheetdeleted.tag=101;
    
    [actionSheetdeleted show];
}


-(void)ShowDropDown :(UIButton *)button{
    if (button.tag==1) {
        if (MoreDropDown.alpha==0) {
            [MoreDropDown setAlpha:1.0];

        }
        else{
            [MoreDropDown setAlpha:0.0];

        }
    }
}



-(NSString *)postDataToUrlforDelete:(NSString*)urlString :(NSString*)DeleteValue :(NSString*)LeadId
{
    NSData* responseData = nil;
    NSURL *url=[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    responseData = [NSMutableData data] ;
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    NSString *bodydata=[NSString stringWithFormat:@"data=%@&crmid=%@",DeleteValue,LeadId];
    
    [request setHTTPMethod:@"POST"];
    
    NSData *req=[NSData dataWithBytes:[bodydata UTF8String] length:[bodydata length]];
    [request setHTTPBody:req];
    NSLog(@"request data is %@",req);
    
    NSURLResponse* response;
    NSError* error = nil;
    responseData = [NSURLConnection sendSynchronousRequest:request     returningResponse:&response error:&error];
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    NSLog(@"the final output is:%@",responseString);
    
    return responseString;
}
-(NSData *)postDataToUrl:(NSString*)urlString :(NSString*)ConvertValue :(NSString*)LeadId
{
    NSData* responseData = nil;
    NSURL *url=[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    responseData = [NSMutableData data] ;
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    NSString *bodydata=[NSString stringWithFormat:@"data=%@&leadid=%@",ConvertValue,LeadId];
    
    [request setHTTPMethod:@"POST"];
    
    NSData *req=[NSData dataWithBytes:[bodydata UTF8String] length:[bodydata length]];
    [request setHTTPBody:req];
    NSLog(@"request data is %@",req);
    
    NSURLResponse* response;
    NSError* error = nil;
    responseData = [NSURLConnection sendSynchronousRequest:request     returningResponse:&response error:&error];
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    NSLog(@"the final output is:%@",responseString);
    
    return responseData;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)GoBack{
    NSString *previosController=self.PreviousPage;
    NSString *SegueIdentifier=[NSString stringWithFormat:@"LeadsDetails-%@",previosController];
    
    
    [self performSegueWithIdentifier: SegueIdentifier sender: self];
    
}
-(void)GotoFullDetail{
    [self performSegueWithIdentifier: @"LeadsDetails-LeadsDetailsFull" sender: self];
}
-(void)GotoEdit{
    [self performSegueWithIdentifier: @"LeadsDetails-Edit" sender: self];
}




-(void)createShadows :(UIView *)view{
    CALayer *layerCommentViewOuter = view.layer;
    layerCommentViewOuter.shadowOffset = CGSizeMake(1, 1);
    layerCommentViewOuter.shadowColor = [[UIColor blackColor] CGColor];
    layerCommentViewOuter.shadowRadius = 3.0f;
    layerCommentViewOuter.shadowOpacity = 0.50f;
    layerCommentViewOuter.shadowPath = [[UIBezierPath bezierPathWithRect:layerCommentViewOuter.bounds] CGPath];
}
-(void)createBorders :(UIView *)view{

    [[view layer] setBorderWidth:1.0f];
    [[view layer] setBorderColor:[UIColor darkGrayColor].CGColor];
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [self.view setAlpha:0.4];
    [ProgressHUD show:@"Please wait..."];
    
    if([segue.identifier isEqualToString:@"LeadsDetails-LeadsDetailsFull"]){
        UINavigationController *navController = (UINavigationController *)segue.destinationViewController;
        WGLeadsDetailsViewController *controller = (WGLeadsDetailsViewController *)navController.topViewController;
        controller.RecievedLead =RecievedLead;
    }
    else if([segue.identifier isEqualToString:@"LeadsDetails-Edit"]){
        UINavigationController *navController = (UINavigationController *)segue.destinationViewController;
        WGEditViewController *controller = (WGEditViewController *)navController.topViewController;
        controller.RecievedLead =RecievedLead;
    }
    
    
    NSUserDefaults *PreviousPagePreference=[NSUserDefaults standardUserDefaults];
    [PreviousPagePreference setObject:@"LeadsDetails" forKey:@"PageName"];
    
    
    [PreviousPagePreference synchronize];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_feedItems count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *simpleTableIdentifier = @"CommentTableViewCell";
    
    CommentTableViewCell *cell = (CommentTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CommentTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    Comments *singleComment=[_feedItems objectAtIndex:indexPath.row];
    
    
    
    NSString *daysago=[self humanDates:singleComment.CreatedTime];
    NSString *Modifieddaysago=[self humanDates:singleComment.ModifiedTime];
    if ([daysago isEqualToString:Modifieddaysago]) {
        Modifieddaysago=nil;
    }
    else{
        Modifieddaysago=[NSString stringWithFormat:@"Modified %@",Modifieddaysago];
    }
    
    
    [cell.FullNameTxt setText:[NSString stringWithFormat:@"%@ %@",singleComment.CommentorFirstName,singleComment.CommentorLastName]];
    [cell.CommentContentTxt setText:singleComment.CommentContent];
    [cell.DaysAgoTxt setText:daysago];
    [cell.ModifiedReasonTxt setText:singleComment.ReasonToEdit];
    [cell.ModifiedDaysAgoTxt setText:Modifieddaysago];
    cell.ReplyBtn.tag=indexPath.row;
    cell.EditBtn.tag=indexPath.row;
    [cell.EditBtn addTarget:self action:@selector(EditSave:) forControlEvents:UIControlEventTouchUpInside];
    [cell.ReplyBtn addTarget:self action:@selector(InsertCommentChild:) forControlEvents:UIControlEventTouchUpInside];

    
    
    
        return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 80;
    
}
-(void)itemsDownloaded:(NSArray *)items
{
    // This delegate method will get called when the items are finished downloading
    
    // Set the downloaded items to the array
    _feedItems = items;
    
    [CommentsTable reloadData];
    
    
    
    // Reload the table view
}
-(void)InsertCommentChild :(UIButton *)btn{
    if (btn.tag==101) {
        NSString *ResultGot=[self postDataToInsertComment:@"http://virtualdev.ca/clients/rep/coment_insertion.php" :CommentTF.text];
        if ([ResultGot isEqualToString:@"YES"]) {
            //[self performSegueWithIdentifier: @"Edit-Leads" sender: self];
            [_userModel downloadItems:RecievedLead.LeadId];
            [CommentsTable reloadData];
            NSIndexPath *IP=[NSIndexPath indexPathForItem:[_feedItems count]-1 inSection:0];
            if ([CommentsTable numberOfRowsInSection:0]>0) {
                [CommentsTable scrollToRowAtIndexPath:IP atScrollPosition:0 animated:YES];
            }
            
            
            
            
        }
        else{
            NSLog(@"Something has gone terribly wrong here...");
            //[self performSegueWithIdentifier: @"Edit-Leads" sender: self];
        }
    }
    else{
        Comments *sC=[_feedItems objectAtIndex:btn.tag];
        NSLog(@"Row is %@",sC.CommentContent);
        
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Post the Comment"
                                                          message:nil
                                                         delegate:self
                                                cancelButtonTitle:@"Cancel"
                                                otherButtonTitles:@"Post", nil];
        message.tag=11;
        
        
        [message setAlertViewStyle:UIAlertViewStylePlainTextInput];
        [message textFieldAtIndex:0].placeholder=@"Add your comment here...";
        
        [message show];
    }
    
    
    

    
}
-(void)EditSave :(UIButton *)btn{
    Comments *sC=[_feedItems objectAtIndex:btn.tag];
    NSLog(@"Row is %@",sC.CommentContent);
    CommentIdAtInstance=sC.ModCommentID;
    
    
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Editting the Comment"
                                                      message:nil
                                                     delegate:self
                                            cancelButtonTitle:@"Cancel"
                                            otherButtonTitles:@"Post", nil];
    message.tag=10;
    
    
    [message setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
    [message textFieldAtIndex:0].placeholder=@"Reason for changing the comment";
    [message textFieldAtIndex:1].text=sC.CommentContent;
    [message textFieldAtIndex:1].secureTextEntry=NO;
    
    [message show];

    
}

-(NSString *)humanDates:(NSString *)origDateInEpochTime
{
    if([origDateInEpochTime length]<= 0)
        return @"never";
    
    
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-d HH:mm:ss "];
    NSDate *date = [dateFormat dateFromString:origDateInEpochTime];
    
    
    
    NSDate *convertedDate = [NSDate dateWithTimeIntervalSince1970:[date timeIntervalSince1970]];
    NSDate *todayDate     = [NSDate date];
    double ti             = [convertedDate timeIntervalSinceDate:todayDate];
    ti = ti * -1;
    if(ti < 1)
    {
        return @"never";
    }
    else if(ti < 60)
    {
        return @"less than a minute ago";
    }
    else if(ti < 3600)
    {
        int diff = round(ti/60);
        if(diff == 1)
            return [NSString stringWithFormat:@"%d minute ago", diff];
        else
            return [NSString stringWithFormat:@"%d minutes ago", diff];
    }
    else if(ti < 86400)
    {
        int diff = round(ti/60/60);
        if(diff == 1)
            return [NSString stringWithFormat:@"%d hour ago", diff];
        else
            return [NSString stringWithFormat:@"%d hours ago", diff];
    }
    else if(ti < 2629743)
    {
        int diff = round(ti/60/60/24);
        if(diff == 1)
            return [NSString stringWithFormat:@"%d day ago", diff];
        else
            return [NSString stringWithFormat:@"%d days ago", diff];
    }
    else if(ti < 31104000)
    {
        int diff = round(ti/60/60/24/30);
        if(diff == 1)
            return [NSString stringWithFormat:@"%d month ago", diff];
        else
            return [NSString stringWithFormat:@"%d months ago", diff];
    }
    else if(ti < 311040000)
    {
        int diff = round(ti/60/60/24/30/12);
        if(diff == 1)
            return [NSString stringWithFormat:@"%d year ago", diff];
        else
            return [NSString stringWithFormat:@"%d years ago", diff];
    }
    else
    {
        int diff = round(ti/60/60/24/30/12/10);
        if(diff == 1)
            return [NSString stringWithFormat:@"%d decade ago", diff];
        else
            return [NSString stringWithFormat:@"%d decades ago", diff];
    }
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
