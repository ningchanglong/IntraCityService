//
//  TransformMandarinLatin.m
//  CitySelection
//
//  Created by ioi on 16/9/18.
//  Copyright © 2016年 ningchanglong. All rights reserved.
//

#import "TransformMandarinLatin.h"

@implementation TransformMandarinLatin
+ (NSString *)transform:(NSString *)chinese{
    //将NSString装换成NSMutableString
    NSMutableString *mpinyin = [chinese mutableCopy];
    
    //将汉字转换为拼音(带音标)
    CFStringTransform((__bridge CFMutableStringRef)mpinyin, NULL, kCFStringTransformMandarinLatin, NO);
//    NSLog(@"%@", pinyin);
    
    //去掉拼音的音标
    CFStringTransform((__bridge CFMutableStringRef)mpinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
//    NSLog(@"%@", pinyin);
    
   NSString *pinyin = [mpinyin stringByReplacingOccurrencesOfString:@" " withString:@""];
//    NSLog(@"----%@",str);
    //返回最近结果
    return pinyin;
    
}

+ (NSArray *)transformArr:(NSArray *)chineseArr
{
    NSMutableArray *marray = [[NSMutableArray alloc] init];
    for (NSString *str in chineseArr) {
        NSString *pinyin = [self transform:str];
        [marray addObject:pinyin];
    }
    return marray;
}
@end
