//
//  XGVIdeoPlayView.m
//  XGVideoPlayer
//
//  Created by vsKing on 2017/10/31.
//  Copyright © 2017年 vsKing. All rights reserved.
//

#import "XGVIdeoPlayView.h"

@interface XGVIdeoPlayView ()

@property (nonatomic, strong) AVPlayer *player;

@property (nonatomic, strong) AVPlayerLayer *playerLayer;

@end

@implementation XGVIdeoPlayView

- (instancetype)initWithFrame:(CGRect)frame playerItem:(AVPlayerItem *)playerItem
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.player = [AVPlayer playerWithPlayerItem:playerItem];
        self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        self.playerLayer.videoGravity=AVLayerVideoGravityResizeAspect;//视频填充模式
        self.playerLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        [self.layer addSublayer:self.playerLayer];
        
        
        //  添加监听
        
        @try{
            [self addObserverToPlayerItem:playerItem];
            [self addProgressObserver];
            [self addNotification];
        }
        @catch(NSException *exception) {
            NSLog(@"异常错误是:%@", exception);
        }
        @finally {
            
        }
        
        
        
        
        
        
        
        
    }
    return self;
}


- (void)play{
    [self.player play];
}

- (void)stop{
    [self.player pause];
}


#pragma mark - 注册监听

// 给AVPlayerItem添加监控
-(void)addObserverToPlayerItem:(AVPlayerItem *)playerItem {
    //监控状态属性，注意AVPlayer也有一个status属性，通过监控它的status也可以获得播放状态
    [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    //监控网络加载情况属性
    [playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
}

/**
 *  通过KVO监控播放器状态
 *
 *  @param keyPath 监控属性
 *  @param object  监视器
 *  @param change  状态改变
 *  @param context 上下文
 */
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    AVPlayerItem *playerItem=object;
    
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerStatus status= [[change objectForKey:@"new"] intValue];
        if(status==AVPlayerStatusReadyToPlay){
            NSLog(@"正在播放...，视频总长度:%.2f",CMTimeGetSeconds(playerItem.duration));
        }
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]){
        NSArray *array=playerItem.loadedTimeRanges;
        CMTimeRange timeRange = [array.firstObject CMTimeRangeValue];//本次缓冲时间范围
        float startSeconds = CMTimeGetSeconds(timeRange.start);
        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
        NSTimeInterval totalBuffer = startSeconds + durationSeconds;//缓冲总长度
        NSLog(@"共缓冲：%.2f",totalBuffer);
    }
}



/**
 *  给播放器添加进度更新
 */
-(void)addProgressObserver {
    
    //    AVPlayerItem *playerItem=self.player.currentItem;
//    UISlider *slider=self.slider;
//    UILabel *timeLabel = self.timeLabel;
    //这里设置每秒执行一次
    
    __weak typeof(self)weakSelf = self;
    [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        float current = CMTimeGetSeconds(time);
        float total = CMTimeGetSeconds([strongSelf.player.currentItem duration]);
        NSLog(@"当前进度%.2f/%.2f",current,total);
//        if (current) {
//            [progress setProgress:(current/total) animated:YES];
//            slider.value = current;
//            timeLabel.text = [weakSelf convertTime:current];// 转换成播放时间
//        }
    }];
}


/**
 *  添加播放器通知
 */
- (void)addNotification {
    //给AVPlayerItem添加播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playbackFinished:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:self.player.currentItem];
}

//  播放完成的操作
-(void)playbackFinished:(NSNotification *)notification{
    NSLog(@"视频播放完成.");
    
    //  播放结束后 暂停 然后继续从0开始播放
    [self.player pause];
    [self.player seekToTime:CMTimeMake(0, 1)];
    [self.player play];
}



@end
