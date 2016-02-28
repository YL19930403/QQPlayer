//
//  lrcScrollView.m
//  QQ音乐
//
//  Created by 余亮 on 16/2/28.
//  Copyright © 2016年 余亮. All rights reserved.
//

#import "lrcScrollView.h"
#import <Masonry.h>
#import "lrcTableViewCell.h"
#import "lrcLine.h"
#import "lrcTool.h"

@interface lrcScrollView ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,weak) UITableView * tableV ;

@property(nonatomic,strong)NSMutableArray * lrclines ;

//当前歌词对应的下标
@property(nonatomic,assign)NSInteger currentLrcIndex ;

@end

@implementation lrcScrollView

- (NSMutableArray *)lrclines
{
    if (!_lrclines) {
        _lrclines = [NSMutableArray array];
    }
    return _lrclines ;
}

//从StoryBoard加载的
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self  setUpTableView];
    }
    return self ;
}

- (void) setUpTableView
{
    //1.创建tableView
    UITableView * tableV = [[UITableView alloc] init];
    self.tableV = tableV ;
    self.tableV.dataSource = self ;
    self.tableV.rowHeight = 30 ;
    tableV.showsVerticalScrollIndicator = NO;
    //设置tableView的上下内边距
    self.tableV.contentInset = UIEdgeInsetsMake(self.bounds.size.height*0.5, 0, self.bounds.size.height*0.5, 0);
    
    //2. 添加到lrcScrollView中
    [self addSubview:tableV];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    //注意点：在UIScrollView中添加UITableView，需要添加6个约束才行
    [_tableV mas_makeConstraints:^(MASConstraintMaker *make) {
        //1.确定TableView的位置
        make.top.equalTo(self.mas_top) ;
        make.left.equalTo(self.mas_left).offset(self.bounds.size.width);
        make.height.equalTo(self.mas_height);
        make.width.equalTo(self.mas_width);
        
        //2. 确定UIScrollView的滚动范围
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
    }];
    
    //对UITableView背景和边线的处理，最好是放在该方法中
    _tableV.backgroundColor = [UIColor clearColor];
    _tableV.separatorStyle = UITableViewCellSeparatorStyleNone ;
    
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.lrclines.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
       //创建cell
    lrcTableViewCell * cell =   [lrcTableViewCell irlCellWithTableView:self.tableV];
    //如果播放的是当前这句，则把字体放大
    if (self.currentLrcIndex == indexPath.row) {
        cell.textLabel.font = [UIFont systemFontOfSize:17];
    }else{
        [cell.textLabel setFont:[UIFont systemFontOfSize:13]];
    }
    
    //给cell设置数据
    lrcLine * lrcline = self.lrclines[indexPath.row];
    cell.textLabel.text = lrcline.text;
    return cell;
}

#pragma mark  -  重写Setter方法
- (void)setLrcName:(NSString *)lrcName
{
    _lrcName = lrcName ;
    //解析歌词
    self.lrclines = [lrcTool lrcToolWithLrcName:lrcName];
    //刷新列表
    [self.tableV reloadData];
    
}

- (void)setCurrentTime:(NSTimeInterval)currentTime
{
    _currentTime = currentTime ;
    
    //找出需要显示的歌词
    NSInteger count = self.lrclines.count;
    for (int i =0; i<count; i++) {
        //拿到i位置的歌词
        lrcLine * lrc = self.lrclines[i];
        //拿出i+1位置的歌词
        NSInteger  nextLrcIndex = i+1 ;
        if (nextLrcIndex >= count) {
            return ;
        }
        
        lrcLine * nextLrcLine = self.lrclines[nextLrcIndex];
        //当前时间大于i位置的时间，并且小于i+1位置的时间
        if (currentTime >= lrc.time && currentTime < nextLrcLine.time && self.currentLrcIndex != i) {
            //计算i位置的indexPath
            NSIndexPath * indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            NSIndexPath * preIndexPath = [NSIndexPath indexPathForRow:self.currentLrcIndex inSection:0];
            //记录i位置的下标
            self.currentLrcIndex = i ;
            //刷新i位置的cell
            [self.tableV reloadRowsAtIndexPaths:@[indexPath,preIndexPath] withRowAnimation:UITableViewRowAnimationRight];
            
            //让TableView的i位置的cell，滚动到中间
            [self.tableV scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
        
    }

}


@end











