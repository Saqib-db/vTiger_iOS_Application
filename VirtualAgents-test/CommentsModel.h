//
//  CommentsModel.h
//  VirtualAgents-test
//
//  Created by saqib on 2/24/15.
//  Copyright (c) 2015 Muhammad Saqib Yaqeen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CommentsModelProtocol <NSObject>

- (void)itemsDownloaded:(NSArray *)items;

@end
@interface CommentsModel : NSObject <NSURLConnectionDataDelegate>

@property (nonatomic, weak) id<CommentsModelProtocol> delegate;

- (void)downloadItems :(NSString *)UserId;

@end