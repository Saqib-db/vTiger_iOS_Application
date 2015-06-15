//
//  WGActivitiesViewController.h
//  VirtualAgents-test
//
//  Created by saqib on 3/5/15.
//  Copyright (c) 2015 Muhammad Saqib Yaqeen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityModel.h"

@interface WGActivitiesViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,ActivityModelProtocol>
@property (weak, nonatomic) IBOutlet UITableView *ActivitiesTable;
@property (weak, nonatomic) IBOutlet UIButton *MenuBtn;
@property (weak, nonatomic) IBOutlet UIButton *ActionBtn;

@end
