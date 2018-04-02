//
//  NSString+Sign.h
//  mashine
//
//  Created by 韩 立 on 2017/7/14.
//  Copyright © 2017年 迈世集团. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Sign)

+ (NSString *)decodeSign:(NSString *)sign action:(NSString *)action;

+ (NSString *)addSign:(NSInteger)kId action:(NSString *)action;

+ (NSDateFormatter *)dateFormatter;

@end
