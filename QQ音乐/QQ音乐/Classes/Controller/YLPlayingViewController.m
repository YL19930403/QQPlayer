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
#import "CALayer+LayerAnimation.h"

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
    
    //5.给滑块添加手势
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(slideClick:)];
    [self.SlideView addGestureRecognizer:tap];
    
    
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
    basicAnim.duration = 3.0 ;
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

#pragma mark  - 对滑块的处理
//用户手指点击下来
- (IBAction)TouchDown:(id)sender {
    //停止定时器
    [self stopProgressTimer];
}

//用户手指滑动
- (IBAction)ValueChange:(UISlider *)sender {
    //1. 拿到当前比例
    CGFloat ration = sender.value ;
    //2.根据当前的比例，计算出当前的时间
  NSTimeInterval currentTime =  ration*self.player.duration ;
    //3.改变左边时间的显示
    self.startTimeLabel.text = [NSString timeWithNSInteger:currentTime];
    
}

//用户手指释放
- (IBAction)TouchUp:(UISlider *)sender {
    //1.改变歌曲播放的进度
       //1.1 进度条当前进度的比例
    CGFloat ration = sender.value ;
    //1.2 根据当前的比例，计算出当前的时间
    NSTimeInterval currentTime = ration*self.player.duration ;
    //2.改变歌曲播放的时间
    self.player.currentTime = currentTime ;
    //3.添加定时器
    [self startProgressTimer];
}

//进度条的点击
- (void) slideClick:(UITapGestureRecognizer *)tap
{
   //1.获取进度条比例
      //1.1获取用户点击的位置
    CGPoint point = [tap locationInView:tap.view]; //self.SlideView
      //1.2计算比例
    CGFloat ration = point.x / self.SlideView.width ;
    //2. 计算当前应该播放的时间
    NSTimeInterval currentTime = ration*self.player.duration ;
    //3. 改变歌曲的播放进度
    self.player.currentTime = currentTime ;
    //4.跟新进度
    [self updateProgress];
    
}


#pragma mark  -   对歌曲的控制事件
- (IBAction)PreviousMusic:(UIButton *)sender {
    [self PreOrNextMusic:NO];
}

- (IBAction)NextMusic:(UIButton *)sender {
    [self PreOrNextMusic:YES];
}

- (void) PreOrNextMusic:(BOOL) isNext
{
    //1. 取出当前歌曲
    YLMusic * currentMusic = [YLPlayingTool playingMusic];
    //2. 停止当前歌曲
    [YLAudioTool stopMusicWithMusicName:currentMusic.filename];
    
    //3 .取出下一首歌曲，并播放
    YLMusic * anotherMusic ;
    if (isNext) {
        anotherMusic = [YLPlayingTool NextMusic];
        [YLAudioTool playMusicWithMusicName:anotherMusic.filename];
    }else{
        anotherMusic = [YLPlayingTool PreviousMusic];
        [YLAudioTool playMusicWithMusicName:anotherMusic.filename];
    }
    
    //4.设置上一首歌成为当前歌曲
    [YLPlayingTool setPlayingMusic:anotherMusic];
    //5. 改变界面信息
    [self startPlayingMusic];
}


- (IBAction)PlayOrPause:(UIButton *)sender {
    //取出当前歌曲
    YLMusic * currMusic = [YLPlayingTool playingMusic];
    if (sender.selected) {
        [YLAudioTool pauseMusicWithMusicName:currMusic.filename ];
        //暂停动画
        [self.iconView.layer stopLayerAnimation ];
        [self  stopProgressTimer];
    }else{
        [YLAudioTool playMusicWithMusicName:currMusic.filename];
        //继续动画
        [self.iconView.layer startLayerAnimation];
        [self startProgressTimer];
    }
    sender.selected  =  !sender.selected ;
}



@end










