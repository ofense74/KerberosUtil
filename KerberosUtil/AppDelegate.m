//
//  AppDelegate.m
//  KerberosUtil
//
//  Created by Magnus Eliasson on 10/24/12.
//  Copyright (c) 2012 Magnus Eliasson. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
    kerberos = [[Kerberos alloc] init];
    [self updateUserInterface];
}

- (IBAction)passwdOK:(id)sender {
    username = [self.accName stringValue];
    password = [self.passwd stringValue];
    [kerberos kInit:username:password];
    [NSApp endSheet:passWin];
    [passWin orderOut:self];
    [self updateUserInterface];
    
}

- (IBAction)cancel:(id)sender {
    [NSApp terminate: nil];
}

- (IBAction)getTicket:(id)sender {
    
    [NSApp beginSheet:passWin modalForWindow:_window modalDelegate:self didEndSelector:nil contextInfo:nil];

}

- (void)updateTextField:(NSString*)keList {
    [self.kerbList setStringValue:keList];
}

- (void)updateColor {
    if ([kerberos hasTGT]) {
        [self.krbColor setColor:[NSColor greenColor]];
    }
    else {
        [self.krbColor setColor:[NSColor redColor]];
    }
}

- (void)updateUserMessage {
    if ([kerberos hasTGT]) {
        [self.krbTextForUser setStringValue:@"You have a ticket!"];
    }
    else {
        [self.krbTextForUser setStringValue:@"You don't have a ticket!"];
    }
}

- (void)updateUserInterface {
    [self updateTextField:[kerberos getStringFromKlist]];
    [self updateColor];
    [self updateUserMessage];
    
}

@end
