//
//  gameView.m
//  flappyBird2
//
//  Created by Brittny Wright on 2/27/14.
//  Copyright (c) 2014 Malcolm Geldmacher. All rights reserved.
//


 bool startTubeOne=YES;
bool startTubeTwo=NO;
int tubeWidth=59;
int tubeHeight=256;
int tubeBottomY=325;
int tubeBottomX=350;

#import "gameView.h"

@implementation gameView



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    _tubeBottomImage=[[UIImageView alloc] init];
    _tubeBottomImage1=[[UIImageView alloc] init];
    
    _tubeBottomImage.frame=CGRectMake(tubeBottomX, tubeBottomY, _tubeBottomImage.frame.size.width, _tubeBottomImage.frame.size.height);
    _tubeBottomImage1.center=CGPointMake(tubeBottomX, tubeBottomY);
    
    
    _background1.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    _ground1.frame = CGRectMake(0, self.view.frame.size.height - _ground1.frame.size.height, _ground1.frame.size.width, _ground1.frame.size.height);
    _ground2.frame = CGRectMake(self.view.frame.size.width, self.view.frame.size.height - _ground2.frame.size.height, _ground2.frame.size.width, _ground2.frame.size.height);
    _birdPicture.frame = CGRectMake(_birdPicture.frame.origin.x, _birdPicture.frame.origin.y, 34, 24);
    go = NO;
    groundX = 0;
    groundY = self.view.frame.size.height - _ground1.frame.size.height;
    birdPics = [[NSMutableArray alloc]init];
    [birdPics addObject:@"flappyBirdFlying1.png"];
    [birdPics addObject:@"flappyBirdFlying2.png"];
    [birdPics addObject:@"flappyBirdFlying3.png"];
    birdPicNum = 0;
    wingsGoingUp = NO;
    birdY = _birdPicture.frame.origin.y;
    gravityOn = NO;
    gravityConstant = 0.22;
    birdAccel = 0;
    
    tubeSpeed=-1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateGround
{
    [UIView animateWithDuration:0.01
                     animations:^(void)
     {
         [_ground1 setFrame:CGRectMake(groundX, groundY, _ground1.frame.size.width, _ground1.frame.size.height)];
         [_ground2 setFrame:CGRectMake(groundX + self.view.frame.size.width, groundY, _ground2.frame.size.width, _ground2.frame.size.height)];
     }
                     completion:^(BOOL finished){}];
    groundX -= 1;
    if(groundX < (self.view.frame.size.width * -1))
    {
        groundX = 0;
    }
    
    
    

    
    
    
}

-(void)updateFlaps
{
    [UIView animateWithDuration:0.01
                     animations:^(void)
     {
         _birdPicture.image = [UIImage imageNamed:birdPics[birdPicNum]];
     }
                     completion:^(BOOL finished){}];
    if(birdPicNum == [birdPics count] - 1)
    {
        birdPicNum = [birdPics count] - 2;
        wingsGoingUp = YES;
    }
    else if(birdPicNum == 0)
    {
        birdPicNum = 1;
        wingsGoingUp = NO;
    }
    else
    {
        if(wingsGoingUp)
        {
            birdPicNum -= 1;
        }
        else
        {
            birdPicNum += 1;
        }
    }
}

-(void)updateGravity
{
    [UIView animateWithDuration:0.01
                     animations:^(void)
     {
         _birdPicture.frame = CGRectMake(_birdPicture.frame.origin.x, _birdPicture.frame.origin.y - birdAccel, _birdPicture.frame.size.width, _birdPicture.frame.size.height);
     }
                     completion:^(BOOL finished){}];
    birdAccel -= gravityConstant;
}




-(void)updateTube
{
   // NSLog(@"%f",_tubeBottomImage.);
    

    if(_tubeBottomImage.center.y<(_tubeBottomImage.frame.size.width/2))
    {
        startTubeTwo=YES;
    }
    if(_tubeBottomImage1.center.y<(_tubeBottomImage1.frame.size.width/2))
    {
        startTubeOne=YES;
    }
    
    if(_tubeBottomImage.center.y<(_tubeBottomImage.frame.size.width*-1))
    {
        startTubeOne=NO;
        _tubeBottomImage.center=CGPointMake(tubeBottomX, tubeBottomY);
        
    }
    
    if(_tubeBottomImage1.center.y<(_tubeBottomImage1.frame.size.width*-1))
    {
        startTubeTwo=NO;
        _tubeBottomImage1.center=CGPointMake(tubeBottomX, tubeBottomY);
        
    }
    
    
    if(startTubeOne==YES)
    {
        _tubeBottomImage.center = CGPointMake(_tubeBottomImage.center.x+tubeSpeed, _tubeBottomImage.center.y);
    
    }
    
    if(startTubeTwo==YES)
    {
       _tubeBottomImage1.center = CGPointMake(_tubeBottomImage1.center.x+tubeSpeed, _tubeBottomImage1.center.y);
        
    }
    
    
    
    
  
  
    
    

  
    
}

- (IBAction)goPressed:(id)sender
{
    if(!go)
    {
        NSRunLoop * theRunLoop = [NSRunLoop currentRunLoop];
        groundTimer = [NSTimer timerWithTimeInterval:0.01 target:self selector:@selector(updateGround) userInfo:Nil repeats:YES];
        birdFlapTimer = [NSTimer timerWithTimeInterval:0.10 target:self selector:@selector(updateFlaps) userInfo:Nil repeats:YES];
        [theRunLoop addTimer:groundTimer forMode:NSDefaultRunLoopMode];
        [theRunLoop addTimer:birdFlapTimer forMode:NSDefaultRunLoopMode];
        go = YES;
        [_goButton setTitle:@"Stop!" forState:UIControlStateNormal];
        //tube timer
        tubeTimer=[NSTimer scheduledTimerWithTimeInterval:.02 target:(self) selector:@selector(updateTube) userInfo:nil repeats:YES];
       
        
    }
    else
    {
        [tubeTimer invalidate];
        [groundTimer invalidate];
        [birdFlapTimer invalidate];
        go = NO;
        [_goButton setTitle:@"Go!" forState:UIControlStateNormal];
    }
}

- (IBAction)gravityPressed:(id)sender
{
    if(!gravityOn)
    {
        NSRunLoop * theRunLoop = [NSRunLoop currentRunLoop];
        gravityTimer = [NSTimer timerWithTimeInterval:0.01 target:self selector:@selector(updateGravity) userInfo:Nil repeats:YES];
        [theRunLoop addTimer:gravityTimer forMode:NSDefaultRunLoopMode];
        gravityOn = YES;
    }
    else
    {
        [gravityTimer invalidate];
        gravityOn = NO;
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * curTouch = [touches anyObject];
    CGPoint curTouchPoint = [curTouch locationInView:self.view];
    if(CGRectContainsPoint(_startButtonImage.frame, curTouchPoint))
    {
        [_startButtonImage setFrame:CGRectMake(_startButtonImage.frame.origin.x, _startButtonImage.frame.origin.y + 2, _startButtonImage.frame.size.width, _startButtonImage.frame.size.height)];
        startButtonDown = YES;
    }
    else
    {
        birdAccel = 6;
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * curTouch = [touches anyObject];
    CGPoint curTouchPoint = [curTouch locationInView:self.view];
    if(startButtonDown && CGRectContainsPoint(_startButtonImage.frame, curTouchPoint))
    {
        [_startButtonImage setFrame:CGRectMake(_startButtonImage.frame.origin.x, _startButtonImage.frame.origin.y - 2, _startButtonImage.frame.size.width, _startButtonImage.frame.size.height)];
        startButtonDown = NO;
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * curTouch = [touches anyObject];
    CGPoint curTouchPoint = [curTouch locationInView:self.view];
    if(startButtonDown && !CGRectContainsPoint(_startButtonImage.frame, curTouchPoint))
    {
        [_startButtonImage setFrame:CGRectMake(_startButtonImage.frame.origin.x, _startButtonImage.frame.origin.y - 2, _startButtonImage.frame.size.width, _startButtonImage.frame.size.height)];
        startButtonDown = NO;
    }
    else if(!startButtonDown && CGRectContainsPoint(_startButtonImage.frame, curTouchPoint))
    {
        [_startButtonImage setFrame:CGRectMake(_startButtonImage.frame.origin.x, _startButtonImage.frame.origin.y + 2, _startButtonImage.frame.size.width, _startButtonImage.frame.size.height)];
        startButtonDown = YES;
    }
}
@end
