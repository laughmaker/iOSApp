//
//  VCModel.h
//  TWApp
//
//  Created by line0 on 13-7-8.
//  Copyright (c) 2013年 makeLaugh. All rights reserved.
//

/*
 *控制器Model，用作数据请求、计算处理等，这里定义一个模板，子类继承来实现具体功能，如果是简单的操作，也可不具体化子类，直接操作本类
 */

#import <Foundation/Foundation.h>

@interface VCModel : NSObject

//网络请求方法，默认为POST
@property (copy, nonatomic) NSString *httpMethod;

- (void)requestDataWithParams:(NSDictionary *)params
                      forPath:(NSString *)path
                     finished:(TWFinishedBlock)finished
                       failed:(TWFailedBlock)failed;

//下载文件,hostName为主站点名。
- (void)downloadFileWithFilePath:(NSString *)filePath
                        hostName:(NSString *)hostName
                      toSavePath:(NSString *)savePath
                        finished:(TWFinishedBlock)finished
                          failed:(TWFailedBlock)failed;

//上传文件，path为要上传的接口，photoKey为后台设定的关键字，fileName为自行设定的文件名。
- (void)upLoadFile:(NSData *)fileData
          hostName:(NSString *)hostName
              path:(NSString *)path
          photoKey:(NSString *)photoKey
          fileName:(NSString *)fileName
          finished:(TWFinishedBlock)finished
            failed:(TWFailedBlock)failed;

@end
