//
//  NetWorking.m
//  lazyweek
//
//  Created by 尹成 on 16/6/24.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "NetWorking.h"
#import "AFNetWorking.h"

@implementation NetWorking

static NetWorking *netWorking;
+ (NetWorking *)sharedNetWorking{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        netWorking = [[NetWorking alloc] init];
    });
    return netWorking;
}



- (void)getDataWithUrl:(NSString *)urlString
               Success:(SuccessBlock)success
               Failure:(FailureBlock)failure{
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:YES];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    //异步连接
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:NO];
         NSDictionary *databackDict;
         if (!connectionError)
         {
             databackDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
             success(databackDict);
//             NSLog(@"databackDict:%@",databackDict);
         } else {
             failure(connectionError);
//             NSLog(@"########## connectionError :%@",connectionError);
         }
     }];

}





//-(void)get{
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    
//    NSString *urlString = @"http://api.lanrenzhoumo.com/main/recommend/index/?city_id=0&lat=31.16539&lon=121.3992&page=1&session_id=00004252ee76b1a75988ac676581ee387eeac4&v=3";
//    
//    
//    NSDictionary *dict = [[NSMutableDictionary alloc] init];
//    [dict setValue:@"0" forKey:@"city_id"];
//    [dict setValue:@"31.16539" forKey:@"lat"];
//    [dict setValue:@"121.3992" forKey:@"lon"];
//    [dict setValue:@"1" forKey:@"page"];
//    [dict setValue:@"00004252ee76b1a75988ac676581ee387eeac4" forKey:@"session_id"];
//    [dict setValue:@"3" forKey:@"v"];
//    
//    
//    [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//        
//    }
//         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//             
//             NSLog(@"这里打印请求成功要做的事");
//             
//         }
//     
//         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
//             
//             NSLog(@"%@",error);  //这里打印错误信息
//             
//         }];
//}

@end
