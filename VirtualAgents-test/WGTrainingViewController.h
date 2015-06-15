//
//  WGTrainingViewController.h
//  VirtualAgents-test
//
//  Created by saqib on 12/1/14.
//  Copyright (c) 2014 Muhammad Saqib Yaqeen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuickLook/QuickLook.h>
#import <MediaPlayer/MediaPlayer.h>



@interface WGTrainingViewController : UIViewController<QLPreviewControllerDataSource,UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *menuBtn;
@property (weak, nonatomic) IBOutlet UILabel *welomeText;
@property (weak, nonatomic) IBOutlet UIButton *videoBtn;
@property (weak, nonatomic) IBOutlet UIButton *PdfBtn;
@property (weak, nonatomic) IBOutlet UIButton *PPtBtn;
@property (weak, nonatomic) IBOutlet UIWebView *MainWebView;
@property (weak, nonatomic) IBOutlet UIButton *testBtn;

- (IBAction)SignOut:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableObj;


@property (nonatomic,strong) MPMoviePlayerController* mc;

@end
