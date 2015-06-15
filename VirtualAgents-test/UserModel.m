//
//  UserModel.m
//  VirtualAgents-test
//
//  Created by saqib on 12/2/14.
//  Copyright (c) 2014 Muhammad Saqib Yaqeen. All rights reserved.
//

#import "UserModel.h"
#import "Users.h"

@interface UserModel()
{
    NSMutableData *_downloadedData;
}
@end

@implementation UserModel

- (void)downloadItems
{
    // Download the json file
    NSURL *jsonFileUrl = [NSURL URLWithString:@"http://virtualdev.ca/clients/rep/service.php"];
    
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
        Users *newUser = [[Users alloc] init];
        newUser.userId = jsonElement[@"id"];
        newUser.name = jsonElement[@"user_name"];
        newUser.password = jsonElement[@"user_hash"];
        newUser.FirstName = jsonElement[@"first_name"];
        newUser.LastName = jsonElement[@"last_name"];

        
        // Add this question to the locations array
        [_Users addObject:newUser];
    }
    
    // Ready to notify delegate that data is ready and pass back items
    if (self.delegate)
    {
        [self.delegate itemsDownloaded:_Users];
    }
}

@end