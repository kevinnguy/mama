//
//  MAContactViewController.m
//  Mama
//
//  Created by Kevin Nguy on 8/14/14.
//  Copyright (c) 2014 Kevin Nguy. All rights reserved.
//

#import "MAContactViewController.h"

#import "MAActionCollectionViewCell.h"

#import <SimpleCam/SimpleCam.h>

@interface MAContactViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, AVAudioRecorderDelegate, AVAudioPlayerDelegate, UIGestureRecognizerDelegate, SimpleCamDelegate>

@property (nonatomic, strong) AVAudioRecorder *voiceRecorder;
@property (nonatomic, strong) AVAudioPlayer *voicePlayer;

@property (nonatomic, assign) BOOL voiceFlag;

@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGesture;

@property (nonatomic, strong) SimpleCam *camera;

@end

@implementation MAContactViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    UINib *nib =[UINib nibWithNibName:@"MAActionCollectionViewCell" bundle:[NSBundle mainBundle]]
    [self.collectionView registerNib:<#(UINib *)#> forCellWithReuseIdentifier:@"CellIdentifier"];
    
    [self.collectionView reloadData];
    
    [self setupVoice];
    [self setupCamera];
}

- (void)setupVoice
{
    // Set the audio file
    NSArray *pathComponents = @[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject],
                                @"MyAudioMemo.m4a"];
    
    NSURL *outputFileURL = [NSURL fileURLWithPathComponents:pathComponents];
    
    // Setup audio session
    NSError *error;
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord
             withOptions:AVAudioSessionCategoryOptionDefaultToSpeaker
                   error:&error];

    
    // Define the recorder setting
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc] init];
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    [recordSetting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
    [recordSetting setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];
    
    // Initiate and prepare the recorder
    self.voiceRecorder = [[AVAudioRecorder alloc] initWithURL:outputFileURL settings:recordSetting error:NULL];
    self.voiceRecorder.delegate = self;
    self.voiceRecorder.meteringEnabled = YES;
    [self.voiceRecorder prepareToRecord];
}

- (void)setupCamera
{
    self.camera = [SimpleCam new];
    self.camera.delegate = self;
    self.camera.hideAllControls = YES;
    [self.camera setDisablePhotoPreview:YES];
}

- (IBAction)textButtonPressed:(id)sender
{
    
}

- (IBAction)locationButtonPressed:(id)sender
{
    [self performSegueWithIdentifier:@"SegueToMap" sender:self];
}

- (IBAction)cameraButtonPressed:(id)sender
{
    [self presentViewController:self.camera animated:YES completion:nil];
}

- (IBAction)voiceButtonPressed:(id)sender
{
    if (!self.voiceFlag){
        self.voiceFlag = YES;

        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setActive:YES error:nil];
        
        // Start recording
        [self.voiceRecorder record];
    }
    else {
        self.voiceFlag = NO;
        
        self.voicePlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:self.voiceRecorder.url error:nil];
        [self.voicePlayer play];
    }
}

- (IBAction)stopButtonPressed:(id)sender
{
    [self.voiceRecorder stop];
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setActive:NO error:nil];
}

#pragma mark - SimpleCamDelegate
- (void)simpleCam:(SimpleCam *)simpleCam didFinishWithImage:(UIImage *)image
{
    [simpleCam closeWithCompletion:^{
        NSLog(@"SimpleCam is done closing ... ");
        [self setupCamera];
    }];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MAActionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    
    switch (indexPath.row) {
        case 0: {
            cell.button.layer.borderColor = [UIColor blueColor].CGColor;
            break;
        }
        
        case 1: {
            cell.button.layer.borderColor = [UIColor greenColor].CGColor;
            break;
        }
            
        case 2: {
            cell.button.layer.borderColor = [UIColor redColor].CGColor;
            break;
        }
            
        case 3: {
            cell.button.layer.borderColor = [UIColor orangeColor].CGColor;
            break;
        }
            
        default:
            break;
    }
    
    return cell;
}


@end
