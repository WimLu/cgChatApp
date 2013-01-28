//
//  ViewController.m
//  cgChatApp
//
//  Created by Wim on 24/01/13.
//  Copyright (c) 2013 Wim. All rights reserved.
//

#import "WebserviceConnection.h"

#import "ViewController.h"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //background queue

@interface ViewController ()
@end

@implementation ViewController{
}

//variabelen declareren
int lastMessageID =0;
NSString *cbPreyHunter;
NSString *cbHunterHunter;
NSString *cbHunterLeader;
NSString *selectedChatBox;
NSString *baseURL;

//basisURL

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //basisURL
    baseURL = @"http://webservice.citygamephl.be/CityGameWS/resources/generic/";
    
    //chat berichten opvragen
    [self getMessages];
    //timer voor het opvragen van de chatberichten
    [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(getMessages:) userInfo:nil repeats: YES];
}

-(void)getMessages{
    
    @try {
        //om te testen gewoon rechtstreeks parameters maken
        NSString * gameID = @"1";
        NSString * role = @"Jager";
        
        //parameters toevoegen aan de url
        NSString *strURL = [baseURL stringByAppendingString:[NSString stringWithFormat:@"getMessages/%@/%@/%@",gameID,role,[NSString stringWithFormat:@"%d",lastMessageID]]];
        
        NSLog(@"%@",strURL);
        NSURL * webserviceURL = [NSURL URLWithString:strURL];
        
        dispatch_async(kBgQueue, ^{
            NSData* data = [NSData dataWithContentsOfURL:
                            webserviceURL];
            [self performSelectorOnMainThread:@selector(fetchedMessages:)
                                   withObject:data waitUntilDone:YES];
        });
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
        
    }
    @finally {
    }

    //[self getMessages:gameID chatbox:chatbox lastMessageID:lastMessageID];
}

-(void)fetchedMessages:(NSData *)responseData{
    NSError* error;
    NSArray* json = [NSJSONSerialization
                     JSONObjectWithData:responseData //1
                     
                     options:kNilOptions
                     error:&error];
    cbHunterHunter = @"";
    cbHunterLeader = @"";
    cbPreyHunter = @"";
    for (NSDictionary *user in json) {
        // Gets the values of the different hunters
        NSNumber* messageID = [user objectForKey:@"message_ID"];
        NSString* message =  [user objectForKey:@"message"];
        NSString* player =  [user objectForKey:@"player"];
        NSString* chatbox =  [user objectForKey:@"chatbox"];
              NSLog(@"%@: %@", player, message);
        //zorgen dat het nr van de laatst opgehaalde boodschap opgeslagen wordt
        lastMessageID = messageID;
        if([chatbox isEqualToString:@"Jager-Jager"])
        {
            cbHunterHunter =  [cbHunterHunter stringByAppendingString:[NSString stringWithFormat: @"%@: %@\n", player, message]];
        }else if ([chatbox isEqualToString:@"Prooi-Jager"]){
            cbPreyHunter =  [cbPreyHunter stringByAppendingString:[NSString stringWithFormat: @"%@: %@\n", player, message]];

        }else{
            cbHunterLeader =  [cbHunterLeader stringByAppendingString:[NSString stringWithFormat: @"%@: %@\n", player, message]];
        }
        
        // logs the data

    }
    self.txtChatbox.text = selectedChatBox;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)chatInputEnd:(id)sender {
    [sender resignFirstResponder];
    //self.txtChatbox.text= [self.txtChatInput.text stringByAppendingString:self.txtChatbox.text];
    self.txtChatInput.text = @"";
}

- (IBAction)btnHunter:(UIBarButtonItem *)sender {
    selectedChatBox = cbHunterHunter;
    self.txtChatbox.text = selectedChatBox;

}

- (IBAction)btnPrey:(UIBarButtonItem *)sender {
   selectedChatBox = cbPreyHunter;
    self.txtChatbox.text = selectedChatBox;

}

- (IBAction)btnLeader:(UIBarButtonItem *)sender {
    selectedChatBox = cbHunterLeader;
    self.txtChatbox.text = selectedChatBox;
}
@end
