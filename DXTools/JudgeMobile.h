//
//  JudgeMobile.h
//  ihome
//
//  Created by apple on 15/5/11.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JudgeMobile : NSObject

//单例
+ (JudgeMobile *)shareJudge;

//账号－－手机号码判断
-(BOOL) isValidateMobile:(NSString *)mobile;
//密码－－字母与数字   6-－14位
-(BOOL) isValidatePsd:(NSString *)psd;

//输入框 - - 无特殊字符，只能输入中文，英文，数字
- (BOOL) isNoSpecialChar:(NSString *)str;

@end
