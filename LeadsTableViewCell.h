//
//  LeadsTableViewCell.h
//  VirtualAgents-test
//
//  Created by saqib on 1/14/15.
//  Copyright (c) 2015 Muhammad Saqib Yaqeen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeadsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *FirstNameTxt;
@property (weak, nonatomic) IBOutlet UILabel *LastNameTxt;
@property (weak, nonatomic) IBOutlet UILabel *CompanyText;

@property (weak, nonatomic) IBOutlet UILabel *AssignedToText;
@property (weak, nonatomic) IBOutlet UIButton *MarkBtn;

@property (weak, nonatomic) IBOutlet UIButton *CompleteDetailBtn;
@property (weak, nonatomic) IBOutlet UIButton *EditBtn;
@property (weak, nonatomic) IBOutlet UIButton *DeleteBtn;
@property (weak, nonatomic) IBOutlet UITextField *FirstNameTF;
@property (weak, nonatomic) IBOutlet UITextField *LastNameTF;
@property (weak, nonatomic) IBOutlet UITextField *CompanyTF;
@property (weak, nonatomic) IBOutlet UITextField *AssignedtoTF;
@property (weak, nonatomic) IBOutlet UIButton *SearchBtn;
@end
