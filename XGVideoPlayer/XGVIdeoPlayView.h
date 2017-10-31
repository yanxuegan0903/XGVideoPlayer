//
//  XGVIdeoPlayView.h
//  XGVideoPlayer
//
//  Created by vsKing on 2017/10/31.
//  Copyright © 2017年 vsKing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface XGVIdeoPlayView : UIView

- (instancetype)initWithFrame:(CGRect)frame playerItem:(AVPlayerItem *)playerItem;

- (void)play;

- (void)stop;

@end
