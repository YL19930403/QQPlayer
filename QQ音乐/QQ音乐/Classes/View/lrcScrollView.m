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


@end











