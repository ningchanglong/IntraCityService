//
//  TransformMandarinLatin.h
//  CitySelection
//
//  Created by ioi on 16/9/18.
//  Copyright © 2016年 ningchanglong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TransformMandarinLatin : NSObject
+ (NSString *)transform:(NSString *)chinese;
+ (NSArray *)transformArr:(NSArray *)chineseArr;
@end
