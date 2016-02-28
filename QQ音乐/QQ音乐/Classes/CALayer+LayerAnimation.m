//
//  CALayer+LayerAnimation.m
//  QQ音乐
//
//  Created by 余亮 on 16/2/28.
//  Copyright © 2016年 余亮. All rights reserved.
//

#import "CALayer+LayerAnimation.h"

@implementation CALayer (LayerAnimation)

- (void) stopLayerAnimation
{
    CFTimeInterval pauseTime = [self convertTime:CACurrentMediaTime() fromLayer:nil];
    self.speed = 0.0 ;
    self.timeOffset = pauseTime ;
}

- (void) startLayerAnimation
{
    CFTimeInterval pauseTime = [self timeOffset];
    self.speed = 1.0 ;
    self.timeOffset = 0.0 ;
    self.beginTime = 0.0 ;
    CFTimeInterval timeSincePause = [self convertTime:CACurrentMediaTime() fromLayer:nil] - pauseTime ;
    self.beginTime = timeSincePause ;

}
@end
