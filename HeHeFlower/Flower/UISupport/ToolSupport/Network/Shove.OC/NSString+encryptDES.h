//
//  NSString+encryptDES.h
//  mashine
//
//  Created by 韩 立 on 2017/7/14.
//  Copyright © 2017年 迈世集团. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>
#import "ConverUtil.h"

@interface NSString (encryptDES)

+ (NSString *)encrypt3DES:(NSString *)src key:(NSString *)key;
+ (NSString *)decrypt3DES:(NSString *)src key:(NSString *)key;

@end
