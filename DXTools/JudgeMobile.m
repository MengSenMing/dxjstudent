//
//  JudgeMobile.m
//  ihome
//
//  Created by apple on 15/5/11.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "JudgeMobile.h"

@implementation JudgeMobile

+ (JudgeMobile *)shareJudge
{
    static JudgeMobile *shareInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        shareInstance = [[JudgeMobile alloc]init];
    });
    return shareInstance;
}

//账号－－手机号码判断
-(BOOL) isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    //NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSString *phoneRegex = @"^((13[0-9])|(14[0,0-9])|(15[0-9])|(18[0,0-9])|(17[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:mobile];
}

//密码－－字母与数字   6-－14位
-(BOOL) isValidatePsd:(NSString *)psd{
    
    NSString * regex = @"^[A-Za-z0-9]{6,14}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:psd];

}

//输入框 - - 无特殊字符，只能输入中文，英文，数字
- (BOOL) isNoSpecialChar:(NSString *)str
{
    NSString *regex = @"[a-zA-Z\u4e00-\u9fa5][a-zA-Z0-9\u4e00-\u9fa5]+";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:str];
}

@end
