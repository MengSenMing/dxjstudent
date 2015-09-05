//
//  udid.h
//  udid
//
//  Created by mac_mini02 on 14-8-13.
//  Copyright (c) 2014年 mac_mini02. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SSKeychain.h"
#import "DXNetInterface.h"
@interface udid : NSObject
+(NSString *)generateUUID;
+(NSString *)getUniqueIdentifier;
@end
