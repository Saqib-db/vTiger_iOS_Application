//
//  WGEditViewController.m
//  VirtualAgents-test
//
//  Created by saqib on 2/5/15.
//  Copyright (c) 2015 Muhammad Saqib Yaqeen. All rights reserved.
//

#import "WGEditViewController.h"
#import "WGLeadsDetailsViewController.h"
#import "WGLeadsDetailsFullViewController.h"
#import "ProgressHUD.h"
#import "NIDropDown.h"
#import "QuartzCore/QuartzCore.h"
#import "Users.h"


#import "ActionSheetLocalePicker.h"

@interface WGEditViewController ()

@end

@implementation WGEditViewController{
    NSArray* animals ;
    NSInteger selectedIndex;
    UserModel *_userModel;
    NSArray *_feedItems;
    NSArray* LeadSources ;
    NSArray* LeadStatus ;
    NSArray* Industries ;
    NSArray* Ratings ;

    
}

@synthesize Btn;


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
@synthesize SaveBtn;
@synthesize CancelBtn;
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
@synthesize AssignedToBtn;
@synthesize LeadSourceBtn;

@synthesize LeadStatusBtn;
@synthesize IndustryBtn;
@synthesize RatingBtn;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    //[self myMethod];
    _feedItems = [[NSArray alloc] init];
    
    // Create new HomeModel object and assign it to _homeModel variable
    _userModel = [[UserModel alloc] init];
    
    // Set this view controller object as the delegate for the home model object
    _userModel.delegate = self;
    
    // Call the download items method of the home model object
    [_userModel downloadItems];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    
    animals = @[@"Aardvark", @"Beaver", @"Cheetah", @"Deer", @"Elephant", @"Frog", @"Gopher", @"Horse", @"Impala", @"...", @"Zebra"];
    LeadSources = @[@"Cold Call", @"Existing Customer", @"Self Generated", @"Employee", @"Partner", @"Public Relations", @"Direct Mail", @"Conference", @"Trade Show", @"Web Site", @"Word of Mouth", @"Other"];
    LeadStatus = @[@"Attempted to Contact", @"Cold", @"Contact in Future", @"Contacted", @"Hot", @"Junk Lead", @"Lost Lead", @"Not Contacted", @"Pre Qualified", @"Qualified", @"Warm"];
    Industries = @[@"Apparel", @"Banking", @"Biotechnology", @"Chemicals", @"Communications", @"Construction", @"Consulting", @"Education", @"Electronics", @"Energy", @"Engineering", @"Entertainment", @"Environmental", @"Finance", @"Food & Beverage", @"Government", @"Healthcare", @"Hospitality", @"Insurance", @"Machinery", @"Manufacturing", @"Media", @"Not For Profit", @"Recreation", @"Retail"];
    Ratings = @[@"Acquired", @"Active", @"Market Failed", @"Project Cancelled", @"Shutdown"];
    
    
    
    
    
    
    Btn.layer.borderWidth = 1;
    Btn.layer.borderColor = [[UIColor blackColor] CGColor];
    Btn.layer.cornerRadius = 5;
    Btn.titleLabel.textColor=[UIColor blackColor];
    [self.view bringSubviewToFront:Btn];
    
    
    MAinScrollView.contentSize =CGSizeMake(1024 , 995);
    
    /*MoreDropDown=[WGGlobalFunctions GlobalMakeDropDownMenu];
    DeleteBtn=(UIButton*)[MoreDropDown viewWithTag:1];
    DuplicateBtn=(UIButton*)[MoreDropDown viewWithTag:2];
    [DeleteBtn addTarget:self action:@selector(deletePostRequest) forControlEvents:UIControlEventTouchUpInside];
    [DuplicateBtn addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    
    [MoreDropDown setAlpha:0.0];
    
    [self.view addSubview:MoreDropDown];*/
    
    
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [WGViewController colorFromHexString:GreyColor];
    self.navigationController.navigationBar.translucent = YES;
    // Do any additional setup after loading the view.
    [MenuBtn addTarget:self action:@selector(GoBackto) forControlEvents:UIControlEventTouchUpInside];
    [CancelBtn addTarget:self action:@selector(GoBackto) forControlEvents:UIControlEventTouchUpInside];
    [SaveBtn addTarget:self action:@selector(SAveEdits) forControlEvents:UIControlEventTouchUpInside];

    
    [FullNameLbl setText:[NSString stringWithFormat:@"%@ %@",RecievedLead.FirstName,RecievedLead.LastName]];
    [DesignationLbl setText:[NSString stringWithFormat:@"%@ at %@",RecievedLead.Designation,RecievedLead.Company]];
    [FirstNameLbl setText:RecievedLead.FirstName];
    [LastNameLbl setText:RecievedLead.LastName];
    [CompanyLbl setText:RecievedLead.Company];
    [DesignationTableLbl setText:RecievedLead.Designation];
    [LeadSourceBtn setTitle:RecievedLead.LeadSource forState:UIControlStateNormal];
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
    [AssignedToBtn setTitle:RecievedLead.AssignedTo forState:UIControlStateNormal];
    [IndustryBtn setTitle:RecievedLead.Industry forState:UIControlStateNormal];
    [LeadSourceBtn setTitle:RecievedLead.LeadSource forState:UIControlStateNormal];
    [RatingBtn setTitle:RecievedLead.Rating forState:UIControlStateNormal];
    [LeadStatusBtn setTitle:RecievedLead.LeadStatus forState:UIControlStateNormal];

    
    [CreatedTime setText:RecievedLead.CreatedOn];
    
    int CreatorId=[RecievedLead.CreatedBy intValue];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat: @"http://www.virtualdev.ca/clients/rep/UsersGet.php?UserID=%i",CreatorId]]];
  
    
    NSData *response = [NSURLConnection sendSynchronousRequest:request
                                             returningResponse:nil error:nil];
    
    
    NSString *NameInUSe=[[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    
    
    [CreatedByLbl setText:NameInUSe];
    [CreatedByLbl setUserInteractionEnabled:NO];
    
    
    [StateLbl setText:RecievedLead.State];
    [CityLbl setText:RecievedLead.City];
    [PoBoxLbl setText:RecievedLead.PoBox];
    [StreetLbl setText:RecievedLead.street];
    [PostalCodeLbl setText:RecievedLead.PostalCode];
    [CountryLbl setText:RecievedLead.Country];
    
    [DescriptionLbl setText:RecievedLead.TextDescription];
    
    
    [self createBorders: EditBtn];
    [self createBorders: SaveBtn];
    [self createBorders: CancelBtn];
    [self createBorders: DetailViewOuter];
    //[self createBorders: SecondColumnView];
    //[self createBorders: FirstColumnDynamic];
    //[self createBorders: FirstColumnView];
    //[self createBorders: SecondColumnDynamic];
    [self createBorders: DetailHeader];
    [self createBorders: DescriptionOuterView];
    [self createBorders: AddressOuterView];
    [self createBorders: AssignedToBtn];
    [self createBorders: LeadSourceBtn];
    [self createBorders: LeadStatusBtn];
    [self createBorders: IndustryBtn];
    [self createBorders: RatingBtn];
    
    
    [LeadSourceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [IndustryBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [LeadStatusBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [AssignedToBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];    
    [RatingBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    NSUserDefaults *PreviousPagePreference=[NSUserDefaults standardUserDefaults];
    
    PreviousPage=[PreviousPagePreference objectForKey:@"PageName"];
    
    [LeadNumberLbl setUserInteractionEnabled:NO];
    [CreatedTime setUserInteractionEnabled:NO];
    [CreatedByLbl setUserInteractionEnabled:NO];
 
    
    
    // Do any additional setup after loading the view.
}
-(void)GoBackto{
    NSString *previosController=self.PreviousPage;
    NSString *SegueIdentifier=[NSString stringWithFormat:@"Edit-%@",previosController];
    
    
    [self performSegueWithIdentifier: SegueIdentifier sender: self];
    
}
-(void)createBorders :(UIView *)view{
    
    [[view layer] setBorderWidth:1.0f];
    [[view layer] setBorderColor:[UIColor darkGrayColor].CGColor];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [self.view setAlpha:0.4];
    [ProgressHUD show:@"Please wait..."];
    
    if([segue.identifier isEqualToString:@"Edit-LeadsDetails"]){
        UINavigationController *navController = (UINavigationController *)segue.destinationViewController;
        WGLeadsDetailsViewController *controller = (WGLeadsDetailsViewController *)navController.topViewController;
        controller.RecievedLead =RecievedLead;
        NSUserDefaults *PreviousPagePreference=[NSUserDefaults standardUserDefaults];
        [PreviousPagePreference setObject:@"Leads" forKey:@"PageName"];
        
        
        [PreviousPagePreference synchronize];
    }
    else if([segue.identifier isEqualToString:@"Edit-LeadsDetailsFull"]){
        UINavigationController *navController = (UINavigationController *)segue.destinationViewController;
        WGLeadsDetailsFullViewController *controller = (WGLeadsDetailsFullViewController *)navController.topViewController;
        controller.RecievedLead =RecievedLead;
        NSUserDefaults *PreviousPagePreference=[NSUserDefaults standardUserDefaults];
        [PreviousPagePreference setObject:@"Leads" forKey:@"PageName"];
        
        
        [PreviousPagePreference synchronize];
    }
    else{
        NSUserDefaults *PreviousPagePreference=[NSUserDefaults standardUserDefaults];
        [PreviousPagePreference setObject:@"LeadsDetailsFull" forKey:@"PageName"];
        
        
        [PreviousPagePreference synchronize];
    }
    
    
    
    
    
}
-(void)SAveEdits{
    
   NSString *ResultGot=[self postDataToUrlforEdit:@"http://virtualdev.ca/clients/rep/Edit.php"];
    if ([ResultGot isEqualToString:@"1"]) {
        [self performSegueWithIdentifier: @"Edit-Leads" sender: self];

    }
    else{
        NSLog(@"Something has gone terribly wrong here...");
        [self performSegueWithIdentifier: @"Edit-Leads" sender: self];
    }
}
-(NSString *)postDataToUrlforEdit:(NSString*)urlString
{
    
    
    NSString* FirstNamet = FirstNameLbl.text;
    NSString* LastName = LastNameLbl.text;
    NSString* Company = CompanyLbl.text;
    NSString* Designation = DesignationTableLbl.text;
    NSString* LeadSource = LeadSourceBtn.titleLabel.text;
    NSString* Industry = IndustryBtn.titleLabel.text;
    int AnnualRevenue = [AnnualRevenueLbl.text integerValue];
    int NoOfEmployees = [NoOfEmpLbl.text integerValue];
    NSString* SecondaryEmail = SecEmlLbl.text;
    NSString* EmailOptOut = EmailOptOutLbl.text;
    NSString* TestField = TestFieldLbl.text;
    NSString* PrimaryPhone = PrimaryPhoneLbl.text;
    NSString* MobilePhone = MobilePhoneLbl.text;
    NSString* Fax = FaxLbl.text;
    NSString* PrimaryEmail = PrimaryPhoneLbl.text;
    NSString* Website = WebsiteLbl.text;
    NSString* LeadStatustoSend = LeadStatusBtn.titleLabel.text;
    NSString* Rating = RatingBtn.titleLabel.text;
    NSString* AssignedTo = AssignedToBtn.titleLabel.text;
    
    Users *AssignedToUser;
    
    for (int i=0;i<[_feedItems count]; i++) {
        Users *singleUser=_feedItems[i];
        if ([AssignedTo isEqualToString:singleUser.LastName]) {
            AssignedToUser=singleUser;
        }
    }
    AssignedTo=AssignedToUser.userId;
    
    
    
    NSString* Street = StreetLbl.text;
    NSString* PoBox = PoBoxLbl.text;
    NSString* PostalCode = PostalCodeLbl.text;
    NSString* Country = CountryLbl.text;
    NSString* City =CityLbl.text;
    NSString* State = StateLbl.text;
    NSString* Description = DescriptionLbl.text;
    
    

    int CrmId = [RecievedLead.LeadId intValue];

    
    
    
    
    
    NSData* responseData = nil;
    NSURL *url=[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    responseData = [NSMutableData data] ;
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    NSString *bodydata=[NSString stringWithFormat:@"FirstName=%@&LastName=%@&Company=%@&Designation=%@&LeadSource=%@&Industry=%@&AnnualRevenue=%i&NoOfEmployees=%i&SecondaryEmail=%@&EmailOptOut=%@&TestField=%@&PrimaryPhone=%@&MobilePhone=%@&Fax=%@&PrimaryEmail=%@&Website=%@&LeadStatus=%@&Rating=%@&AssignedTo=%@&Street=%@&PoBox=%@&PostalCode=%@&Country=%@&City=%@&State=%@&Description=%@&CrmId=%i",FirstNamet,LastName,Company,Designation,LeadSource,Industry,AnnualRevenue,NoOfEmployees,SecondaryEmail,EmailOptOut,TestField,PrimaryPhone,MobilePhone,Fax,PrimaryEmail,Website,LeadStatustoSend,Rating,AssignedTo,Street,PoBox,PostalCode,Country,City,State,Description,CrmId];
    
    [request setHTTPMethod:@"POST"];
    
    NSData *req=[NSData dataWithBytes:[bodydata UTF8String] length:[bodydata length]];
    [request setHTTPBody:req];
    NSLog(@"request data is %@",req);
    
    NSURLResponse* response;
    NSError* error = nil;
    responseData = [NSURLConnection sendSynchronousRequest:request     returningResponse:&response error:&error];
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    NSLog(@"Edit response is %@",responseString);
    
    return responseString;
}

- (IBAction)selectClicked:(id)sender {
    [ActionSheetStringPicker showPickerWithTitle:@"Assign To" rows:animals initialSelection:selectedIndex target:self successAction:@selector(animalWasSelected:element:) cancelAction:@selector(actionPickerCancelled:) origin:sender];
}
- (IBAction)LeadSourceSelected:(id)sender {
     [ActionSheetStringPicker showPickerWithTitle:@"Lead Source" rows:LeadSources initialSelection:selectedIndex target:self successAction:@selector(LeadSourceWasSelected:element:) cancelAction:@selector(actionPickerCancelled:) origin:sender];
}

- (IBAction)LeadStatusSelected:(id)sender{
    [ActionSheetStringPicker showPickerWithTitle:@"Lead Status" rows:LeadStatus initialSelection:selectedIndex target:self successAction:@selector(LeadStatusWasSelected:element:) cancelAction:@selector(actionPickerCancelled:) origin:sender];
}
- (IBAction)IndustrySelected:(id)sender{
    [ActionSheetStringPicker showPickerWithTitle:@"Industry" rows:Industries initialSelection:selectedIndex target:self successAction:@selector(IndustryWasSelected:element:) cancelAction:@selector(actionPickerCancelled:) origin:sender];
}
- (IBAction)RatingSelected:(id)sender{
    [ActionSheetStringPicker showPickerWithTitle:@"Rating" rows:Ratings initialSelection:selectedIndex target:self successAction:@selector(RatingWasSelected:element:) cancelAction:@selector(actionPickerCancelled:) origin:sender];
}






- (void)LeadSourceWasSelected:(NSNumber *)SI element:(id)element {
    selectedIndex = [SI intValue];
    
    //may have originated from textField or barButtonItem, use an IBOutlet instead of element
    [LeadSourceBtn setTitle:(LeadSources)[(NSUInteger)selectedIndex] forState:UIControlStateNormal];
    
}
- (void)LeadStatusWasSelected:(NSNumber *)SI element:(id)element {
    selectedIndex = [SI intValue];
    
    //may have originated from textField or barButtonItem, use an IBOutlet instead of element
    [LeadStatusBtn setTitle:(LeadStatus)[(NSUInteger)selectedIndex] forState:UIControlStateNormal];
    
}
- (void)IndustryWasSelected:(NSNumber *)SI element:(id)element {
    selectedIndex = [SI intValue];
    
    //may have originated from textField or barButtonItem, use an IBOutlet instead of element
    [IndustryBtn setTitle:(Industries)[(NSUInteger)selectedIndex] forState:UIControlStateNormal];
    
}
- (void)RatingWasSelected:(NSNumber *)SI element:(id)element {
    selectedIndex = [SI intValue];
    
    //may have originated from textField or barButtonItem, use an IBOutlet instead of element
    [RatingBtn setTitle:(Ratings)[(NSUInteger)selectedIndex] forState:UIControlStateNormal];
    
}

- (void)animalWasSelected:(NSNumber *)SI element:(id)element {
    selectedIndex = [SI intValue];
    
    //may have originated from textField or barButtonItem, use an IBOutlet instead of element
    [AssignedToBtn setTitle:(animals)[(NSUInteger)selectedIndex] forState:UIControlStateNormal];
    
}
- (void)actionPickerCancelled:(id)sender {
    NSLog(@"Delegate has been informed that ActionSheetPicker was cancelled");
}

- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    [self rel];
}

-(void)rel{
    //    [dropDown release];
    dropDown = nil;
}
-(void)itemsDownloaded:(NSArray *)items
{
    // This delegate method will get called when the items are finished downloading
    
    // Set the downloaded items to the array
    _feedItems = items;
    NSMutableArray *LastNames=[[NSMutableArray alloc]init];
    
    for (int i=0; i<[_feedItems count]; i++) {
        Users *singleUser=_feedItems[i];
        
        
        
        [LastNames addObject:singleUser.LastName];
        
        
    }
    
    animals=nil;
    animals=[[NSArray alloc] initWithArray:LastNames];
   // [AssignedToBtn setTitle:[animals objectAtIndex:0] forState:UIControlStateNormal];
    
    
    // Reload the table view
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
