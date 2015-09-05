//
//  MSHttpRequestManager.h
//  自制相册模板
//
//  Created by miaofangwang on 15/8/25.
//  Copyright (c) 2015年 zilujiaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class MSHttpRequestManager;

//定义请求成功的block变量
typedef void(^httpRequestSuccess)(MSHttpRequestManager *manager,id model);
//定义请求失败的block变量
typedef void(^httpRequestFailure)(MSHttpRequestManager *manager,id  model);


@interface MSHttpRequestManager : NSObject
//单例
+ (MSHttpRequestManager *)shareManager;

//手机登录
-(void)loginByMobile:(NSString*)mobile andPlainPassword:(NSString *)plainPassword success:(httpRequestSuccess)success andFailure:(httpRequestFailure)failure;

//音频上传
- (void)uploadVoiceWithBase64String:(NSString *)base64String fileName:(NSString *)fileName folder:(NSString *)folder success:(httpRequestSuccess)success andFailure:(httpRequestFailure)failure;

//发送验证码
- (void)loadMsgCodeByMobile:(NSString *)mobile success:(httpRequestSuccess)success andFailure:(httpRequestFailure)failure;

//验证验证码是否正确
- (void)checkMsgCodeByMobile:(NSString *)mobile andCode:(NSString *)code success:(httpRequestSuccess)success andFailure:(httpRequestFailure)failure;

//注册
- (void)registerByMobile:(NSString *)mobile andPlainPassword:(NSString *)plainPassword success:(httpRequestSuccess)success andFailure:(httpRequestFailure)failure;

@end
