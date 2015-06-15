//
//  WGEditViewController.h
//  VirtualAgents-test
//
//  Created by saqib on 2/5/15.
//  Copyright (c) 2015 Muhammad Saqib Yaqeen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Leads.h"
#import "NIDropDown.h"
#import "ActionSheetPicker.h"

@class AbstractActionSheetPicker;
@interface WGEditViewController : UIViewController<NIDropDownDelegate,UserModelProtocol>
{
    IBOutlet UIButton *Btn;
    NIDropDown *dropDown;
}
@property (retain, nonatomic) IBOutlet UIButton *Btn;
- (IBAction)selectClicked:(id)sender;
- (IBAction)LeadSourceSelected:(id)sender;
- (IBAction)LeadStatusSelected:(id)sender;
- (IBAction)IndustrySelected:(id)sender;
- (IBAction)RatingSelected:(id)sender;


-(void)rel;

@property (nonatomic, strong) Leads *RecievedLead;

@property (weak, nonatomic) IBOutlet UIButton *MenuBtn;
@property (weak, nonatomic) IBOutlet UIButton *EditBtn;
@property (weak, nonatomic) IBOutlet UIButton *SaveBtn;
@property (weak, nonatomic) IBOutlet UIButton *CancelBtn;
@property (weak, nonatomic) IBOutlet UIView *DetailViewOuter;
@property (weak, nonatomic) IBOutlet UIView *SecondColumnView;
@property (weak, nonatomic) IBOutlet UIView *FirstColumnDynamic;
@property (weak, nonatomic) IBOutlet UIView *FirstColumnView;
@property (weak, nonatomic) IBOutlet UIView *SecondColumnDynamic;
@property (weak, nonatomic) IBOutlet UIView *DetailHeader;






@property (nonatomic, strong) NSString *PreviousPage;
@property (weak, nonatomic) IBOutlet UITextField *FullNameLbl;
@property (weak, nonatomic) IBOutlet UITextField *DesignationLbl;
@property (weak, nonatomic) IBOutlet UITextField *FirstNameLbl;
@property (weak, nonatomic) IBOutlet UITextField *LastNameLbl;
@property (weak, nonatomic) IBOutlet UITextField *CompanyLbl;
@property (weak, nonatomic) IBOutlet UITextField *DesignationTableLbl;
@property (weak, nonatomic) IBOutlet UITextField *LeadSourceLbl;
@property (weak, nonatomic) IBOutlet UITextField *IndustryLbl;
@property (weak, nonatomic) IBOutlet UITextField *AnnualRevenueLbl;
@property (weak, nonatomic) IBOutlet UITextField *NoOfEmpLbl;
@property (weak, nonatomic) IBOutlet UITextField *SecEmlLbl;
@property (weak, nonatomic) IBOutlet UITextField *ModifiedTime;
@property (weak, nonatomic) IBOutlet UITextField *EmailOptOutLbl;
@property (weak, nonatomic) IBOutlet UITextField *TestFieldLbl;
@property (weak, nonatomic) IBOutlet UITextField *LeadNumberLbl;
@property (weak, nonatomic) IBOutlet UITextField *PrimaryPhoneLbl;
@property (weak, nonatomic) IBOutlet UITextField *MobilePhoneLbl;
@property (weak, nonatomic) IBOutlet UITextField *FaxLbl;
@property (weak, nonatomic) IBOutlet UITextField *PrimaryEmlLbl;
@property (weak, nonatomic) IBOutlet UITextField *WebsiteLbl;
@property (weak, nonatomic) IBOutlet UITextField *LeadSrcLbl;
@property (weak, nonatomic) IBOutlet UITextField *RAtingLbl;
@property (weak, nonatomic) IBOutlet UITextField *AssignedToLbl;
@property (weak, nonatomic) IBOutlet UITextField *CreatedTime;
@property (weak, nonatomic) IBOutlet UITextField *CreatedByLbl;


@property (weak, nonatomic) IBOutlet UITextField *StateLbl;
@property (weak, nonatomic) IBOutlet UITextField *CityLbl;
@property (weak, nonatomic) IBOutlet UITextField *PoBoxLbl;
@property (weak, nonatomic) IBOutlet UITextField *StreetLbl;
@property (weak, nonatomic) IBOutlet UITextField *PostalCodeLbl;
@property (weak, nonatomic) IBOutlet UITextField *CountryLbl;

@property (weak, nonatomic) IBOutlet UITextField *DescriptionLbl;

@property (weak, nonatomic) IBOutlet UIView *DescriptionOuterView;

@property (weak, nonatomic) IBOutlet UIView *AddressOuterView;
@property (weak, nonatomic) IBOutlet UIButton *AssignedToBtn;
@property (weak, nonatomic) IBOutlet UIButton *LeadSourceBtn;
@property (weak, nonatomic) IBOutlet UIButton *IndustryBtn;
@property (weak, nonatomic) IBOutlet UIButton *LeadStatusBtn;
@property (weak, nonatomic) IBOutlet UIButton *RatingBtn;









@property (weak, nonatomic) IBOutlet UIScrollView *MAinScrollView;


@end
