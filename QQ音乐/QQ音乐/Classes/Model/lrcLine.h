//
//  lrcLine.h
//  QQ音乐
//
//  Created by 余亮 on 16/2/28.
//  Copyright © 2016年 余亮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface lrcLine : NSObject
//显示的文字
@property(nonatomic,copy) NSString * text ;

//显示的时间
@property(nonatomic,assign) NSTimeInterval  time ;

- (instancetype) initwithLrcString:(NSString *)LrcString ;

+ (instancetype) lrcWithLrcString:(NSString *)LrcString ;
@end
