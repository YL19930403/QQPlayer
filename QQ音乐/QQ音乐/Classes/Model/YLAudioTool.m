//
//  YLAudioTool.m
//  03播放音效抽取工具类
//
//  Created by 余亮 on 16/2/27.
//  Copyright © 2016年 余亮. All rights reserved.
//

#import "YLAudioTool.h"

static NSMutableDictionary * _soundIDs ;
static NSMutableDictionary * _players ;


@implementation YLAudioTool

//方式1： 类方法的懒加载
//+ (NSMutableDictionary *)soundIDs
//{
//    if (!_soundIDs) {
//        _soundIDs = [NSMutableDictionary dictionary];
//    }
//    return _soundIDs ;
//}

//方式2
+ (void)initialize
{
    _soundIDs = [NSMutableDictionary dictionary];
    _players = [NSMutableDictionary dictionary];
}

////播放音效
+ (void) playSoundWithSoundName:(NSString *)soundName
{
    //1.从字典中取出之前保存的soundID
    SystemSoundID  soundID = [[_soundIDs objectForKey:soundName] unsignedIntValue];
    //2.如果取出为0，表示之前没有加载当前声音
    if (soundID == 0 ) {
        //2.1 根据资源文件加载soundID
        CFURLRef url = (__bridge CFURLRef)[[NSBundle mainBundle]URLForResource:soundName withExtension:nil ];
        AudioServicesCreateSystemSoundID(url, &soundID) ;
        //2.2 存入字典
        [_soundIDs setObject:@(soundID) forKey:soundName];
        
    }
    //3. 播放声音
    AudioServicesPlaySystemSound(soundID);

}


////播放音乐
+ (AVAudioPlayer *) playMusicWithMusicName:(NSString *)musicName
{
    //1.从字典中取出之前保存的播放器
    AVAudioPlayer * player = _players[musicName];
    
    //2.判断播放器是否为nil，如果为nil，则创建播放器
    if (player == nil) {
        //2.1 加载对应的资源
        NSURL * url = [[NSBundle mainBundle] URLForResource:musicName withExtension: nil];
        //2.2 创建播发器
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        //2.3 将播发器存入字典
        [_players setObject:player forKey:musicName];
        
    }
    //3.播放音乐
    [player play];
    return  player ;
}
////暂停音乐
+ (void) pauseMusicWithMusicName:(NSString *)musicName
{
    //1.从字典中取出之前保存的播发器
    AVAudioPlayer * player = _players[musicName];
    //2.如果播发器不为nil，则暂停
    if (player ) {
        [player pause];
    }
    
}
////停止音乐
+ (void) stopMusicWithMusicName:(NSString *)musicName
{
    //1.从字典中取出之前保存的播发器
    AVAudioPlayer * player = _players[musicName];
    //2.判断播发器是否为nil,如果不为空，则停止音乐
    if (player) {
        [player stop];
        [_players removeObjectForKey:musicName];
    }
}


@end
