//
//  Activity.h
//  VirtualAgents-test
//
//  Created by saqib on 3/5/15.
//  Copyright (c) 2015 Muhammad Saqib Yaqeen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Activity : NSObject
@property (nonatomic, strong) NSString *ActivityID;
@property (nonatomic, strong) NSString *Status;
@property (nonatomic, strong) NSString *ActivityType;
@property (nonatomic, strong) NSString *Subject;
@property (nonatomic, strong) NSString *AssigendTo;

@property (nonatomic, strong) NSString *StartDate;

@property (nonatomic, strong) NSString *StartDay;
@property (nonatomic, strong) NSString *StartMonth;
@property (nonatomic, strong) NSString *StartYear;

@end
