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
        [self.player play];
        
        
        
        
        
    }
    return self;
}


- (void)play{
    
}

- (void)stop{
    
}






@end
