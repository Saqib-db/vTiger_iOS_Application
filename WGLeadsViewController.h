//
//  WGLeadsViewController.h
//  VirtualAgents-test
//
//  Created by saqib on 1/14/15.
//  Copyright (c) 2015 Muhammad Saqib Yaqeen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeadsTableViewCell.h"
#import "LeadsModel.h"

@interface WGLeadsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,LeadsModelProtocol,UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UITableView *LeadsTable;
@property (weak, nonatomic) IBOutlet UIButton *MenuBtn;
@property (weak, nonatomic) IBOutlet UIButton *ActionBtn;

@end
