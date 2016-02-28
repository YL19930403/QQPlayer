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
#import "NSString+YLExtension.h"

@interface YLPlayingViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *albumView;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UISlider *SlideView;
@property (weak, nonatomic) IBOutlet UILabel *songLabel;
@property (weak, nonatomic) IBOutlet UILabel *singerLabel;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;

@property(nonatomic,strong)NSTimer * timer ;
@property(nonatomic,weak) AVAudioPlayer * player ;

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
    
    //4. 添加定时器
    [self startProgressTimer];
    
    
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
    AVAudioPlayer * player = [YLAudioTool playMusicWithMusicName:music.filename ];
    self.player = player ;
    //通过播放器对象，拿到"播放歌曲的当前时间"  和“播放歌曲de 总时间”
    self.startTimeLabel.text = [NSString timeWithNSInteger:player.currentTime] ;
    self.totalTimeLabel.text = [NSString timeWithNSInteger:player.duration] ;
    
    //4. 添加iconView的旋转动画
    [self addRotationAnimation];

    
}

//添加旋转动画
- (void) addRotationAnimation
{
    /**
     基本动画和核心动画的区别：
         基本动画只能设置两三个值，fromValue, toValue,
         核心动画可以设置很多值
     使用KVC注意：   位移动画（transform.translation.x）,旋转动画（围绕z轴旋转 transform.rotation.z ）
    */
    CABasicAnimation * basicAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    basicAnim.fromValue = @(0) ;
    basicAnim.toValue = @(-M_PI * 2) ;
    basicAnim.duration = 10.0 ;
    basicAnim.repeatCount = MAXFLOAT ;
    [self.iconView.layer addAnimation:basicAnim forKey:nil];  //以后可以通过这个Key取出动画,我们传nil就好了
}

#pragma mark  -  定时器
- (void) startProgressTimer
{
    //手动调用滑块到最左段位置
    [self updateProgress];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void) stopProgressTimer
{
    [self.timer invalidate];
    self.timer = nil ;
    
}

- (void) updateProgress
{
    //改变滑块的位置
  self.SlideView.value = self.player.currentTime / self.player.duration ;
    //设置当前播放时间的label
    self.startTimeLabel.text = [NSString timeWithNSInteger:self.player.currentTime];
}

@end










