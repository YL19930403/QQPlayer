//
//  YLPlayingViewController.m
//  QQ音乐
//
//  Created by 余亮 on 16/2/27.
//  Copyright © 2016年 余亮. All rights reserved.
//

#import "YLPlayingViewController.h"
#import <Masonry.h>
#import "UIView+YLExtension.h"

@interface YLPlayingViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *albumView;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UISlider *SlideView;
@property (weak, nonatomic) IBOutlet UILabel *songLabel;
@property (weak, nonatomic) IBOutlet UILabel *singerLabel;

@end

@implementation YLPlayingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   //1. 添加毛玻璃效果
    [self setupBlurGlass];
    
    //2. 设置进度条
    [self.SlideView setThumbImage:[UIImage imageNamed:@"player_slider_playback_thumb"] forState:UIControlStateNormal];
    
    //3. 开始播放歌曲
    [self startPlayingMusic];
    
}

- (void) setupBlurGlass
{
    //1.创建UIToolBar
    UIToolbar * toolbar = [[UIToolbar alloc] init];
    toolbar.barStyle = UIBarStyleBlack ;
    [self.albumView addSubview:toolbar];
    
    //2. 给UIToolbar添加约束
    [toolbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.albumView);
    }];
    
    //3.播放歌曲
    [self startPlayingMusic];
    
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    //设置歌手图片的圆角
    self.iconView.layer.cornerRadius = self.iconView.width*0.5 ;
    self.iconView.layer.masksToBounds = YES ;
    self.iconView.layer.borderWidth = 8 ;
    self.iconView.layer.borderColor =  YLRGB(40, 40, 40).CGColor;
}


#pragma mark - 开始播放歌曲
- (void) startPlayingMusic
{
    //1.取出当前播放的歌曲
    YLMusic * music = [YLPlayingTool playingMusic];
    //2.设置界面的基本展示
    self.albumView.image = [UIImage imageNamed:music.icon];
    self.iconView.image = [UIImage imageNamed:music.icon];
    self.songLabel.text = music.name ;
    self.singerLabel.text = music.singer ;
    
    //3.开始播放
    [YLAudioTool playMusicWithMusicName:music.filename ];
    
}
@end










