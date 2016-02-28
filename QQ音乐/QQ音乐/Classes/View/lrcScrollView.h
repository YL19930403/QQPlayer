//
//  lrcScrollView.h
//  QQ音乐
//
//  Created by 余亮 on 16/2/28.
//  Copyright © 2016年 余亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface lrcScrollView : UIScrollView
//歌词的名字
@property(nonatomic,copy) NSString * lrcName ;

//当前歌词对应的时间
@property(nonatomic, assign)NSTimeInterval currentTime ;


- (instancetype)initWithCoder:(NSCoder *)aDecoder ;
@end
