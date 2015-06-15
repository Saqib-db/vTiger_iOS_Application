//
//  LeadsModel.m
//  VirtualAgents-test
//
//  Created by saqib on 1/21/15.
//  Copyright (c) 2015 Muhammad Saqib Yaqeen. All rights reserved.
//

#import "LeadsModel.h"
#import "Leads.h"

@interface LeadsModel()
{
    NSMutableData *_downloadedData;
}
@end




@implementation LeadsModel

- (void)downloadItems{
    // Download the json file
    NSURL *jsonFileUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://virtualdev.ca/clients/rep/leads.php"]];
    
    
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
        Leads *newLead = [[Leads alloc] init];
        
        newLead.LeadId = jsonElement[@"leadid"];

        newLead.FirstName = jsonElement[@"firstname"];
        newLead.LastName = jsonElement[@"lastname"];
        newLead.Company = jsonElement[@"company"];
        newLead.LeadSource = jsonElement[@"leadsource"];
        newLead.PrimaryEmail = jsonElement[@"email"];
        newLead.Designation = jsonElement[@"designation"];

        newLead.PrimaryPhone = jsonElement[@"phone"];
        newLead.Website = jsonElement[@"website"];
        newLead.AssignedTo = jsonElement[@"last_name"];
        newLead.City = jsonElement[@"city"];
        newLead.Country = jsonElement[@"country"];
        
        newLead.CreatedOn = jsonElement[@"createdtime"];
        newLead.ModifiedOn = jsonElement[@"modifiedtime"];
        
        
        
        newLead.Industry = jsonElement[@"industry"];
        newLead.AnnualRevenue = jsonElement[@"annualrevenue"];
        newLead.NoOfEmp = jsonElement[@"noofemployees"];
        
        newLead.SecEml = jsonElement[@"secondaryemail"];

        if ([newLead.SecEml isEqual:[NSNull null]]) {
            newLead.SecEml = nil;
        }
        
        newLead.EmlOptOut = jsonElement[@"emailoptout"];
        newLead.TestField = jsonElement[@"cf_751"];
        newLead.LeadNumber = jsonElement[@"lead_no"];
        newLead.Fax = jsonElement[@"fax"];
        newLead.LeadStatus = jsonElement[@"leadstatus"];
        newLead.Rating = jsonElement[@"rating"];
        newLead.CreatedBy = jsonElement[@"smcreatorid"];
        newLead.MobilePhone = jsonElement[@"mobile"];
        newLead.street = jsonElement[@"lane"];
        newLead.PoBox = jsonElement[@"pobox"];
        newLead.PostalCode = jsonElement[@"code"];
        newLead.State = jsonElement[@"state"];


        newLead.TextDescription = jsonElement[@"description"];


        
        // Add this question to the locations array
        [_Leads addObject:newLead];
    }
    
    // Ready to notify delegate that data is ready and pass back items
    if (self.delegate)
    {
        [self.delegate itemsDownloaded:_Leads];
    }
}

@end