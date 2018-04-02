//
//  TimeChangeTools.m
//  JulijrP2P
//
//  Created by 韩 立 on 2016/12/25.
//  Copyright © 2016年 聚力金服网络科技有限公司. All rights reserved.
//

#import "TimeChangeTools.h"

@implementation TimeChangeTools

+ (NSString *)timeFormatterWithTime:(NSString *)str{
	NSTimeInterval interval=[str doubleValue] / 1000.0;
	NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
	NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
	[objDateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	NSString *currentTime = [NSString stringWithFormat:@"%@",[objDateformat stringFromDate: date]];
	return currentTime;
}

+ (NSString *)customTimeFormatterWithTime:(NSString *)str andFormat:(NSString *)format{
    NSTimeInterval interval=[str doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:format];
    NSString *currentTime = [NSString stringWithFormat:@"%@",[objDateformat stringFromDate: date]];
    return currentTime;
}

+ (NSString *)shortTimeFormatterWithTime:(NSString *)str{
	NSString *currentTime = [self timeFormatterWithTime:str];
	NSString *shortTime = [currentTime substringWithRange:NSMakeRange(2, 8)];
	NSString *newTime = [shortTime stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
	return newTime;
}

+ (NSString *)longTimeFormatterWithTime:(NSString *)str{
	NSString *currentTime = [self timeFormatterWithTime:str];
	NSString *longTime = [currentTime substringFromIndex:2];
	NSString *newTime = [longTime stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
	return newTime;
}

+ (NSString *)agoTimeForematterWithTime:(NSString *)str{
	// 获取当前时时间戳
	NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
	// 创建获取的时间戳
	NSTimeInterval createTime = [str doubleValue] / 1000.0;
	// 时间差
	NSTimeInterval time = currentTime - createTime;
	
	// 秒转秒
	NSInteger secends = time;
	if (secends < 60) {
		return [NSString stringWithFormat:@"%ld秒前",secends];
	}
	// 秒转分钟
	NSInteger minutes = time/60;
	if (minutes < 60) {
		return [NSString stringWithFormat:@"%ld分钟前",minutes];
	}
	// 秒转小时
	NSInteger hours = time/3600;
	if (hours<24) {
		return [NSString stringWithFormat:@"%ld小时前",hours];
	}
	//秒转天数
	NSInteger days = time/3600/24;
	if (days < 30) {
		return [NSString stringWithFormat:@"%ld天前",days];
	}
	//秒转月
	NSInteger months = time/3600/24/30;
	if (months < 12) {
		return [NSString stringWithFormat:@"%ld月前",months];
	}
	//秒转年
	NSInteger years = time/3600/24/30/12;
	return [NSString stringWithFormat:@"%ld年前",years];
}


//与当前时间对比，获取两个时间戳的相隔时间
+ (NSTimeInterval)getIntervalTimeWithValue:(long long)timeValue
{
    // 获取当前时时间戳
    NSTimeInterval currentTime = (long)[[NSDate date] timeIntervalSince1970];
    // 创建获取的时间戳
    NSTimeInterval createTime = timeValue / 1000.0;
    // 时间差
    NSTimeInterval intervalTime = currentTime - createTime;
    
    return intervalTime;
}

@end
