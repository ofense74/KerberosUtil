//
//  Kerberos.h
//  KerberosUtil
//
//  Created by Magnus Eliasson on 10/25/12.
//  Copyright (c) 2012 Magnus Eliasson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GSS/gssapi_krb5.h>
#import <GSS/gssapi_apple.h>

@interface Kerberos : NSObject

@property (strong) NSTask *klist;
@property (strong) NSTask *kinit;
- (BOOL)hasTGT;
- (NSString*)getStringFromKlist;
- (void)kInit:(NSString*)accNname:(NSString*)pw;

@end
