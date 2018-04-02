//
//  VersionUpdate.h
//  JulijrP2P
//
//  Created by 韩 立 on 2016/12/25.
//  Copyright © 2016年 聚力金服网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol VersionUpdateDelegate <NSObject>

- (void)checkAppVersion:(NSString *)version updateType:(BOOL)updateType updatecontent:(NSString *)content updateName:(NSString *)versionName;



@end

@interface VersionUpdate : NSObject<HTTPClientDelegate>

+ (instancetype)sharedInstance;
/*平台检查更新*/
- (void)checkUpdateWithDelegate:(id<VersionUpdateDelegate>)delegate;

/*通过itunes检查更新*/
- (void)appStoreCheckUpdate;

/*APP版本号比较*/
- (void)compareVersion:(NSString *)newVersion updateType:(BOOL)updateType updatecontent:(NSString *)updatecontent updateName:(NSString *)versionName;


@end
