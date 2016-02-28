//
//  YLAudioTool.h
//  03播放音效抽取工具类
//
//  Created by 余亮 on 16/2/27.
//  Copyright © 2016年 余亮. All rights reserved.
//

/**
    抽成工具类：为了能够在多个控制器里面都能使用，例如对网络请求的封装
 */

#import <Foundation/Foundation.h>

@interface YLAudioTool : NSObject

+ (void) playSoundWithSoundName:(NSString *)soundName ;
+ (id) playMusicWithMusicName:(NSString *)musicName ;
+ (void) pauseMusicWithMusicName:(NSString *)musicName ;
+ (void) stopMusicWithMusicName:(NSString *)musicName ;

@end
