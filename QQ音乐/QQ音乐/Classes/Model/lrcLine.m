//
//  lrcLine.m
//  QQ音乐
//
//  Created by 余亮 on 16/2/28.
//  Copyright © 2016年 余亮. All rights reserved.
//

#import "lrcLine.h"

@implementation lrcLine

- (instancetype) initwithLrcString:(NSString *)LrcString
{
    if (self == [super init]) {
        NSArray * lrcLineArr = [LrcString componentsSeparatedByString:@"]"];
        self.text = lrcLineArr[1];
        self.time = [self timeWithString:[lrcLineArr[0] substringFromIndex:1]];
    }
    return  self ;
}

+ (instancetype) lrcWithLrcString:(NSString *)LrcString
{
    return [[self alloc] initwithLrcString:LrcString];
}


- (NSTimeInterval )timeWithString:(NSString *) timeString
{
    NSArray * timeArr = [timeString componentsSeparatedByString:@":"];
    
    NSInteger min = [timeArr[0] integerValue];
    NSInteger second = [[timeArr[1] componentsSeparatedByString:@"."][0] integerValue];
    NSInteger haomiao = [[timeArr[1] componentsSeparatedByString:@"."][1] integerValue];
    
    return  min*60 + second + haomiao*0.01 ;
    
}


@end
