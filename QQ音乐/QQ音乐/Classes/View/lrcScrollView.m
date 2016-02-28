//
//  lrcScrollView.m
//  QQ音乐
//
//  Created by 余亮 on 16/2/28.
//  Copyright © 2016年 余亮. All rights reserved.
//

#import "lrcScrollView.h"
#import <Masonry.h>

@interface lrcScrollView ()
@property(nonatomic,weak) UITableView * tableV ;

@end

@implementation lrcScrollView

//从StoryBoard加载的
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self == [super initWithCoder:aDecoder]) {
        [self  setUpTableView];
    }
    return self ;
}

- (void) setUpTableView
{
    //1.创建tableView
    UITableView * tableV = [[UITableView alloc] init];
    self.tableV = tableV ;
    tableV.backgroundColor = [UIColor redColor];
    [self  setUpTableFrame];
    //2. 添加到lrcScrollView中
    [self addSubview:tableV];
    
}

- (void) setUpTableFrame
{
    [_tableV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self) ;
//        make.left.equalTo(self.mas_centerX);
//        make.bottom.equalTo(self.mas_bottom);
//        make.right.equalTo(self.mas_right);
    }];
}

@end
