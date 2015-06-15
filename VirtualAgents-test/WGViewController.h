//
//  WGViewController.h
//  VirtualAgents-test
//
//  Created by saqib on 12/1/14.
//  Copyright (c) 2014 Muhammad Saqib Yaqeen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"

@interface WGViewController : UIViewController<UserModelProtocol,UIKeyInput,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *UserTxt;
@property (weak, nonatomic) IBOutlet UITextField *PasswordTxt;
@property (weak, nonatomic) IBOutlet UIButton *LoginBtn;
@property (weak, nonatomic) IBOutlet UILabel *InfoTxt;
- (IBAction)LoginPressed:(id)sender;
+ (UIColor *)colorFromHexString:(NSString *)hexString;
@property (weak, nonatomic) IBOutlet UIButton *ForgotBtn;
@property (weak, nonatomic) IBOutlet UIImageView *logoView;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UIImageView *passwordImage;
@property (weak, nonatomic) IBOutlet UIImageView *BackGroundImage;

@end
