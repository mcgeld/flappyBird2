//
//  ViewController.m
//  flappyBird2
//
//  Created by Malcolm Geldmacher on 2/26/14.
//  Copyright (c) 2014 Malcolm Geldmacher. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
   
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _background1.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    _ground1.frame = CGRectMake(0, self.view.frame.size.height - _ground1.frame.size.height, _ground1.frame.size.width, _ground1.frame.size.height);
    birdPics = [[NSMutableArray alloc]init];
    [birdPics addObject:@"hands1 copy.png"];
    [birdPics addObject:@"hands2 copy.png"];
    [birdPics addObject:@"hands3 copy.png"];
    [birdPics addObject:@"hands4 copy.png"];
    [birdPics addObject:@"hands5 copy.png"];
    [birdPics addObject:@"hands6 copy.png"];
    [birdPics addObject:@"hands7 copy.png"];
    [birdPics addObject:@"hands8 copy.png"];
    birdPicNum = 0;
    timerCount = 0;
    gameLoopTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(gameLoop) userInfo:nil repeats:YES];
    birdAccel = 0;
    gravityConstant = -0.22;
    _titlePicture.frame = CGRectMake(_titlePicture.frame.origin.x, 0 - _titlePicture.frame.size.height, _titlePicture.frame.size.width, _titlePicture.frame.size.height);
    
    if(_soundFXOutlet.on)
        soundFX = true;
    if(_musicSwitchOutlet.on)
        musicOn = true;
    buttonsMoved=NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [gravityTimer invalidate];
    [gameLoopTimer invalidate];
}
-(void)setUpSmallScreen
{
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        if ([[UIScreen mainScreen] scale] == 2.0) {
            if([UIScreen mainScreen].bounds.size.height == 568){
              
                _easyButtonView.frame=CGRectMake(20, 502, _easyButtonView.frame.size.width, _easyButtonView.frame.size.height);
            _mediumButtonView.frame=CGRectMake(120, 502, _mediumButtonView.frame.size.width, _mediumButtonView.frame.size.height);
            _hardButtonView.frame=CGRectMake(220, 502, _hardButtonView.frame.size.width, _hardButtonView.frame.size.height);
            } else{
            
             
               _easyButtonView.frame=CGRectMake(20, 323, _easyButtonView.frame.size.width, _easyButtonView.frame.size.height);
               _mediumButtonView.frame=CGRectMake(120, 411, _mediumButtonView.frame.size.width, _mediumButtonView.frame.size.height);
                _hardButtonView.frame=CGRectMake(220, 323, _hardButtonView.frame.size.width, _hardButtonView.frame.size.height);
            }
        }
    }
    
}
-(void)updateFlaps
{

    [UIView animateWithDuration:0.1
            animations:^(void)
            {
                _birdPicture.image = [UIImage imageNamed:birdPics[birdPicNum]];
            }
            completion:^(BOOL finished){}];
    if(birdPicNum == [birdPics count] - 1)
    {
        birdPicNum = 0;
    }
    birdPicNum += 1;
}

-(void)updateGravity
{
    
    [UIView animateWithDuration:0.01
            animations:^(void)
            {
                _titlePicture.frame = CGRectMake(_titlePicture.frame.origin.x, _titlePicture.frame.origin.y - birdAccel, _titlePicture.frame.size.width, _titlePicture.frame.size.height);
            }
            completion:^(BOOL finished){}];
    if(_titlePicture.frame.origin.y > 75)
    {
        _titlePicture.frame = CGRectMake(_titlePicture.frame.origin.x, 75, _titlePicture.frame.size.width, _titlePicture.frame.size.height);
        birdAccel = birdAccel * -.6;
    }
    else
    {
        birdAccel += gravityConstant;
    }
    
}

-(void)gameLoop
{
  
        [self setUpSmallScreen];
    
   
    [self updateGravity];
    if(timerCount == 13)
    {
        [self updateFlaps];
        timerCount = 0;
    }
    timerCount += 1;
}

- (IBAction)easyMode:(id)sender {
    gameMode=3;
}

- (IBAction)mediumMode:(id)sender {
    gameMode=2;
}

- (IBAction)hardMode:(id)sender {
    gameMode=1;
}

-(void)invalidateTimers
{
    [gameLoopTimer invalidate];
    
}

- (IBAction)soundFXSwitch:(id)sender {
    if(_soundFXOutlet.on)
        soundFX = true;
    else
        soundFX = false;
}

- (IBAction)musicSwitch:(id)sender
{
    if(_musicSwitchOutlet.on)
        musicOn = true;
    else
        musicOn = false;
}

@end
