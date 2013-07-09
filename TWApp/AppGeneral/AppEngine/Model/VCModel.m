//
//  VCModel.m
//  TWApp
//
//  Created by line0 on 13-7-8.
//  Copyright (c) 2013年 makeLaugh. All rights reserved.
//

#import "VCModel.h"

@implementation VCModel

- (id)init
{
    self = [super init];
    if (self)
    {
        self.httpMethod = @"POST";
    }
    return self;
}

- (void)requestDataWithParams:(NSDictionary *)params
                      forPath:(NSString *)path
                     finished:(TWFinishedBlock)finished
                       failed:(TWFailedBlock)failed
{
    MKNetworkEngine *networkEngine = appDelegate().networkEngine;
    MKNetworkOperation *operation = [networkEngine operationWithPath:path
                                                              params:params
                                                          httpMethod:self.httpMethod];
    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation)
     {
         NSDictionary *resultDict = completedOperation.responseJSON;
         if (completedOperation.HTTPStatusCode == 200)
         {             
             if ([resultDict[@"code"] integerValue] == TWSucceed)
             {
                 finished(resultDict);
             }
             else if ([resultDict[@"code"] integerValue] == TWNeedLogin)
             {
                 [mNotificationCenter postNotificationName:kReLoginNotification object:nil];
             }
             else
             {
                 [[MessageStatusBar sharedInstance] updateMessage:resultDict[@"msg"]];
                 [[MessageStatusBar sharedInstance] hideAfterDelay:3];
                 
                 failed(resultDict[@"msg"]);
             }
         }
         else
         {
             failed(resultDict[@"msg"]);
         }
     }
                       errorHandler:^(MKNetworkOperation *completedOperation, NSError *error)
     {
         mAlertView(@"网络错误", error.localizedDescription);
     }];
    [networkEngine enqueueOperation:operation];
}

- (void)downloadFileWithFilePath:(NSString *)filePath
                        hostName:(NSString *)hostName
                      toSavePath:(NSString *)savePath
                        finished:(TWFinishedBlock)finished
                          failed:(TWFailedBlock)failed
{
    MKNetworkEngine *networkEngine = [[MKNetworkEngine alloc] initWithHostName:hostName];
    NSOutputStream *outputStream = [NSOutputStream outputStreamToFileAtPath:savePath append:YES];
    
    MKNetworkOperation *operation = [networkEngine operationWithPath:filePath
                                                              params:nil
                                                          httpMethod:@"GET"];
    [operation addDownloadStream:outputStream];
    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation)
     {
         if (completedOperation.HTTPStatusCode == 200)
         {
             finished(nil);
         }
         else
         {
             failed(nil);
         };
     }
                       errorHandler:^(MKNetworkOperation *completedOperation, NSError *error)
     {
         mAlertView(@"网络错误", error.localizedDescription);
     }];
    [networkEngine enqueueOperation:operation];
}

- (void)upLoadFile:(NSData *)fileData
          hostName:(NSString *)hostName
              path:(NSString *)path
          photoKey:(NSString *)photoKey
          fileName:(NSString *)fileName
          finished:(TWFinishedBlock)finished
            failed:(TWFailedBlock)failed
{
    MKNetworkEngine *networkEngine = [[MKNetworkEngine alloc] initWithHostName:hostName];
    MKNetworkOperation *operation = [networkEngine operationWithPath:path
                                                              params:nil
                                                          httpMethod:@"POST"];
    NSString *mimeType = [NSData contentTypeForImageData:fileData];
    [operation addData:fileData forKey:photoKey mimeType:mimeType fileName:fileName];
    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation)
     {
         NSDictionary *resultDict = completedOperation.responseJSON;
         if (completedOperation.HTTPStatusCode == 200)
         {
             if ([resultDict[@"code"] integerValue] == TWSucceed)
             {
                 finished(nil);
             }
             else
             {
                 failed(nil);
             }
         }
         else
         {
             failed(nil);
         }
     }
                       errorHandler:^(MKNetworkOperation *completedOperation, NSError *error)
     {
         mAlertView(@"网络错误", error.localizedDescription);
     }];
    [networkEngine enqueueOperation:operation];
}


@end
