//
//  YXNetworkManager.m
//  YXNetworkingTool
//
//  Created by Rookie_YX on 16/10/14.
//  Copyright © 2016年 YX_Rookie. All rights reserved.
//  管理类

#import "YXNetworkManager.h"
#import "YXNetworkUploadOpeartion.h"

@interface YXNetworkManager ()<YXNetworkUploadOpeartionDelegate>
@property (nonatomic, strong) NSOperationQueue *networkInteQueue; // 网络任务进程
@property (nonatomic, strong) NSMutableArray   *networkBuffer;  // 任务operation的数组集合
@property (nonatomic, assign) BOOL             networkEnable;  // 默认为 YES

@end
@implementation YXNetworkManager

#pragma mark - 单例
+ (instancetype)shareManager{
  
  static YXNetworkManager *_manager = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _manager = [[super alloc] init];
    _manager.networkEnable = YES;
  });
  return _manager;
}

#pragma mark -  GET POST 请求
/**
 *  GET 请求
 */
+ (void)getRequestWithURL:(NSString *)url params:(NSDictionary *)params success:(successBlock)successBlock faildBlock:(faildBlock)failureBlock{
  
  YXNetworkManager *manager = [YXNetworkManager shareManager];
  YXNetworkOperation *operation = [self connectURL:url networkType:YXNetworkTypeGET params:params success:successBlock faildBlock:failureBlock];
  [manager.networkInteQueue addOperation:operation];
}

/**
 *  POST 请求
 */
+ (void)postRequestWithURL:(NSString *)url params:(NSDictionary *)params success:(successBlock)successBlock faildBlock:(faildBlock)failureBlock{
  
  YXNetworkManager * manager = [YXNetworkManager shareManager];
  YXNetworkOperation *operation = [self connectURL:url networkType:YXNetWorkTypePOST params:params success:successBlock faildBlock:failureBlock];
  [manager.networkInteQueue addOperation:operation];
}

/**
 *   下载Queue队列,下载任务对象
 */
+ (YXNetworkOperation*)connectURL:(NSString *)url networkType:(YXNetworkType)networkType params:(NSDictionary*)params success:(successBlock)successBlock
  faildBlock:(faildBlock)failureBlock{
  
  YXNetworkOperation *operation = [[YXNetworkOperation alloc] initWithtype:networkType url:url params:params successBlock:successBlock failureBlock:failureBlock];
  return operation;
}

#pragma mark - 图片上传
/**
 *  上传图片不带进度条
 */
+ (void)uploadFileWithURL:(NSString *)url params:(NSDictionary *)params uploadParam:(YXNetworkUploadParam *)uploadParam successBlock:(successBlock)successBlock failureBlock:(faildBlock)failureBlock{
  
  YXNetworkManager *manager = [YXNetworkManager shareManager];
  YXNetworkUploadOpeartion *operation = [[YXNetworkUploadOpeartion alloc] initWithURL:url params:params uploadParam:uploadParam successBlock:successBlock failureBlock:failureBlock];
  [manager.networkInteQueue addOperation:operation];
}

/**
 *  上传图片带进度条
 */
+ (void)uploadFileWithURL:(NSString *)url params:(NSDictionary *)params uploadParam:(YXNetworkUploadParam *)uploadParam progressBlock:(progressBlock)progressBlock successBlock:(successBlock)successBlock failureBlock:(faildBlock)failureBlock{
  
  YXNetworkManager *manager = [YXNetworkManager shareManager];
  YXNetworkUploadOpeartion *operation = [[YXNetworkUploadOpeartion alloc] initWithURL:url params:params uploadParam:uploadParam progressBlock:progressBlock successBlock:successBlock failureBlock:failureBlock];
  [manager.networkInteQueue addOperation:operation];
}

#pragma mark - 取消请求任务
/**
 *  取消所有的网络请求任务
 */
+ (void)cancelAllOperations{
  YXNetworkManager *manage = [YXNetworkManager shareManager];
  [manage.networkInteQueue cancelAllOperations];
}

#pragma mark - YXNetworkUploadOpeartionDelegate
/**
 *  带上传进度的operation完成上传后,需要将任务从缓存的数组里移除
 */
- (void)YXNetworkUploadOperationDidFinished:(YXNetworkUploadOpeartion *)operation{
  
  YXNetworkManager *maneger = [YXNetworkManager shareManager];
  [maneger.networkBuffer removeObject:operation];
}

#pragma mark - getting 
- (NSOperationQueue *)networkInteQueue{
  
  if (!_networkInteQueue) {
    _networkInteQueue = [[NSOperationQueue alloc] init];
    _networkInteQueue.maxConcurrentOperationCount = 5;
  }
  return _networkInteQueue;
}

- (NSMutableArray *)networkBuffer{
  
  if (!_networkBuffer) {
    _networkBuffer = [NSMutableArray array];
  }
  return _networkBuffer;
}

@end
