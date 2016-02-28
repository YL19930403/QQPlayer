//
//  YLPlayingTool.m
//  QQ音乐
//
//  Created by 余亮 on 16/2/28.
//  Copyright © 2016年 余亮. All rights reserved.
//

#import "YLPlayingTool.h"
#import <MJExtension.h>
#import "YLMusic.h"

@implementation YLPlayingTool

//存放所有的歌曲
static NSArray * _musics ;

//记录当前正在播放的歌曲
static YLMusic * _playingMusic ;


+ (void)initialize
{
   _musics = [YLMusic mj_objectArrayWithFilename:@"Musics.plist"];
    //用户如果没有设置过歌曲，给一个默认设置的歌曲
    _playingMusic = _musics[2];
}

//拿到所有的歌曲
+ (NSArray *)musics
{
    return _musics ;
}

//获取当前正在播放的歌曲
+ (YLMusic *)playingMusic
{
    NSInteger index = [_musics indexOfObject:_playingMusic ];
    return _musics[index];
}

//设置当前播放的歌曲
+ (void) setPlayingMusic:(YLMusic *)playingMusic
{
    //设置歌曲
    _playingMusic = playingMusic ;
    
}


//取出上一首歌曲
+ (YLMusic *)PreviousMusic
{
   //1.取得当前歌曲的下标值
    NSInteger currIndex = [_musics indexOfObject:_playingMusic];
    //2.计算上一个歌曲的下标
    NSInteger previousIndex = currIndex - 1 ;
    if (previousIndex < 0) {
        previousIndex = _musics.count -1 ;
    }
    //3. 取出上一个歌曲
    return  [_musics objectAtIndex:previousIndex];
}


//取出下一首歌曲
+ (YLMusic *)NextMusic
{
    //1.取得当前歌曲的下标值
    NSInteger currIndex = [_musics indexOfObject:_playingMusic];
    //2.计算下一个歌曲的下标
    NSInteger NextIndex = currIndex + 1 ;
    if (NextIndex > _musics.count-1) {
        NextIndex = 0 ;
    }
    //3. 取出下一个歌曲
    return  [_musics objectAtIndex:NextIndex];
}

@end










