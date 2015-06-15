//
//  WGLeadsDetailsFullViewController.h
//  VirtualAgents-test
//
//  Created by saqib on 1/30/15.
//  Copyright (c) 2015 Muhammad Saqib Yaqeen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Leads.h"

@interface WGLeadsDetailsFullViewController : UIViewController<UIActionSheetDelegate>

@property (nonatomic, strong) Leads *RecievedLead;

@property (weak, nonatomic) IBOutlet UIButton *MenuBtn;
@property (weak, nonatomic) IBOutlet UIButton *EditBtn;
@property (weak, nonatomic) IBOutlet UIButton *SendEmailBtn;
@property (weak, nonatomic) IBOutlet UIButton *ConvertEmailBtn;
@property (weak, nonatomic) IBOutlet UIButton *MoreBtn;
@property (weak, nonatomic) IBOutlet UIButton *SettingBtn;
@property (weak, nonatomic) IBOutlet UIView *DetailViewOuter;
@property (weak, nonatomic) IBOutlet UIView *SecondColumnView;
@property (weak, nonatomic) IBOutlet UIView *FirstColumnDynamic;
@property (weak, nonatomic) IBOutlet UIView *FirstColumnView;
@property (weak, nonatomic) IBOutlet UIView *SecondColumnDynamic;
@property (weak, nonatomic) IBOutlet UIView *DetailHeader;






@property (nonatomic, strong) NSString *PreviousPage;
@property (weak, nonatomic) IBOutlet UILabel *FullNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *DesignationLbl;
@property (weak, nonatomic) IBOutlet UILabel *FirstNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *LastNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *CompanyLbl;
@property (weak, nonatomic) IBOutlet UILabel *DesignationTableLbl;
@property (weak, nonatomic) IBOutlet UILabel *LeadSourceLbl;
@property (weak, nonatomic) IBOutlet UILabel *IndustryLbl;
@property (weak, nonatomic) IBOutlet UILabel *AnnualRevenueLbl;
@property (weak, nonatomic) IBOutlet UILabel *NoOfEmpLbl;
@property (weak, nonatomic) IBOutlet UILabel *SecEmlLbl;
@property (weak, nonatomic) IBOutlet UILabel *ModifiedTime;
@property (weak, nonatomic) IBOutlet UILabel *EmailOptOutLbl;
@property (weak, nonatomic) IBOutlet UILabel *TestFieldLbl;
@property (weak, nonatomic) IBOutlet UILabel *LeadNumberLbl;
@property (weak, nonatomic) IBOutlet UILabel *PrimaryPhoneLbl;
@property (weak, nonatomic) IBOutlet UILabel *MobilePhoneLbl;
@property (weak, nonatomic) IBOutlet UILabel *FaxLbl;
@property (weak, nonatomic) IBOutlet UILabel *PrimaryEmlLbl;
@property (weak, nonatomic) IBOutlet UILabel *WebsiteLbl;
@property (weak, nonatomic) IBOutlet UILabel *LeadSrcLbl;
@property (weak, nonatomic) IBOutlet UILabel *RAtingLbl;
@property (weak, nonatomic) IBOutlet UILabel *AssignedToLbl;
@property (weak, nonatomic) IBOutlet UILabel *CreatedTime;
@property (weak, nonatomic) IBOutlet UILabel *CreatedByLbl;


@property (weak, nonatomic) IBOutlet UILabel *StateLbl;
@property (weak, nonatomic) IBOutlet UILabel *CityLbl;
@property (weak, nonatomic) IBOutlet UILabel *PoBoxLbl;
@property (weak, nonatomic) IBOutlet UILabel *StreetLbl;
@property (weak, nonatomic) IBOutlet UILabel *PostalCodeLbl;
@property (weak, nonatomic) IBOutlet UILabel *CountryLbl;

@property (weak, nonatomic) IBOutlet UILabel *DescriptionLbl;

@property (weak, nonatomic) IBOutlet UIView *DescriptionOuterView;

@property (weak, nonatomic) IBOutlet UIView *AddressOuterView;









@property (weak, nonatomic) IBOutlet UIScrollView *MAinScrollView;






















@end
