//
//  UserModel.m
//  VirtualAgents-test
//
//  Created by saqib on 12/2/14.
//  Copyright (c) 2014 Muhammad Saqib Yaqeen. All rights reserved.
//

#import "CommentsModel.h"
#import "Comments.h"

@interface CommentsModel()
{
    NSMutableData *_downloadedData;
}
@end

@implementation CommentsModel

- (void)downloadItems :(NSString *)UserId
{
    // Download the json file
    NSURL *jsonFileUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.virtualdev.ca/clients/rep/Comment.php?related_to=%@",UserId]];
    
    // Create the request
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:jsonFileUrl];
    
    // Create the NSURLConnection
    [NSURLConnection connectionWithRequest:urlRequest delegate:self];
}

#pragma mark NSURLConnectionDataProtocol Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // Initialize the data object
    _downloadedData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the newly downloaded data
    [_downloadedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // Create an array to store the locations
    NSMutableArray *_Users = [[NSMutableArray alloc] init];
    
    // Parse the JSON that came in
    NSError *error;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:_downloadedData options:NSJSONReadingAllowFragments error:&error];
    
    // Loop through Json objects, create question objects and add them to our questions array
    for (int i = 0; i < jsonArray.count; i++)
    {
        NSDictionary *jsonElement = jsonArray[i];
        
        // Create a new location object and set its props to JsonElement properties
        Comments *newComments = [[Comments alloc] init];
        newComments.ModCommentID = jsonElement[@"modcommentsid"];
        newComments.CommentContent = jsonElement[@"commentcontent"];
        newComments.RlatedTo = jsonElement[@"related_to"];
        newComments.ParentComment = jsonElement[@"parent_comments"];
        newComments.Customer = jsonElement[@"customer"];
        newComments.UserId = jsonElement[@"userid"];
        newComments.ReasonToEdit = jsonElement[@"reasontoedit"];
        newComments.CreatedTime = jsonElement[@"createdtime"];
        newComments.ModifiedTime = jsonElement[@"modifiedtime"];
        newComments.CommentorFirstName = jsonElement[@"first_name"];
        newComments.CommentorLastName = jsonElement[@"last_name"];

        
               // Add this question to the locations array
        [_Users addObject:newComments];
    }
    
    // Ready to notify delegate that data is ready and pass back items
    if (self.delegate)
    {
        [self.delegate itemsDownloaded:_Users];
    }
}

@end