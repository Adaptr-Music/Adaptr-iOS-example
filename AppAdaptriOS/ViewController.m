//
//  ViewController.m
//  AppAdaptriOS
//
//  Created by Arveen kumar on 23/11/2020.
//

#import "ViewController.h"
#import <Adaptr/Adaptr.h>

@interface ViewController ()


@property (weak, nonatomic) IBOutlet MetadataLabel *track;
@property (weak, nonatomic) IBOutlet MetadataLabel *artist;
@property (weak, nonatomic) IBOutlet MetadataLabel *album;

@property NSUInteger noOfstations;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ADLogSetLevel(ADLogLevelDebug);
    AdaptrAudioPlayer *player = [AdaptrAudioPlayer sharedPlayer];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    [player whenAvailable:^{
        //player.doesHandleRemoteCommands = NO;
        [player setSecondsOfCrossfade:0];
        for (Station *station in player.stationList) {
            self->_noOfstations++;
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [button addTarget:self action:@selector(changeStation:) forControlEvents:UIControlEventTouchUpInside];
            [[button layer] setValue:station forKey:@"station"];
            [button setTitle:station.name forState:UIControlStateNormal];
            
            button.frame = CGRectMake((width/4), 50.0* (double)self->_noOfstations, 150.0, 50.0);
            [self.view addSubview:button];
            
            //NSLog( @"Size =%lu", [player getOfflineStorageUsed]);
        }
    } notAvailable:^{
        NSLog(@"Not available");
    }];
}
    
 - (void)changeStation: (UIButton*)sender
 {
     Station *station = [[sender layer] valueForKey:@"station"];
     [[AdaptrAudioPlayer sharedPlayer] setActiveStation:station withCrossfade:NO];
     [[AdaptrAudioPlayer sharedPlayer] play];
 }

  


@end
