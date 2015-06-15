//
//  WGInsertViewController.m
//  VirtualAgents-test
//
//  Created by saqib on 2/9/15.
//  Copyright (c) 2015 Muhammad Saqib Yaqeen. All rights reserved.
//

#import "WGInsertViewController.h"
#import "ActionSheetLocalePicker.h"
#import "Users.h"


@interface WGInsertViewController (){
    NSArray* animals ;
    NSInteger selectedIndex;
    UserModel *_userModel;
    NSArray *_feedItems;
    NSArray* LeadSources ;
    NSArray* LeadStatus ;
    NSArray* Industries ;
    NSArray* Ratings ;
    
}

@end

@implementation WGInsertViewController
@synthesize MenuBtn;
@synthesize PreviousPage;


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
@synthesize AssigndToBtn;
@synthesize LeadSourceBtn;

@synthesize LeadStatusBtn;
@synthesize IndustryBtn;
@synthesize RatingBtn;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    MAinScrollView.contentSize =CGSizeMake(1024 , 900);
    
    /*MoreDropDown=[WGGlobalFunctions GlobalMakeDropDownMenu];
     DeleteBtn=(UIButton*)[MoreDropDown viewWithTag:1];
     DuplicateBtn=(UIButton*)[MoreDropDown viewWithTag:2];
     [DeleteBtn addTarget:self action:@selector(deletePostRequest) forControlEvents:UIControlEventTouchUpInside];
     [DuplicateBtn addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
     
     [MoreDropDown setAlpha:0.0];
     
     [self.view addSubview:MoreDropDown];*/
    
    
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
    [AssigndToBtn setTitle:[animals objectAtIndex:0] forState:UIControlStateNormal];
    [LeadSourceBtn setTitle:[LeadSources objectAtIndex:0] forState:UIControlStateNormal];
    [LeadStatusBtn setTitle:[LeadStatus objectAtIndex:0] forState:UIControlStateNormal];
    [IndustryBtn setTitle:[Industries objectAtIndex:0] forState:UIControlStateNormal];
    [RatingBtn setTitle:[Ratings objectAtIndex:0] forState:UIControlStateNormal];

    [AssigndToBtn addTarget:self action:@selector(ShowPicker:) forControlEvents:UIControlEventTouchUpInside];

    
    
    
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [WGViewController colorFromHexString:GreyColor];
    self.navigationController.navigationBar.translucent = YES;
    [MenuBtn addTarget:self action:@selector(GoBackto) forControlEvents:UIControlEventTouchUpInside];
    [CancelBtn addTarget:self action:@selector(GoBackto) forControlEvents:UIControlEventTouchUpInside];
    [SaveBtn addTarget:self action:@selector(InsertLead) forControlEvents:UIControlEventTouchUpInside];
    
    
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
    [self createBorders: AssigndToBtn];
    [self createBorders: LeadSourceBtn];
    [self createBorders: LeadStatusBtn];
    [self createBorders: IndustryBtn];
    [self createBorders: RatingBtn];
    
    NSUserDefaults *PreviousPagePreference=[NSUserDefaults standardUserDefaults];
    
    PreviousPage=[PreviousPagePreference objectForKey:@"PageName"];

    
    
}
-(void)ShowPicker:(id)sender {
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
    [AssigndToBtn setTitle:(animals)[(NSUInteger)selectedIndex] forState:UIControlStateNormal];
    
}
- (void)actionPickerCancelled:(id)sender {
    NSLog(@"Delegate has been informed that ActionSheetPicker was cancelled");
}


-(void)createBorders :(UIView *)view{
    
    [[view layer] setBorderWidth:1.0f];
    [[view layer] setBorderColor:[UIColor darkGrayColor].CGColor];
    
}
-(void)GoBackto{
    NSString *previosController=self.PreviousPage;
    NSString *SegueIdentifier=[NSString stringWithFormat:@"Insert-%@",previosController];
    
    
    [self performSegueWithIdentifier: SegueIdentifier sender: self];
    
}

-(void)InsertLead{
    
    NSString *ResultGot=[self postDataToUrlforInsert:@"http://virtualdev.ca/clients/rep/insert.php"];
    if ([ResultGot isEqualToString:@"1"]) {
        [self performSegueWithIdentifier: @"Insert-Leads" sender: self];
        
    }
    else{
        NSLog(@"Something has gone terribly wrong here...");
        [self performSegueWithIdentifier: @"Insert-Leads" sender: self];
    }
}



-(NSString *)postDataToUrlforInsert:(NSString*)urlString
{
    NSUserDefaults *Preference=[NSUserDefaults standardUserDefaults];
    
    NSString *UserId=[Preference objectForKey:@"CurrentUserId"];
    
    NSString* FirstNamet = FirstNameLbl.text;
    NSString* LastName = LastNameLbl.text;
    NSString* Company = CompanyLbl.text;
    NSString* Designation = DesignationLbl.text;
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
    NSString* AssignedTo = AssigndToBtn.titleLabel.text;
    NSString* Street = StreetLbl.text;
    NSString* PoBox = PoBoxLbl.text;
    NSString* PostalCode = PostalCodeLbl.text;
    NSString* Country = CountryLbl.text;
    NSString* City =CityLbl.text;
    NSString* State = StateLbl.text;
    NSString* Description = DescriptionLbl.text;
    
    
    
    
    
    
    
    
    
    NSData* responseData = nil;
    NSURL *url=[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    responseData = [NSMutableData data] ;
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    NSString *bodydata=[NSString stringWithFormat:@"user_id=%@&salutation=%@&FirstName=%@&LastName=%@&Company=%@&Designation=%@&LeadSource=%@&Industry=%@&AnnualRevenue=%i&NoOfEmployees=%i&SecondaryEmail=%@&EmailOptOut=%@&TestField=%@&PrimaryPhone=%@&MobilePhone=%@&Fax=%@&PrimaryEmail=%@&Website=%@&LeadStatus=%@&Rating=%@&AssignedTo=%@&Street=%@&PoBox=%@&PostalCode=%@&Country=%@&City=%@&State=%@&Description=%@&LeadNumber=%@",UserId,@"",FirstNamet,LastName,Company,Designation,LeadSource,Industry,AnnualRevenue,NoOfEmployees,SecondaryEmail,EmailOptOut,TestField,PrimaryPhone,MobilePhone,Fax,PrimaryEmail,Website,LeadStatustoSend,Rating,AssignedTo,Street,PoBox,PostalCode,Country,City,State,Description,@"15"];
    
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

-(void)itemsDownloaded:(NSArray *)items
{
    // This delegate method will get called when the items are finished downloading
    
    // Set the downloaded items to the array
    _feedItems = items;
    NSMutableArray *LastNames=[[NSMutableArray alloc]init];
    
    for (int i=0; i<[_feedItems count]; i++) {
        Users *singleUser=_feedItems[i];
        
        
        
        [LastNames addObject:[NSString stringWithFormat:@"%@ %@",singleUser.FirstName,singleUser.LastName]   ];
        
        
    }
    
    animals=nil;
    animals=[[NSArray alloc] initWithArray:LastNames];
    [AssigndToBtn setTitle:[animals objectAtIndex:0] forState:UIControlStateNormal];
    
    
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
