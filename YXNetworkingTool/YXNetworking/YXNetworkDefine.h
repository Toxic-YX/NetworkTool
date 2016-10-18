//
//  YXNetworkDefine.h
//  YXNetworkingTool
//
//  Created by Rookie_YX on 16/10/14.
//  Copyright © 2016年 YX_Rookie. All rights reserved.
//

#ifndef YXNetworkDefine_h
#define YXNetworkDefine_h

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
typedef void (^successBlock)(id result);

typedef void (^faildBlock)(NSError *error);

typedef void (^progressBlock)(CGFloat progress);

/// 请求类型
typedef enum{
    YXNetworkTypeGET = 1,  // GET
    YXNetWorkTypePOST      // POST
}YXNetworkType;

/// 打印
#ifdef DEBUG
// DEBUG模式下进行调试打印

// 输出结果标记出所在类方法与行数
#define DTLog(fmt, ...)   NSLog((@"\n%s[Line: %d]™ ->" fmt), strrchr(__FUNCTION__,'['), __LINE__, ##__VA_ARGS__)

#else

#define DTLog(...)   {}

#endif

/// 请求限制时长
#define NetTimeoutInterval 30.0f
/// 字符串转化成data
#define YYencode(string) [string dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]


//  __weak  __strong

/**
 Synthsize a weak or strong reference.
 
 Example:
 @weakify(self)
 [self doSomething^{
 @strongify(self)
 if (!self) return;
 ...
 }];
 
 */
#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif

#endif /* YXNetworkDefine_h */
