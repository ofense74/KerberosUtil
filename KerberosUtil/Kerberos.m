//
//  Kerberos.m
//  KerberosUtil
//
//  Created by Magnus Eliasson on 10/25/12.
//  Copyright (c) 2012 Magnus Eliasson. All rights reserved.
//

#import "Kerberos.h"

@implementation Kerberos

- (NSString*)getStringFromKlist {
    NSTask *kerbList = [[NSTask alloc] init];
    NSPipe *pipe = [[NSPipe alloc] init];
    [kerbList setLaunchPath:@"/usr/bin/klist"];
    [kerbList setStandardOutput:pipe];
    [kerbList setStandardError:[kerbList standardOutput]];
    [kerbList launch];
    NSData *output = [[[kerbList standardOutput] fileHandleForReading] readDataToEndOfFile];
    NSString *out_string = [[NSString alloc] initWithData:output encoding:NSUTF8StringEncoding];
    return out_string;
}

- (BOOL)hasTGT {
    NSTask *kerbTrue = [[NSTask alloc] init];
    [kerbTrue setLaunchPath:@"/usr/bin/klist"];
    [kerbTrue setArguments:[NSArray arrayWithObject:@"-s"]];
    [kerbTrue launch];
    [kerbTrue waitUntilExit];
    if ([kerbTrue terminationStatus] == 0) {
        return YES;
    }
    else {
        return NO;
    }
     
}

- (void)kInit:(NSString*)accName:(NSString*)pw {
    
    const char *username = [accName cStringUsingEncoding:NSUTF8StringEncoding];
    const char *password = [pw cStringUsingEncoding:NSUTF8StringEncoding];
    
    OM_uint32 maj_stat, min_stat;
    gss_name_t name = GSS_C_NO_NAME;
    gss_cred_id_t cred = NULL;
    CFErrorRef error = NULL;
    gss_buffer_desc namebuffer;
    CFStringRef passwd;
    CFMutableDictionaryRef attributes;
    
    
    attributes = CFDictionaryCreateMutable(kCFAllocatorDefault, 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    
    namebuffer.value = (void *)username;
    namebuffer.length = strlen(username);
    
    maj_stat = gss_import_name(&min_stat, &namebuffer, GSS_C_NT_USER_NAME, &name);
    
    
    passwd = CFStringCreateWithCString(kCFAllocatorDefault, password, kCFStringEncodingUTF8);
    CFDictionarySetValue(attributes, kGSSICPassword, passwd);
    
    maj_stat = gss_aapl_initial_cred(name, GSS_KRB5_MECHANISM, attributes, &cred, &error);
    
    
}

@end
