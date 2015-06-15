//
//  WGLeadsDetailsViewController.h
//  VirtualAgents-test
//
//  Created by saqib on 1/23/15.
//  Copyright (c) 2015 Muhammad Saqib Yaqeen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Leads.h"
#import "CommentsModel.h"

@interface WGLeadsDetailsViewController : UIViewController<UIActionSheetDelegate,UIAlertViewDelegate,UITableViewDelegate,UITableViewDataSource,CommentsModelProtocol>
@property (weak, nonatomic) IBOutlet UIView *DescriptionViewOuter;
@property (weak, nonatomic) IBOutlet UIView *CommentViewOuter;
@property (weak, nonatomic) IBOutlet UIButton *MenuBtn;
@property (nonatomic, strong) NSString *PreviousPage;
@property (weak, nonatomic) IBOutlet UILabel *FullNameTxt;
@property (weak, nonatomic) IBOutlet UILabel *DesignationTxt;

@property (nonatomic, strong) NSString *Fullname;
@property (nonatomic, strong) NSString *Designation;
@property (weak, nonatomic) IBOutlet UILabel *FirstNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *LastNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *PrimaryPhoneLbl;
@property (weak, nonatomic) IBOutlet UILabel *CompanyLbl;
@property (weak, nonatomic) IBOutlet UILabel *LeadSrcLbl;
@property (weak, nonatomic) IBOutlet UILabel *PrimayEmailSrcLbl;
@property (weak, nonatomic) IBOutlet UILabel *WebsiteLbl;
@property (weak, nonatomic) IBOutlet UILabel *AssignedToLbl;
@property (weak, nonatomic) IBOutlet UILabel *CityLbl;
@property (weak, nonatomic) IBOutlet UILabel *CountryLbl;
@property (weak, nonatomic) IBOutlet UILabel *CreatedOnLbl;
@property (weak, nonatomic) IBOutlet UILabel *ModifiedOnLbl;

@property (nonatomic, strong) Leads *RecievedLead;
@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;
@property (weak, nonatomic) IBOutlet UIView *NoCommentView;
@property (weak, nonatomic) IBOutlet UIButton *EditBtn;
@property (weak, nonatomic) IBOutlet UIButton *SendEmailBtn;
@property (weak, nonatomic) IBOutlet UIButton *ConvertLeadBtn;

@property (weak, nonatomic) IBOutlet UIButton *MoreBtn;
@property (weak, nonatomic) IBOutlet UIButton *SettingBtn;

@property (weak, nonatomic) IBOutlet UIView *DetailOuterView;

@property (weak, nonatomic) IBOutlet UIView *FirstColumnView;
@property (weak, nonatomic) IBOutlet UIView *SecontColumnView;
@property (weak, nonatomic) IBOutlet UIView *FirstColumnDynamicView;
@property (weak, nonatomic) IBOutlet UIView *SecondColumnDynamicView;
@property (weak, nonatomic) IBOutlet UIButton *ShowFullBtn;
@property (weak, nonatomic) IBOutlet UIView *CommentView;
@property (weak, nonatomic) IBOutlet UIButton *PostBtn;
@property (weak, nonatomic) IBOutlet UITextView *CommentTF;
@property (weak, nonatomic) IBOutlet UIView *PreviousCommentsView;

@property (weak, nonatomic) IBOutlet UITableView *CommentsTable;







@end
