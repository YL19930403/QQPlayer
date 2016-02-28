//
//  lrcTool.m
//  QQ音乐
//
//  Created by 余亮 on 16/2/28.
//  Copyright © 2016年 余亮. All rights reserved.
//

#import "lrcTool.h"
#import "lrcLine.h"

@implementation lrcTool

+ (NSMutableArray *)lrcToolWithLrcName:(NSString *)lrcName
{
    //解析歌词
      //1.获取歌词的路径
    NSString * filePath = [[NSBundle mainBundle] pathForResource:lrcName ofType:nil];
      //2.读取该文件中的歌词
    NSString * lrcStr = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
       //3.获取歌词的数组
    NSArray * lrcArr = [lrcStr componentsSeparatedByString:@"\n"];
    
       //4.将一句歌词转成模型对象，放到一个数组中
    NSMutableArray * tempArr = [NSMutableArray array];
    for (NSString * lrcStr in lrcArr) {
          //过滤不需要的歌词的行
        if ([lrcStr hasPrefix:@"[ti:"] || [lrcStr hasPrefix:@"[ar:"] || [lrcStr hasPrefix:@"[al:"] || ![lrcStr hasPrefix:@"["]) {
            continue ;
        }
        //解析每一句歌词转成模型对象
        lrcLine * lrc = [lrcLine lrcWithLrcString:lrcStr];
        [tempArr addObject:lrc];
    }
    return  tempArr;
}

@end
