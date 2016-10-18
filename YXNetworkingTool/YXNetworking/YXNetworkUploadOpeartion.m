//
//  YXNetworkUploadOpeartion.m
//  YXNetworkingTool
//
//  Created by Rookie_YX on 16/10/14.
//  Copyright © 2016年 YX_Rookie. All rights reserved.
//

#import "YXNetworkUploadOpeartion.h"
#import "YXNetworkUploadParam.h"

@interface YXNetworkUploadOpeartion ()<NSURLSessionDelegate>

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSURLSessionUploadTask *uploadTask;

@end

@implementation YXNetworkUploadOpeartion

- (instancetype)initWithURL:(NSString *)url params:(NSDictionary *)params uploadParam:(YXNetworkUploadParam *)uploadParam successBlock:(successBlock)successBlock failureBlock:(faildBlock)failureBlock{
  
  self = [super init];
  if (self) {
    DTLog(@"<-------请求url地址%@------>",url);
    DTLog(@"<-------请求参数地址%@------>",params);
    __weak typeof(self)weakSelf = self;
    NSMutableURLRequest *request = [self upload:@"file" filename:uploadParam.fileName mimeType:uploadParam.mimeType data:uploadParam.data parmas:params requestUrl:url];
    request.timeoutInterval = NetTimeoutInterval;
    self.session = [NSURLSession sharedSession];
    self.uploadTask = [self.session uploadTaskWithRequest:request fromData:nil completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
      if (error) {
        DTLog(@"<-------- error %@---------->",error.localizedDescription);
        if (failureBlock) {
          failureBlock(error);
        };
      }
      else
      {
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        DTLog(@"\n\n----请求的返回结果 %@\n",result);
        if (successBlock) {
          successBlock(result);
        }
      }
      // 移除网络任务
      [weakSelf removeNetworkItem];
    }];
    [self.uploadTask resume];
  }
  return self;
}

// 有进度条
-(instancetype)initWithURL:(NSString *)url params:(NSDictionary *)params uploadParam:(YXNetworkUploadParam *)uploadParam progressBlock:(progressBlock)progressBlock successBlock:(successBlock)successBlock failureBlock:(faildBlock)failureBlock{
  
  self = [super init];
  if (self) {
    self.successBlock  = successBlock;
    self.failureBlock  = failureBlock;
    self.progressBlock = progressBlock;
    __weak typeof(self)weakSelf = self;
    DTLog(@"--请求url地址--%@\n",url);
    DTLog(@"----请求参数%@\n",params);
    NSMutableURLRequest *request = [self upload:@"file" filename:uploadParam.fileName mimeType:uploadParam.mimeType data:uploadParam.data parmas:params requestUrl:url];
    request.timeoutInterval = NetTimeoutInterval;
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    self.session  = [NSURLSession sessionWithConfiguration:configuration delegate:weakSelf delegateQueue:[NSOperationQueue mainQueue]];
    DTLog(@"------> %p",self.session );
    self.uploadTask  = [self.session  uploadTaskWithRequest:request fromData:nil completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
      if (error) {
        DTLog(@"---> error-------> %@",error.localizedDescription);
        if (weakSelf.failureBlock) {
          weakSelf.failureBlock(error);
        }
      }else{
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        DTLog(@"\n\n----请求的返回结果 --------> %@\n",result);
        if (weakSelf.successBlock) {
          weakSelf.successBlock(result);
        }
      }
      [weakSelf removeNetworkItem];
    }];
    [ self.uploadTask resume];
  }
  return self;
}

- (void)removeNetworkItem{
  [self.session finishTasksAndInvalidate];
  self.session = nil;
  // 上传完毕后, 取消任务
  if (self.delegate != nil || [self.delegate respondsToSelector:@selector(YXNetworkUploadOperationDidFinished:)]) {
    [self.delegate YXNetworkUploadOperationDidFinished:self];
  }
}

/**
 *  拼接上传的表单内容
 */

- (NSMutableURLRequest*)upload:(NSString *)name filename:(NSString *)filename mimeType:(NSString *)mimeType data:(NSData *)data parmas:(NSDictionary *)params requestUrl:(NSString*)requexstURL{
  
  // 文件上传
  NSURL *url = [NSURL URLWithString:requexstURL];
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
  request.HTTPMethod = @"POST";
  // 设置请求体
  NSMutableData *body = [NSMutableData data];
  ///************** 文件参数 **************///
  // 参数开始标志
  [body appendData:YYencode(@"--YY\r\n")];
  // name : 指定参数名(必须跟服务器端保持一致)
  // filename : 文件名
  NSString *disposition = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", name, filename];
  
  [body appendData:YYencode(disposition)];
  NSString *type = [NSString stringWithFormat:@"Content-Type: %@\r\n",mimeType];
  [body appendData:YYencode(type)];
  
  [body appendData:YYencode(@"\r\n")];
  [body appendData:data];
  [body appendData:YYencode(@"\r\n")];
  
  ///************* 普通参数 ****************///
  [params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
    // 参数开始标志
    [body appendData:YYencode(@"--YY\r\n")];
    NSString *disposition = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n", key];
    [body appendData:YYencode(disposition)];
    [body appendData:YYencode(@"\r\n")];
    [body appendData:YYencode(obj)];
    [body appendData:YYencode(@"\r\n")];
  }];
  
  ///************** 参数结束 **********************///
  [body appendData:YYencode(@"--YY--\r\n")];
  request.HTTPBody = body;
  // 设置请求头
  // 请求体的长度
  [request setValue:[NSString stringWithFormat:@"%zd",body.length] forHTTPHeaderField:@"Content-Length"];
  // 声明这个POST请求是个上传文件
  [request setValue:@"multipart/form-data; boundary=YY"  forHTTPHeaderField:@"Content-Type"];
  
  DTLog(@"<------------ 上传表单内容 ---------->%@",request);
  return request;
}


#pragma mark - NSURLSessionTaskDelegate
/*
 *  上传过程中调用
 *
 *  @param   bytesSent:当前这一次上传的数据大小;
 *  @param   totalBytesSent:总共上传数据大小
 *  @param   totalBytesExpectedToSend:需要上传的文件大小
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend
{
  CGFloat progress = 1.0 * totalBytesSent/totalBytesExpectedToSend;
  if (self.progressBlock) {
    self.progressBlock(progress);
  }
}

@end
