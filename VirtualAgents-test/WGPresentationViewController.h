//
//  WGPresentationViewController.h
//  VirtualAgents-test
//
//  Created by saqib on 12/1/14.
//  Copyright (c) 2014 Muhammad Saqib Yaqeen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EAIntroView.h"
#import <MediaPlayer/MediaPlayer.h>





@interface WGPresentationViewController : UIViewController<EAIntroDelegate,UIWebViewDelegate>
- (IBAction)AgainFunction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *MenuBtn;

@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (nonatomic,strong) MPMoviePlayerController* mc;
@property (nonatomic, strong) NSString *PreviousPage;


+(UIView*)MakeMeuView;
+(UIView*)MakeSubMeuView;
+(UIView*)MakeSubMeuViewPresentation;

@end
