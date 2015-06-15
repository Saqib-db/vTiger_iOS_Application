//
//  ActivityModel.m
//  VirtualAgents-test
//
//  Created by saqib on 3/5/15.
//  Copyright (c) 2015 Muhammad Saqib Yaqeen. All rights reserved.
//

#import "ActivityModel.h"
#import "Activity.h"

@interface ActivityModel()
{
    NSMutableData *_downloadedData;
}
@end
@implementation ActivityModel
- (void)downloadItems{
    // Download the json file
    NSURL *jsonFileUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.virtualdev.ca/clients/rep/Activity.php"]];
    
    
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
    NSMutableArray *_Leads = [[NSMutableArray alloc] init];
    
    // Parse the JSON that came in
    NSError *error;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:_downloadedData options:NSJSONReadingAllowFragments error:&error];
    
    // Loop through Json objects, create question objects and add them to our questions array
    for (int i = 0; i < jsonArray.count; i++)
    {
        NSDictionary *jsonElement = jsonArray[i];
        
        // Create a new location object and set its props to JsonElement properties
        Activity *newActivity = [[Activity alloc] init];
        
        newActivity.ActivityID = jsonElement[@"activityid"];
        newActivity.Status = jsonElement[@"eventstatus"];
        
        if ([newActivity.Status isEqual:[NSNull null]]) {
            newActivity.Status = nil;
        }
        
        
        newActivity.ActivityType = jsonElement[@"activitytype"];
        newActivity.Subject = jsonElement[@"subject"];
        newActivity.AssigendTo = [NSString stringWithFormat:@"%@ %@",jsonElement[@"first_name"],jsonElement[@"last_name"]];
        newActivity.StartDate=jsonElement[@"date_start"];
        NSArray* foo = [newActivity.StartDate componentsSeparatedByString: @"-"];
        
        newActivity.StartYear = [foo objectAtIndex: 0];
        
        newActivity.StartMonth = [foo objectAtIndex: 1];
        newActivity.StartDay = [foo objectAtIndex: 2];

                                  
                                  
                                  

        // Add this question to the locations array
        [_Leads addObject:newActivity];
    }
    
    // Ready to notify delegate that data is ready and pass back items
    if (self.delegate)
    {
        [self.delegate itemsDownloaded:_Leads];
    }
}

@end