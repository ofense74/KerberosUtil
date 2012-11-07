//
//  AppDelegate.h
//  KerberosUtil
//
//  Created by Magnus Eliasson on 10/24/12.
//  Copyright (c) 2012 Magnus Eliasson. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Kerberos.h"

@class Kerberos;

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    IBOutlet NSPanel *passWin;
    NSString *password;
    NSString *username;
    Kerberos *kerberos;
}

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *kerbList;
@property (weak) IBOutlet NSTextField *accName;
@property (weak) IBOutlet NSSecureTextField *passwd;
@property (weak) IBOutlet NSColorWell *krbColor;
@property (weak) IBOutlet NSTextField *krbTextForUser;
- (IBAction)passwdOK:(id)sender;
- (IBAction)cancel:(id)sender;
- (IBAction)getTicket:(id)sender;

@end
