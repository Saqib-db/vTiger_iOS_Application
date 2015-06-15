//
//  WGViewController.m
//  VirtualAgents-test
//
//  Created by saqib on 12/1/14.
//  Copyright (c) 2014 Muhammad Saqib Yaqeen. All rights reserved.
//

#import "WGViewController.h"
#import "Users.h"
#import <CommonCrypto/CommonDigest.h>


@interface WGViewController (){
    UIActivityIndicatorView *indicator;
    UserModel *_userModel;
    NSArray *_feedItems;
    NSMutableArray *UserNames;
}

@end







@implementation WGViewController
@synthesize UserTxt;
@synthesize PasswordTxt;
@synthesize LoginBtn;
@synthesize InfoTxt;
@synthesize ForgotBtn;
@synthesize logoView;
@synthesize userImage;
@synthesize passwordImage;
@synthesize BackGroundImage;


#pragma mark -
#pragma mark -LifeCycle functions

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    self.navigationController.navigationBar.barTintColor = [WGViewController colorFromHexString:BlueColor];
    self.navigationController.navigationBar.translucent = YES;
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];

    
    PasswordTxt.secureTextEntry = YES;
    //[self.view setBackgroundColor:[WGViewController colorFromHexString:MainBackgroundColor]];
    //[UserTxt setBackgroundColor:[WGViewController colorFromHexString:MenuBackgroundColor]];
    //[PasswordTxt setBackgroundColor:[WGViewController colorFromHexString:MenuBackgroundColor]];
    [LoginBtn setBackgroundColor:[WGViewController colorFromHexString:BlueColor]];
    [LoginBtn setTintColor:[UIColor whiteColor]];
    [ForgotBtn setTintColor:[WGViewController colorFromHexString:TextColor]];
    //[BackGroundImage setImage:[UIImage imageNamed:@"landscape.png"]];
    
    LoginBtn.layer.cornerRadius=4.0f;

    /*[UserTxt setLeftViewMode:UITextFieldViewModeAlways];
    UserTxt.leftView= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Login-Page_07.png"]];

    
    [UserTxt.leftView setFrame:CGRectMake(UserTxt.leftView.frame.origin.x, UserTxt.leftView.frame.origin.y, UserTxt.leftView.frame.size.width-25, UserTxt.leftView.frame.size.height-25)];
    UserTxt.leftView.contentMode = UIViewContentModeScaleAspectFit;*/

    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    UserTxt.leftView = paddingView;
    UserTxt.leftViewMode = UITextFieldViewModeAlways;
    //userImage.image=[UIImage imageNamed:@"Login-Page_07.png"];
    userImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.view bringSubviewToFront:userImage];

   /* [PasswordTxt setLeftViewMode:UITextFieldViewModeAlways];
    PasswordTxt.leftView= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Login-Page_11.png"]];
    [PasswordTxt.leftView setFrame:CGRectMake(PasswordTxt.leftView.frame.origin.x+5, PasswordTxt.leftView.frame.origin.x, PasswordTxt.leftView.frame.size.width-25, PasswordTxt.leftView.frame.size.height-25)];
    PasswordTxt.leftView.contentMode = UIViewContentModeScaleAspectFit;*/
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    //UserTxt.leftView = paddingView1;
   // UserTxt.leftViewMode = UITextFieldViewModeAlways;
   PasswordTxt.leftView = paddingView1;
    PasswordTxt.leftViewMode = UITextFieldViewModeAlways;
    /*passwordImage.image=[UIImage imageNamed:@"Login-Page_11.png"];
    passwordImage.contentMode = UIViewContentModeScaleAspectFit;*/

    
    //logoView.image=[UIImage imageNamed:@"Login-Page_03.png"];
    //logoView.contentMode = UIViewContentModeScaleAspectFit;

    
    UserTxt.delegate=self;

    /*indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.frame = CGRectMake(0.0, 0.0, 40, 40);
    indicator.transform = CGAffineTransformMakeScale(2.75, 2.75);

    indicator.center = self.view.center;
    [self.view addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;*/

   /* PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    testObject[@"foo"] = @"bar";
    [testObject saveInBackground];*/
    
    //[self myMethod];
    _feedItems = [[NSArray alloc] init];
    
    // Create new HomeModel object and assign it to _homeModel variable
    _userModel = [[UserModel alloc] init];
    
    // Set this view controller object as the delegate for the home model object
    _userModel.delegate = self;
    
    // Call the download items method of the home model object
    [_userModel downloadItems];
    
	// Do any additional setup after loading the view, typically from a nib.
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector (keyboardDidShow:)
                                                 name: UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector (keyboardDidHide:)
                                                 name: UIKeyboardDidHideNotification
                                               object:nil];
    [UserTxt addTarget:self action:@selector(doit:) forControlEvents:UIControlEventEditingChanged];
    [self CheckUserName:UserTxt.text];


}
-(void)doit :(UITextField *)textField{
    [self CheckUserName:textField.text];

   // NSLog(@"lpc %@",textField.text);
    
}
-(void)itemsDownloaded:(NSArray *)items
{
    // This delegate method will get called when the items are finished downloading
    
    // Set the downloaded items to the array
    _feedItems = items;
    

    
    
    
    // Reload the table view
    }

- (void) dismissKeyboard
{
    // add self
    [self.UserTxt resignFirstResponder];
    [self.PasswordTxt resignFirstResponder];
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)LoginPressed:(id)sender {
    //[indicator startAnimating];
    NSString *UserName=UserTxt.text;
    NSString *Password=PasswordTxt.text;
    Password=[self md5:Password];
    [indicator stopAnimating];
    //[self performSegueWithIdentifier: @"Login-Dashboard" sender: self];

    
    NSLog(@"Hash = %@",Password);
    for (int i=0; i<[_feedItems count]; i++) {
        Users *singleUser=_feedItems[i];

        if ([UserName isEqualToString:singleUser.name]) {
            if ([Password isEqualToString:singleUser.password]) {
                [InfoTxt setTextColor:[UIColor blackColor]];
                [InfoTxt setText:@"Congrats you are logged in!!!"];
                
                NSUserDefaults *LoginedUser=[NSUserDefaults standardUserDefaults];
                [LoginedUser setObject:singleUser.LastName forKey:@"CurrentUser"];
                [LoginedUser setObject:singleUser.userId forKey:@"CurrentUserId"];
                [LoginedUser synchronize];
                
                [self performSegueWithIdentifier: @"Login-Dashboard" sender: self];
            }
            else{
                [InfoTxt setTextColor:[UIColor redColor]];
                [InfoTxt setText:@"Password is Wrong"];
                break;
            }
        }
        else{
            [InfoTxt setTextColor:[UIColor redColor]];
            [InfoTxt setText:@"UserName not Found!!"];
        }
    }
    
    
    
   /* [PFUser logInWithUsernameInBackground:UserName password:Password
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            
                                            
                                            
                                            
                                            
                                        } else {
                                            [InfoTxt setTextColor:[UIColor redColor]];
                                            [InfoTxt setText:@"UserName or Password is Wrong"];
                                        }
                                    }];*/
    
}
- (NSString *) md5:(NSString *) input
{
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}

- (void)keyboardDidShow:(NSNotification *)notification
{
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
    {
        [self.view setFrame:CGRectMake(0,-100,self.view.frame.size.width,self.view.frame.size.height)];
    }
    
    // Assign new frame to your view
    
}
-(void)CheckUserName :(NSString *)Text{
    [userImage setAlpha:0];
    [UserTxt setTextColor:[UIColor grayColor]];


    for (int i=0; i<[_feedItems count]; i++) {
        Users *singleUser=_feedItems[i];
        if ([Text isEqualToString:singleUser.name]) {
            NSLog(@"Users Found %@",singleUser.name);
            [userImage setAlpha:1.0];
            [UserTxt setTextColor:[WGGlobalFunctions colorFromHexString:BlueColor]];
            //[userImage setImage:[UIImage imageNamed:@"check.png"]];
            //[userImage setBackgroundColor:[UIColor purpleColor]];
            
           // [self.view bringSubviewToFront:userImage];
            NSLog(@"%f",userImage.frame.origin.x);

        }
        else{

            //[userImage setAlpha:0.0];
            //NSLog(@"Users Not Found");

            //[userImage setImage:[UIImage imageNamed:@"go.png"]];

        }
        
        
    }
    
}

-(void)deleteBackward{
    
}
-(void)insertText:(NSString *)text{
    
}

- (BOOL)hasText{
    return YES;
}

-(void)keyboardDidHide:(NSNotification *)notification
{
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
    {
        [self.view setFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height)];
    }}
+ (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

// pragma mark is used for easy access of code in Xcode
#pragma mark - TextField Delegates

// This method is called once we click inside the textField
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    return YES;
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
}

// This method is called once we complete editing
-(void)textFieldDidEndEditing:(UITextField *)textField{
}

// This method enables or disables the processing of return key
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
