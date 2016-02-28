//
//  NSString+YLExtension.m
//  QQ音乐
//
//  Created by 余亮 on 16/2/28.
//  Copyright © 2016年 余亮. All rights reserved.
//

#import "NSString+YLExtension.h"

@implementation NSString (YLExtension)

+ (NSString *)timeWithNSInteger:(NSInteger)integer
{
    NSInteger min = integer / 60 ;
    NSInteger second = (NSInteger)integer % 60 ;  //注意：double类型不能 %，故要强转一下
    return   [NSString stringWithFormat:@"%02ld:%02ld",min,second];
}
@end
