//
//  LeadsModel.h
//  VirtualAgents-test
//
//  Created by saqib on 1/21/15.
//  Copyright (c) 2015 Muhammad Saqib Yaqeen. All rights reserved.
//


#import <Foundation/Foundation.h>
@protocol LeadsModelProtocol <NSObject>

- (void)itemsDownloaded:(NSArray *)items;

@end
@interface LeadsModel : NSObject <NSURLConnectionDataDelegate>

@property (nonatomic, weak) id<LeadsModelProtocol> delegate;

- (void)downloadItems;

@end