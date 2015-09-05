//
//  NSString+AES.m
//  aes加密与解密
//
//  Created by apple on 15-1-7.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "NSString+AES.h"

@implementation NSString (AES)
- (NSString *)encryptAES:(NSString *)key
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [self length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeAES128,
                                          NULL,
                                          [[self dataUsingEncoding:NSUTF8StringEncoding] bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    
    if (cryptStatus == kCCSuccess)
    {
        NSData *aesData = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        return [aesData base64Encoding];
    }
    free(buffer);
    return nil;
}

- (NSString *)decryptAES:(NSString *)key
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [[[NSData alloc] initWithBase64Encoding:self] length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeAES128,
                                          NULL,
                                          [[[NSData alloc] initWithBase64Encoding:self] bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesDecrypted);
    if (cryptStatus == kCCSuccess)
    {
        NSData *aesData = [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
        NSString *resultStr = [[NSString alloc] initWithData:aesData encoding:NSUTF8StringEncoding];
        return resultStr;
    }
    free(buffer);
    return nil;
}
@end
