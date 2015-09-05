//
//  MSHttpRequestManager.m
//  自制相册模板
//
//  Created by miaofangwang on 15/8/25.
//  Copyright (c) 2015年 zilujiaoyu. All rights reserved.
//

#import "MSHttpRequestManager.h"
#import "AFHTTPRequestOperationManager.h"
#import "DXNetInterface.h"
#import "udid.h"
#import "md5.h"
#import "SBJsonWriter.h"
#import "NSString+AES.h"

@implementation MSHttpRequestManager

#pragma mark - 单例
+ (MSHttpRequestManager *)shareManager
{
    static MSHttpRequestManager *shareInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        shareInstance = [[MSHttpRequestManager alloc]init];
    });
    return shareInstance;
}
//得到uuid
-(NSString*)getUuid{
    return [udid getUniqueIdentifier];
}

//得到md5字符串
-(NSString*)getmd5String{
    NSString* imei=[self getUuid];
    NSString* md5Str=[md5 md5WithString:[NSString stringWithFormat:@"%@%@%@%@",PHONE_TYPE,imei,VERSION_CODE,APPKEY]];
    return md5Str;
}
//得到公共的参数
-(NSMutableDictionary*)commonDictionary{
    NSString* imei=[self getUuid];
    NSString* deviceType=PHONE_TYPE;
    NSString* version_code=VERSION_CODE;
    NSMutableDictionary* commonDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:imei,@"imei",deviceType,@"deviceType",version_code,@"version_code", nil];
    return commonDic;
}

//得到学生请求地址
-(NSString*)getPathByCmd:(NSString*)cmd{
    NSString* path=[NSString stringWithFormat:@"%@/%@",STUDENT_DOMIN,cmd];
    return path;
}
//得到公共请求地址
-(NSString*)getCommonPathByCmd:(NSString*)cmd{
    NSString* path=[NSString stringWithFormat:@"%@/%@",COMMON_DOMIN,cmd];
    return path;
}


//Json解析
-(NSString*)getDic:(NSMutableDictionary*)dic{
    SBJsonWriter* writer=[[SBJsonWriter alloc]init];
    NSString* jsonString=[writer stringWithObject:dic];
    return jsonString;
}
//创建manager对象
-(AFHTTPRequestOperationManager*)getManager{
    AFHTTPRequestOperationManager* manager=[AFHTTPRequestOperationManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval=10.0;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    return manager;
}

//手机登录
-(void)loginByMobile:(NSString*)mobile andPlainPassword:(NSString *)plainPassword success:(httpRequestSuccess)success andFailure:(httpRequestFailure)failure
{
    NSString* cmd=@"login";
    NSMutableDictionary* dataDictionary=[self commonDictionary];
    [dataDictionary setObject:cmd forKey:@"cmd"];
    
    [dataDictionary setObject:mobile forKey:@"mobile"];
    [dataDictionary setObject:[plainPassword encryptAES:ENCRYPTION_KEY] forKey:@"plainPassword"];
    NSString *deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"];
    if (deviceToken) {
        [dataDictionary setObject:deviceToken forKey:@"deviceTokens"];
    }
    
    NSDictionary* dic=@{@"md5":[self getmd5String],@"transData":[self getDic:dataDictionary]};
    NSLog(@"dic===%@",dic);
    
    [[self getManager] POST:[self getPathByCmd:cmd] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject手机登录=== %@",responseObject);
        NSLog(@"msg== %@",responseObject[@"msg"]);
        if ([responseObject[@"code"]integerValue] == 0) {
            success(self,responseObject);
        }else{
            failure(self,responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"登录失败error==%@",[error localizedDescription]);
        failure(self,error);
    }];
}

//音频上传
- (void)uploadVoiceWithBase64String:(NSString *)base64String fileName:(NSString *)fileName folder:(NSString *)folder success:(httpRequestSuccess)success andFailure:(httpRequestFailure)failure
{
    NSString* cmd=@"uploadVoice";
    NSMutableDictionary* dataDictionary=[self commonDictionary];
    [dataDictionary setObject:cmd forKey:@"cmd"];
    
    [dataDictionary setObject:base64String forKey:@"base64String"];
    [dataDictionary setObject:fileName forKey:@"fileName"];
    [dataDictionary setObject:folder forKey:@"folder"];
    
    NSDictionary* dic=@{@"md5":[self getmd5String],@"transData":[self getDic:dataDictionary]};
    NSString* path=[NSString stringWithFormat:@"%@/%@",PICTURE_PUBLIC_DOMIN,cmd];
    path=[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[self getManager] POST:path parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject音频上传=== %@",responseObject);
        NSLog(@"msg== %@",responseObject[@"msg"]);
        if ([responseObject[@"code"]integerValue] == 0) {
            success(self,responseObject);
        }else{
            failure(self,responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"登录失败error==%@",[error localizedDescription]);
        failure(self,error);
    }];

}

//发送验证码
- (void)loadMsgCodeByMobile:(NSString *)mobile success:(httpRequestSuccess)success andFailure:(httpRequestFailure)failure
{
    NSString* cmd=@"loadMsgCode";
    NSMutableDictionary* dataDictionary=[self commonDictionary];
    [dataDictionary setObject:cmd forKey:@"cmd"];
    [dataDictionary setObject:mobile forKey:@"mobile"];
    NSDictionary* dic=@{@"md5":[self getmd5String],@"transData":[self getDic:dataDictionary]};
    
    [[self getManager] POST:[self getPathByCmd:cmd] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject验证码发送 === %@",responseObject);
        NSLog(@"msg== %@",responseObject[@"msg"]);
        if ([responseObject[@"code"]integerValue] == 0) {
            success(self,responseObject);
        }else{
            failure(self,responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"验证码发送失败error==%@",[error localizedDescription]);
        failure(self,error);
    }];
}

//验证验证码是否正确
- (void)checkMsgCodeByMobile:(NSString *)mobile andCode:(NSString *)code success:(httpRequestSuccess)success andFailure:(httpRequestFailure)failure
{
    NSString* cmd=@"checkMsgCode";
    NSMutableDictionary* dataDictionary=[self commonDictionary];
    [dataDictionary setObject:cmd forKey:@"cmd"];
    [dataDictionary setObject:mobile forKey:@"mobile"];
    [dataDictionary setObject:code forKey:@"code"];
    
    NSDictionary* dic=@{@"md5":[self getmd5String],@"transData":[self getDic:dataDictionary]};
    
    [[self getManager] POST:[self getPathByCmd:cmd] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject验证码验证 === %@",responseObject);
        NSLog(@"msg== %@",responseObject[@"msg"]);
        if ([responseObject[@"code"]integerValue] == 0) {
            success(self,responseObject);
        }else{
            failure(self,responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"验证码验证失败error==%@",[error localizedDescription]);
        failure(self,error);
    }];
}

//注册
- (void)registerByMobile:(NSString *)mobile andPlainPassword:(NSString *)plainPassword success:(httpRequestSuccess)success andFailure:(httpRequestFailure)failure
{
    NSString* cmd=@"register";
    NSMutableDictionary* dataDictionary=[self commonDictionary];
    [dataDictionary setObject:cmd forKey:@"cmd"];
    [dataDictionary setObject:mobile forKey:@"mobile"];
    [dataDictionary setObject:[plainPassword encryptAES:ENCRYPTION_KEY] forKey:@"plainPassword"];
    NSDictionary* dic=@{@"md5":[self getmd5String],@"transData":[self getDic:dataDictionary]};
    
    [[self getManager] POST:[self getPathByCmd:cmd] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject注册 === %@",responseObject);
        NSLog(@"msg== %@",responseObject[@"msg"]);
        if ([responseObject[@"code"]integerValue] == 0) {
            success(self,responseObject);
        }else{
            failure(self,responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"注册失败error==%@",[error localizedDescription]);
        failure(self,error);
    }];
}

@end
