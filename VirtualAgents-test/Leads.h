//
//  Leads.h
//  VirtualAgents-test
//
//  Created by saqib on 1/21/15.
//  Copyright (c) 2015 Muhammad Saqib Yaqeen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Leads : NSObject

@property (nonatomic, strong) NSString *LeadId;

@property (nonatomic, strong) NSString *FirstName;
@property (nonatomic, strong) NSString *LastName;
@property (nonatomic, strong) NSString *Company;
@property (nonatomic, strong) NSString *PrimaryPhone;
@property (nonatomic, strong) NSString *LeadSource;
@property (nonatomic, strong) NSString *PrimaryEmail;
@property (nonatomic, strong) NSString *Website;
@property (nonatomic, strong) NSString *AssignedTo;
@property (nonatomic, strong) NSString *City;
@property (nonatomic, strong) NSString *Country;

@property (nonatomic, strong) NSString *Designation;


@property (nonatomic, strong) NSString *CreatedOn;
@property (nonatomic, strong) NSString *ModifiedOn;

@property (nonatomic, strong) NSString *Industry;
@property (nonatomic, strong) NSString *AnnualRevenue;
@property (nonatomic, strong) NSString *NoOfEmp;
@property (nonatomic, strong) NSString *SecEml;
@property (nonatomic, strong) NSString *EmlOptOut;
@property (nonatomic, strong) NSString *TestField;
@property (nonatomic, strong) NSString *LeadNumber;
@property (nonatomic, strong) NSString *Fax;
@property (nonatomic, strong) NSString *LeadStatus;
@property (nonatomic, strong) NSString *Rating;
@property (nonatomic, strong) NSString *CreatedBy;
@property (nonatomic, strong) NSString *MobilePhone;


@property (nonatomic, strong) NSString *street;
@property (nonatomic, strong) NSString *PoBox;
@property (nonatomic, strong) NSString *PostalCode;
@property (nonatomic, strong) NSString *State;


@property (nonatomic, strong) NSString *TextDescription;


@end
