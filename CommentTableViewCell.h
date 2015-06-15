//
//  CommentTableViewCell.h
//  VirtualAgents-test
//
//  Created by saqib on 2/24/15.
//  Copyright (c) 2015 Muhammad Saqib Yaqeen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *FullNameTxt;
@property (weak, nonatomic) IBOutlet UITextView *CommentContentTxt;
@property (weak, nonatomic) IBOutlet UILabel *DaysAgoTxt;
@property (weak, nonatomic) IBOutlet UILabel *ModifiedDaysAgoTxt;
@property (weak, nonatomic) IBOutlet UILabel *ModifiedReasonTxt;
@property (weak, nonatomic) IBOutlet UIButton *ReplyBtn;
@property (weak, nonatomic) IBOutlet UIButton *EditBtn;
@property (weak, nonatomic) IBOutlet UIImageView *UserImage;

@end
