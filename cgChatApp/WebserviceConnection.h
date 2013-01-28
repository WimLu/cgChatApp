//
//  WebserviceConnection.h
//  MapkitAppCitygame
//
//  Created by Wim on 16/01/13.
//  Copyright (c) 2013 Wim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface WebserviceConnection : NSObject 
-(void)getData; //publieke methode getData
-(void)sendMessage:(NSString *) message;
-(void)getMessages:(NSString *) gameID chatbox:(NSString *) chatbox  lastMessageID:(NSString *) lastMessageID;
@end
