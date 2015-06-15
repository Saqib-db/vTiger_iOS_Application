//
//  UserModel.h
//  VirtualAgents-test
//
//  Created by saqib on 12/2/14.
//  Copyright (c) 2014 Muhammad Saqib Yaqeen. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol UserModelProtocol <NSObject>

- (void)itemsDownloaded:(NSArray *)items;

@end
@interface UserModel : NSObject <NSURLConnectionDataDelegate>
@property (nonatomic, weak) id<UserModelProtocol> delegate;

- (void)downloadItems;

@end
