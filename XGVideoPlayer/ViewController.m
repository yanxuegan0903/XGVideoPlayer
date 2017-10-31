//
//  ViewController.m
//  XGVideoPlayer
//
//  Created by vsKing on 2017/10/31.
//  Copyright © 2017年 vsKing. All rights reserved.
//

#import "ViewController.h"
#import "XGVIdeoPlayView.h"




@interface ViewController ()

@property (nonatomic, strong) XGVIdeoPlayView *playView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString * path = [[NSBundle mainBundle] pathForResource:@"fish_1" ofType:@"mp4"];
    
    if (path) {
        
        AVPlayerItem * playItem = [AVPlayerItem playerItemWithURL:[NSURL fileURLWithPath:path]];
        
        XGVIdeoPlayView * playView = [[XGVIdeoPlayView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) playerItem:playItem];
        [playView setBackgroundColor:[UIColor grayColor]];
        [self.view addSubview:playView];
        
        
    }else{
        NSLog(@"路径不存在");
    }
    


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
