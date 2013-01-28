//
//  WebserviceConnection.m
//  MapkitAppCitygame
//
//  Created by Wim on 16/01/13.
//  Copyright (c) 2013 Wim. All rights reserved.
//

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //background queue
#define webserviceURL [NSURL URLWithString:@"http://webservice.citygamephl.be/CityGameWS/resources/generic/getMessages/1/Jager-Jager/3"] //URL webservice

#import "WebserviceConnection.h"

@implementation WebserviceConnection

-(void)sendMessage:(NSString *) message
{
    dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL:
                        webserviceURL];
        [self performSelectorOnMainThread:@selector(fetchedData:)
                               withObject:data waitUntilDone:YES];
    });
    /*
    NSError* error;
    //build an info object and convert to json
    NSDictionary *newDatasetInfo = [NSDictionary dictionaryWithObjectsAndKeys:chatbox, @"chatbox", nil];
    
    //convert object to data
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:newDatasetInfo options:kNilOptions error:&error];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:webserviceURL];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:jsonData];
    
    // print json:
    NSLog(@"JSON summary: %@", [[NSString alloc] initWithData:jsonData
                                                     encoding:NSUTF8StringEncoding]);*/
}

-(void)getMessages:(NSString *)gameID chatbox:(NSString *)chatbox lastMessageID:(NSString *)lastMessageID
{
    //getMessages/1/Jager-Jager/3
    //data wordt geladen in background queue
    //webserviceURL = [webserviceURL stringByAppendingString:@"getMessages/1/Jager-Jager/3"];
    dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL:
                        webserviceURL];
        [self performSelectorOnMainThread:@selector(fetchedMessages:)
                               withObject:data waitUntilDone:YES];
    });
}

-(void)fetchedMessages:(NSData *)responseData{
    NSError* error;
    NSArray* json = [NSJSONSerialization
                     JSONObjectWithData:responseData //1
                     
                     options:kNilOptions
                     error:&error];
    
    for (NSDictionary *user in json) {
        // Gets the values of the different hunters
        NSNumber* messageID = [user objectForKey:@"message_ID"];
        NSString* message =  [user objectForKey:@"message"];
        NSString* player =  [user objectForKey:@"player"];
        
        // logs the data
        NSLog(@"%@: %@", player, message);
    }

}


- (void)fetchedData:(NSData *)responseData {
    //parse out the json data
    NSError* error;
    NSArray* json = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          
                          options:kNilOptions
                          error:&error];

    NSLog(@"lolqjdmhsnb qlnsdbqlb:s d;qjbd");
    
    for (NSDictionary *user in json) {
        // Gets the values of the different hunters
        NSNumber* messageID = [user objectForKey:@"message_ID"];
        NSString* message =  [user objectForKey:@"message"];
        NSString* player =  [user objectForKey:@"player"];
        
        // logs the data
        NSLog(@"%@: %@", player, message);
    }

}
@end
