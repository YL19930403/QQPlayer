//
//  YLPlayingTool.h
//  QQ音乐
//
//  Created by 余亮 on 16/2/28.
//  Copyright © 2016年 余亮. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YLMusic ;
@interface YLPlayingTool : NSObject

+ (NSArray *)musics ;

+ (YLMusic *)playingMusic ;

+ (void) setPlayingMusic:(YLMusic *)playingMusic ;

@end
