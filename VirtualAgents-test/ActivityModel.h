//
//  ActivityModel.h
//  VirtualAgents-test
//
//  Created by saqib on 3/5/15.
//  Copyright (c) 2015 Muhammad Saqib Yaqeen. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol ActivityModelProtocol <NSObject>
- (void)itemsDownloaded:(NSArray *)items;

@end

@interface ActivityModel : NSObject<NSURLConnectionDataDelegate>

@property (nonatomic, weak) id<ActivityModelProtocol> delegate;

- (void)downloadItems;

@end
