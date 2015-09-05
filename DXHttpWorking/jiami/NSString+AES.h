//
//  NSString+AES.h
//  aes加密与解密
//
//  Created by apple on 15-1-7.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <commoncrypto/CommonCryptor.h>
@interface NSString (AES)
- (NSString *)encryptAES:(NSString *)key;//加密

- (NSString *)decryptAES:(NSString *)key;//解密
@end
