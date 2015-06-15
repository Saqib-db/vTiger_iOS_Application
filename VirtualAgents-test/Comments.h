//
//  Comments.h
//  VirtualAgents-test
//
//  Created by saqib on 2/24/15.
//  Copyright (c) 2015 Muhammad Saqib Yaqeen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comments : NSObject
@property (nonatomic, strong) NSString *ModCommentID;
@property (nonatomic, strong) NSString *CommentContent;
@property (nonatomic, strong) NSString *RlatedTo;
@property (nonatomic, strong) NSString *ParentComment;
@property (nonatomic, strong) NSString *Customer;
@property (nonatomic, strong) NSString *UserId;
@property (nonatomic, strong) NSString *ReasonToEdit;

@property (nonatomic, strong) NSString *CreatedTime;
@property (nonatomic, strong) NSString *ModifiedTime;

@property (nonatomic, strong) NSString *CommentorFirstName;
@property (nonatomic, strong) NSString *CommentorLastName;


@end
