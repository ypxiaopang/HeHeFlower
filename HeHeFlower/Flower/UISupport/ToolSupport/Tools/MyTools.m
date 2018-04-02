//
//  MyTools.m
//  JulijrP2P
//
//  Created by 韩 立 on 2016/12/25.
//  Copyright © 2016年 聚力金服网络科技有限公司. All rights reserved.
//

#import "MyTools.h"

@implementation MyTools

//获取文字宽高
+ (CGSize)getSizeOfString:(NSString *)string maxWidth:(CGFloat)width maxHeight:(CGFloat)height withFont:(UIFont *)font
{
    CGSize size = [string boundingRectWithSize:CGSizeMake(width, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    return size;
}

// 设置可变字体
+ (void)setAttributedLabel:(UILabel *)label rangeStr:(NSString *)rangeStr color:(UIColor *)color font:(UIFont *)font
{
    if (label.text.length > 0)
    {
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:label.text];
        if (color != nil) {
            [attrString addAttribute:NSForegroundColorAttributeName value:color range:[label.text rangeOfString:rangeStr]];
        }
        if (font != nil) {
            [attrString addAttribute:NSFontAttributeName value:font range:[label.text rangeOfString:rangeStr]];
        };
        label.attributedText = attrString;
    }
}
// 设置可变字体、行距，获取可变字符串
+ (NSMutableAttributedString *)getAttributedWithText:(NSString *)text rangeStr:(NSString *)rangeStr color:(UIColor *)color font:(UIFont *)font lineSpace:(CGFloat)lineSpace
{
    if (text.length > 0)
    {
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:text];
        
        if (color != nil) {
            [attrString addAttribute:NSForegroundColorAttributeName value:color range:[text rangeOfString:rangeStr]];
        }
        if (font != nil) {
            [attrString addAttribute:NSFontAttributeName value:font range:[text rangeOfString:rangeStr]];
        };
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:lineSpace];//调整行间距
        [attrString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
        
        return attrString;
    }else{
        return nil;
    }
}


//字符串转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

// 延时
+ (void)completion:(void (^)(bool finish))completion afterDelay:(CGFloat)delay
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if(completion)
        completion(YES);
    });
}

// 去掉 html字符串中所有标签
+ (NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    
    NSString * text = nil;
    
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    
    html = [html stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    html = [html stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    html = [html stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    
    return html;
}

//金额格式化
+ (NSString *)formatConversion:(double)amount type:(NSInteger)type
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    
    switch (type) {
        case 1:
            [formatter setPositiveFormat:@"###,##0.00元;"];
            break;
        case 2:
            [formatter setPositiveFormat:@"￥###,##0.00;"];
            break;
        default:
            [formatter setPositiveFormat:@"###,##0.00;"];
            break;
    }
    
    return [formatter stringFromNumber:[NSNumber numberWithDouble:amount]];
}

//获取转让状态
+ (NSString *)getDebtStatus:(NSString *)status
{
    if ([status isEqualToString:@"PREAUDITING"]) {
        return @"待审核";
    }
    else if ([status isEqualToString:@"AUCTING"]) {
        return @"立即购买";//转让中
    }
    else if ([status isEqualToString:@"SUCC"]) {
        return @"已售罄";
    }
    else if ([status isEqualToString:@"AUDIT_NOT_THROUGH"]) {
        return @"审核不通过";
    }
    else if ([status isEqualToString:@"FAILED"]) {
        return @"已过期";
    }
    else if ([status isEqualToString:@"INVALID"]) {
        return @"已失效";
    }else{
        return @"已失效";
    }
}

@end
