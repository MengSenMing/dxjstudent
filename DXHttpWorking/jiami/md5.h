//
//  md5.h
//  登录页面
//
//  Created by mac_mini02 on 14-8-26.
//  Copyright (c) 2014年 mac_mini02. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
@interface md5 : NSObject
+(NSString*)md5WithString:(NSString*)string;
@end
