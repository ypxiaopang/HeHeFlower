//
//  NetWorkConfig.h
//  JulijrP2P
//
//  Created by 韩 立 on 2016/12/25.
//  Copyright © 2016年 聚力金服网络科技有限公司. All rights reserved.
//



#ifndef Shove_NetWorkConfig_h
#define Shove_NetWorkConfig_h

/**
 *  是否开放登录权限
 *
 *  @return 0 不开放  1 开放
 */
#define IS_VISITOR  1

// 升级版本标识符
#define codeNum 2

#define AppleID         @"1286589514"
#define AppDownloadURL  @"https://itunes.apple.com/cn/app/id1286589514?mt=8"

//// url加密key
#define MD5key  @"M453kdiUD5STjsJI"
// 密码加密 key
#define DESkey  @"SrfiSID3r8fSXNy1"
//

//
#define Baseurl   @"http://msapp.hellohehe.com"
//#define Baseurl @"http://192.168.2.75"
//#define Baseurl   @"http://39.104.15.35:8080"
#define BaseImageUrl Baseurl

#define BaseImageUpload [NSString stringWithFormat:@"%@/appController/receive",BaseImageUrl]  //头像上传


#endif
