//
//  HPApiSender.m
//  HP_iOS_CommonFrame
//
//  Created by 秦正华 on 2017/8/24.
//  Copyright © 2017年 zhijianshangcheng. All rights reserved.
//

#import "HPApiSender.h"

#define sender [HPApiSender shareApiSender]

@implementation HPApiSender

+(instancetype)shareApiSender{
    
    static HPApiSender *ApiSender;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        ApiSender =[[HPApiSender alloc]init];

    });
    
    return ApiSender;
}

+ (void)commit:(sendBlock)commit finished:(finishedBlock)finished
{
    HPRequestParameter *request = [[HPRequestParameter alloc] init];
    
    !commit ? : commit(request);

    !request.contentView ? : [HPProgressHUD showLoading:nil inView:request.contentView];
    
    switch (request.type) {
            
        case HPHttpRequestTypeGet:
        {
            [HPNetManager GETWithUrlString:request.url isNeedCache:request.isNeedCache parameters:request.parameter successBlock:^(id response) {
                
                [HPProgressHUD hide];
                
                //TODO:接口请求成功,后台返回error信息的判定
                if ([response[@"error"] intValue] != 0) {
                    !request.contentView ? : [HPProgressHUD showMessage:response[@"info"] inView:request.contentView];
                    return ;
                }

                //TODO:请求成功,回调数据
                finished(response);
                
            } failureBlock:^(NSError *error) {
                [HPProgressHUD hide];
                
                !request.contentView ? : [HPProgressHUD showMessage:@"网络好像出问题了,或者接口无法访问" inView:request.contentView];

            } progressBlock:nil];
        }
            break;
            
        case HPHttpRequestTypePost:
        {
            [HPNetManager POSTWithUrlString:request.url isNeedCache:request.isNeedCache parameters:request.parameter successBlock:^(id response) {
                
                [HPProgressHUD hide];
                
                //TODO:接口请求成功,后台返回error信息的判定
                if ([response[@"error"] intValue] != 0) {
                    !request.contentView ? : [HPProgressHUD showMessage:response[@"info"] inView:request.contentView];
                    return ;
                }

                //TODO:请求成功,回调数据
                finished(response);
                
            } failureBlock:^(NSError *error) {
                
                [HPProgressHUD hide];
                
                !request.contentView ? : [HPProgressHUD showMessage:@"网络好像出问题了,或者接口无法访问" inView:request.contentView];
                
            } progressBlock:nil];
        }
            break;
            
        default:
            break;
    }
}


+ (void)commit:(sendBlock)commit success:(successBlock)success failure:(failureBlock)failure
{
    HPRequestParameter *request = [[HPRequestParameter alloc] init];
    
    !commit ? : commit(request);
    
    !request.contentView ? : [HPProgressHUD showLoading:nil inView:request.contentView];
    
    switch (request.type) {
            
        case HPHttpRequestTypeGet:
        {
            [HPNetManager GETWithUrlString:request.url isNeedCache:request.isNeedCache parameters:request.parameter successBlock:^(id response) {
                
                [HPProgressHUD hide];
                
                //TODO:请求成功,回调数据
                success(response,[response[@"error"] intValue]);
                
                //TODO:接口请求成功,后台返回error信息的判定
                if ([response[@"error"] intValue] != 0) {
                    request.errorInfo = response[@"info"];
                    request.status = HPRequestResultReturnError;
                    return ;
                }
                request.status = HPRequestResultSuccess;
                
            } failureBlock:^(NSError *error) {
                [HPProgressHUD hide];
                request.status = HPRequestResultNoNet;
                failure(request.reconnectView,error);
                
            } progressBlock:nil];
        }
            break;
            
        case HPHttpRequestTypePost:
        {
            [HPNetManager POSTWithUrlString:request.url isNeedCache:request.isNeedCache parameters:request.parameter successBlock:^(id response) {
                
                [HPProgressHUD hide];
                
                //TODO:请求成功,回调数据
                success(response,[response[@"error"] intValue]);
                
                //TODO:接口请求成功,后台返回error信息的判定
                if ([response[@"error"] intValue] != 0) {
                    request.errorInfo = response[@"info"];
                    request.status = HPRequestResultReturnError;
                    return ;
                }
                request.status = HPRequestResultSuccess;

            } failureBlock:^(NSError *error) {
                
                [HPProgressHUD hide];
                request.status = HPRequestResultNoNet;
                failure(request.reconnectView,error);
                
            } progressBlock:nil];
        }
            break;
            
        default:
            break;
    }
}



@end
