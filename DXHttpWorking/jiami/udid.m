//
//  udid.m
//  udid
//
//  Created by mac_mini02 on 14-8-13.
//  Copyright (c) 2014年 mac_mini02. All rights reserved.
//

#import "udid.h"

@implementation udid

+(NSString *)generateUUID
{
    CFUUIDRef newUniqueID = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef newUniqueIDString = CFUUIDCreateString(kCFAllocatorDefault, newUniqueID);
    NSString *guid = (__bridge NSString *)newUniqueIDString;
    
    CFRelease(newUniqueIDString);
    CFRelease(newUniqueID);
    return([[guid lowercaseString] stringByReplacingOccurrencesOfString:@"-" withString:@""]);
}

+(NSString *) getUniqueIdentifier
{

//    NSString *resource = [SSKeychain getPasswordForUsername:XINGE_RESOURCE andServiceName:KEYCHAIN_DEVICE_IDENTIFIER error:&error];
    NSString* resource=[SSKeychain passwordForService:IHOME_RESOURCE account:KEYCHAIN_DEVICE_IDENTIFIER ];
    if (!(resource)) {
        resource = [self generateUUID];
        [SSKeychain setPassword:resource forService:IHOME_RESOURCE account:KEYCHAIN_DEVICE_IDENTIFIER];
    }
    
    return resource;
}
@end
