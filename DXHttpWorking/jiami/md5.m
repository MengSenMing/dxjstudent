//
//  md5.m
//  登录页面
//
//  Created by mac_mini02 on 14-8-26.
//  Copyright (c) 2014年 mac_mini02. All rights reserved.
//

#import "md5.h"

@implementation md5
+(NSString*)md5WithString:(NSString*)string{
    const char *cStr = [string UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), result);
    NSString* outString=[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                         result[0], result[1], result[2], result[3],
                         result[4], result[5], result[6], result[7],
                         result[8], result[9], result[10], result[11],
                         result[12], result[13], result[14], result[15]
                         ];
    return outString;

}
@end
