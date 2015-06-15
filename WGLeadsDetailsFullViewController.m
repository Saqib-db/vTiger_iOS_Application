//
//  WGLeadsDetailsFullViewController.m
//  VirtualAgents-test
//
//  Created by saqib on 1/30/15.
//  Copyright (c) 2015 Muhammad Saqib Yaqeen. All rights reserved.
//

#import "WGLeadsDetailsFullViewController.h"
#import "WGLeadsDetailsViewController.h"
#import "WGEditViewController.h"
#import "ProgressHUD.h"




@interface WGLeadsDetailsFullViewController (){
    UIView *MoreDropDown;
    
    UIButton *DeleteBtn;
    UIButton *DuplicateBtn;

}

@end

@implementation WGLeadsDetailsFullViewController
@synthesize MenuBtn;
@synthesize PreviousPage;
@synthesize RecievedLead;


@synthesize FullNameLbl;
@synthesize DesignationLbl;
@synthesize FirstNameLbl;
@synthesize LastNameLbl;
@synthesize CompanyLbl;
@synthesize DesignationTableLbl;
@synthesize LeadSourceLbl;
@synthesize IndustryLbl;
@synthesize AnnualRevenueLbl;
@synthesize NoOfEmpLbl;
@synthesize SecEmlLbl;
@synthesize ModifiedTime;
@synthesize EmailOptOutLbl;
@synthesize TestFieldLbl;
@synthesize LeadNumberLbl;
@synthesize PrimaryPhoneLbl;
@synthesize MobilePhoneLbl;
@synthesize FaxLbl;
@synthesize PrimaryEmlLbl;
@synthesize WebsiteLbl;
@synthesize LeadSrcLbl;
@synthesize RAtingLbl;
@synthesize AssignedToLbl;
@synthesize CreatedTime;
@synthesize CreatedByLbl;


@synthesize EditBtn;
@synthesize SendEmailBtn;
@synthesize ConvertEmailBtn;
@synthesize MoreBtn;
@synthesize SettingBtn;
@synthesize DetailViewOuter;
@synthesize SecondColumnView;
@synthesize FirstColumnDynamic;
@synthesize FirstColumnView;
@synthesize SecondColumnDynamic;
@synthesize DetailHeader;

@synthesize MAinScrollView;


@synthesize StateLbl;
@synthesize CityLbl;
@synthesize PoBoxLbl;
@synthesize StreetLbl;
@synthesize PostalCodeLbl;
@synthesize CountryLbl;

@synthesize DescriptionLbl;

@synthesize DescriptionOuterView;
@synthesize AddressOuterView;

- (void)viewDidLoad {
    [super viewDidLoad];
    MAinScrollView.contentSize =CGSizeMake(1024 , 995);

    MoreDropDown=[WGGlobalFunctions GlobalMakeDropDownMenu];
    DeleteBtn=(UIButton*)[MoreDropDown viewWithTag:1];
    DuplicateBtn=(UIButton*)[MoreDropDown viewWithTag:2];
    [DeleteBtn addTarget:self action:@selector(deletePostRequest) forControlEvents:UIControlEventTouchUpInside];
    [DuplicateBtn addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    
    [MoreDropDown setAlpha:0.0];
    
    [self.view addSubview:MoreDropDown];
    
    
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [WGViewController colorFromHexString:GreyColor];
    self.navigationController.navigationBar.translucent = YES;
    // Do any additional setup after loading the view.
    [MenuBtn addTarget:self action:@selector(GoBack) forControlEvents:UIControlEventTouchUpInside];
    
    [FullNameLbl setText:[NSString stringWithFormat:@"%@ %@",RecievedLead.FirstName,RecievedLead.LastName]];
    [DesignationLbl setText:[NSString stringWithFormat:@"%@ at %@",RecievedLead.Designation,RecievedLead.Company]];
    [FirstNameLbl setText:RecievedLead.FirstName];
    [LastNameLbl setText:RecievedLead.LastName];
    [CompanyLbl setText:RecievedLead.Company];
    [DesignationTableLbl setText:RecievedLead.Designation];
    [LeadSourceLbl setText:RecievedLead.LeadSource];
    [IndustryLbl setText:RecievedLead.Industry];
    [AnnualRevenueLbl setText:RecievedLead.AnnualRevenue];
    [NoOfEmpLbl setText:RecievedLead.NoOfEmp];
    [SecEmlLbl setText:RecievedLead.SecEml];
    [ModifiedTime setText:RecievedLead.ModifiedOn];
    [EmailOptOutLbl setText:RecievedLead.EmlOptOut];
    [TestFieldLbl setText:RecievedLead.TestField];
    [LeadNumberLbl setText:RecievedLead.LeadNumber];
    [PrimaryPhoneLbl setText:RecievedLead.PrimaryPhone];
    [MobilePhoneLbl setText:RecievedLead.MobilePhone];
    [FaxLbl setText:RecievedLead.Fax];
    [PrimaryEmlLbl setText:RecievedLead.PrimaryEmail];
    [WebsiteLbl setText:RecievedLead.Website];
    [LeadSrcLbl setText:RecievedLead.LeadSource];
    [RAtingLbl setText:RecievedLead.Rating];
    [AssignedToLbl setText:RecievedLead.AssignedTo];
    [CreatedTime setText:RecievedLead.CreatedOn];
    //[CreatedByLbl setText:RecievedLead.CreatedBy];
    
    int CreatorId=[RecievedLead.CreatedBy intValue];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat: @"http://www.virtualdev.ca/clients/rep/UsersGet.php?UserID=%i",CreatorId]]];
    
    
    NSData *response = [NSURLConnection sendSynchronousRequest:request
                                             returningResponse:nil error:nil];
    
    
    NSString *NameInUSe=[[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    
    
    [CreatedByLbl setText:NameInUSe];
    //[CreatedByLbl setUserInteractionEnabled:NO];
    
    
    
    
    
    [StateLbl setText:RecievedLead.State];
    [CityLbl setText:RecievedLead.City];
    [PoBoxLbl setText:RecievedLead.PoBox];
    [StreetLbl setText:RecievedLead.street];
    [PostalCodeLbl setText:RecievedLead.PostalCode];
    [CountryLbl setText:RecievedLead.Country];
    
    [DescriptionLbl setText:RecievedLead.TextDescription];


    [self createBorders: EditBtn];
    [self createBorders: SendEmailBtn];
    [self createBorders: ConvertEmailBtn];
    [self createBorders: MoreBtn];
    [self createBorders: SettingBtn];
    [self createBorders: DetailViewOuter];
    //[self createBorders: SecondColumnView];
    //[self createBorders: FirstColumnDynamic];
//[self createBorders: FirstColumnView];
    //[self createBorders: SecondColumnDynamic];
    [self createBorders: DetailHeader];
    [self createBorders: DescriptionOuterView];
    [self createBorders: AddressOuterView];
    
    [MoreBtn setTag:1];
    [ConvertEmailBtn addTarget:self action:@selector(sendPostRequest) forControlEvents:UIControlEventTouchUpInside];
    [MoreBtn addTarget:self action:@selector(ShowDropDown:) forControlEvents:UIControlEventTouchUpInside];
    
    [EditBtn addTarget:self action:@selector(GotoPage:) forControlEvents:UIControlEventTouchUpInside];


}
-(void)GotoPage :(UIButton *)button{
    [self performSegueWithIdentifier: @"LeadsDetailsFull-Edit" sender: self];

    
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
    actionSheet.tag=2;
    
    [actionSheet showInView:self.view];
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
        if (buttonIndex == [actionSheet destructiveButtonIndex])
        {
            NSData *dummydata=[self postDataToUrlforDelete:@"http://virtualdev.ca/clients/rep/DeleteLead.php" :@"1" :RecievedLead.LeadId];
            NSLog(@"Response %@",dummydata);
            [actionSheet dismissWithClickedButtonIndex:0 animated:YES];

            [self performSegueWithIdentifier: @"LeadsDetailsFull-Leads" sender: self];

            
        }
        else if (buttonIndex == [actionSheet cancelButtonIndex])
        {
            
        }

    }

}
-(void)createBorders :(UIView *)view{
    
    [[view layer] setBorderWidth:1.0f];
    [[view layer] setBorderColor:[UIColor darkGrayColor].CGColor];
    
}

-(void)GoBack{
    NSString *SegueIdentifier=[NSString stringWithFormat:@"LeadsDetailsFull-LeadsDetails"];
    
    
    [self performSegueWithIdentifier: SegueIdentifier sender: self];
    
}
-(NSData *)postDataToUrlforDelete:(NSString*)urlString :(NSString*)DeleteValue :(NSString*)LeadId
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
    
    return responseData;
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
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [self.view setAlpha:0.4];
    [ProgressHUD show:@"Please wait..."];
    
    if([segue.identifier isEqualToString:@"LeadsDetailsFull-LeadsDetails"]){
        UINavigationController *navController = (UINavigationController *)segue.destinationViewController;
        WGLeadsDetailsViewController *controller = (WGLeadsDetailsViewController *)navController.topViewController;
        controller.RecievedLead =RecievedLead;
        NSUserDefaults *PreviousPagePreference=[NSUserDefaults standardUserDefaults];
        [PreviousPagePreference setObject:@"Leads" forKey:@"PageName"];
        
        
        [PreviousPagePreference synchronize];
    }
    else if([segue.identifier isEqualToString:@"LeadsDetailsFull-Edit"]){
        UINavigationController *navController = (UINavigationController *)segue.destinationViewController;
        WGEditViewController *controller = (WGEditViewController *)navController.topViewController;
        controller.RecievedLead =RecievedLead;
        NSUserDefaults *PreviousPagePreference=[NSUserDefaults standardUserDefaults];
        [PreviousPagePreference setObject:@"LeadsDetailsFull" forKey:@"PageName"];
    }
    else{
        NSUserDefaults *PreviousPagePreference=[NSUserDefaults standardUserDefaults];
        [PreviousPagePreference setObject:@"LeadsDetailsFull" forKey:@"PageName"];
        
        
        [PreviousPagePreference synchronize];
    }
    
    
    
    
    
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
