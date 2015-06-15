//
//  WGCalenderViewController.h
//  VirtualAgents-test
//
//  Created by saqib on 3/6/15.
//  Copyright (c) 2015 Muhammad Saqib Yaqeen. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "JTCalendar.h"
#import "CalendarKit.h"
//#import "CKDemoViewController.h"
#import "NSCalendarCategories.h"
#import "NSDate+Components.h"
#import "ActivityModel.h"


@interface WGCalenderViewController : UIViewController<CKCalendarViewDataSource,CKCalendarViewDelegate,ActivityModelProtocol>




@property (weak, nonatomic) IBOutlet UIView *CalendarView;


@property (weak, nonatomic) IBOutlet UIButton *MenuBtn;
@property (weak, nonatomic) IBOutlet UIButton *ActionBtn;

@property (weak, nonatomic) IBOutlet UISegmentedControl *MDYsegment;

-(IBAction)indexChanged:(UISegmentedControl *)sender;

@end
