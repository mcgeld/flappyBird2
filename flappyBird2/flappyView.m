//
//  flappyView.m
//  flappyBird2
//
//  Created by Brittny Wright on 2/28/14.
//  Copyright (c) 2014 Malcolm Geldmacher. All rights reserved.
//

#import "flappyView.h"

@implementation flappyView
- (void)viewDidLoad
{
    [super viewDidLoad];
    sizeBetweenTubes=128;
    widthOfViewController=320;
    startTubeOne=YES;
    startTubeTwo=NO;
    tubeWidth=59;
    tubeHeight=256;
    tubeBottomY=321;
    tubeBottomX=350;
    tubeTopX=350;
    tubeTopY=-107;
    tubeSpeed=-1;
    random=150;
    
    collisionObjectsArray=[[NSMutableArray alloc] init];
    
    
   
    _tubeBottomImage.hidden=YES;
    _tubeBottomImage1.hidden=YES;
    
    _tubeTopImage.hidden=YES;
    _tubeTopImage1.hidden=YES;
    
    [collisionObjectsArray addObject:_tubeBottomImage];
    [collisionObjectsArray addObject:_tubeBottomImage1];
    [collisionObjectsArray addObject:_tubeTopImage];
    [collisionObjectsArray addObject:_tubeTopImage1];
    [collisionObjectsArray addObject:_ground1];
    [collisionObjectsArray addObject:_ground2];
    
    //_tubeBottomImage.frame=CGRectMake(tubeBottomX, tubeBottomY, _tubeBottomImage.frame.size.width, _tubeBottomImage.frame.size.height);
    //_tubeBottomImage1.frame=CGRectMake(tubeBottomX, tubeBottomY, _tubeBottomImage1.frame.size.width, _tubeBottomImage1.frame.size.height);
    
    
    
    
	// Do any additional setup after loading the view, typically from a nib.
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    [gravityTimer invalidate];
    [tubeTimer invalidate];
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
    
    //collision checking
    for(int i=0; i<[collisionObjectsArray count]; i++)
    {
        UIImageView *Bird=collisionObjectsArray[i];
        
        if(CGRectIntersectsRect(_birdPicture.frame, Bird.frame ))
        {
        
            [self gameOver];
        }
        
    }
    
    
    
    
    if(_tubeBottomImage.frame.origin.x<100)
    {
        random=(arc4random()%238)*-1;
    }
    
    
    //IF first tube is halfway off the screen
    if(_tubeBottomImage.frame.origin.x<0)
    {
        
        startTubeTwo=YES;
  
      
    }
    //if second image is halfway off the screen
    if(_tubeBottomImage1.frame.origin.x<0)
    {
        startTubeOne=YES;
    }
    
    
    //if first tube finishes start second and put first back to original spot
    if(_tubeBottomImage.center.x<(_tubeBottomImage.frame.size.width*-1))
    {
        startTubeOne=NO;
        
         _tubeTopImage.frame=CGRectMake(tubeTopX, random, _tubeTopImage.frame.size.width, _tubeTopImage.frame.size.height);
        
         _tubeBottomImage.frame=CGRectMake(tubeBottomX, (random+sizeBetweenTubes+_tubeBottomImage.frame.size.height), _tubeBottomImage.frame.size.width, _tubeBottomImage.frame.size.height);
        
        
        
    }
    
    
     //if second tube finishes start first and put second back to original spot
   if(_tubeBottomImage1.center.x<(_tubeBottomImage1.frame.size.width*-1))
    {
        startTubeTwo=NO;
         _tubeTopImage1.frame=CGRectMake(tubeTopX, random, _tubeTopImage1.frame.size.width, _tubeTopImage1.frame.size.height);
        
    _tubeBottomImage1.frame=CGRectMake(tubeBottomX, (random+sizeBetweenTubes+_tubeBottomImage1.frame.size.height), _tubeBottomImage1.frame.size.width, _tubeBottomImage1.frame.size.height);
        
   }
    
    
    //Movement of the tubes
    if(startTubeOne==YES)
    {
        _tubeBottomImage.frame = CGRectMake(_tubeBottomImage.frame.origin.x+tubeSpeed, _tubeBottomImage.frame.origin.y, _tubeBottomImage.frame.size.width, _tubeBottomImage.frame.size.height);
        
        _tubeTopImage.frame = CGRectMake(_tubeTopImage.frame.origin.x+tubeSpeed, _tubeTopImage.frame.origin.y, _tubeTopImage.frame.size.width, _tubeTopImage.frame.size.height);
        
    }
    
    if(startTubeTwo==YES)
    {
 _tubeBottomImage1.frame = CGRectMake(_tubeBottomImage1.frame.origin.x+tubeSpeed, _tubeBottomImage1.frame.origin.y, _tubeBottomImage1.frame.size.width, _tubeBottomImage1.frame.size.height);
        
    _tubeTopImage1.frame = CGRectMake(_tubeTopImage1.frame.origin.x+tubeSpeed, _tubeTopImage1.frame.origin.y, _tubeTopImage1.frame.size.width, _tubeTopImage1.frame.size.height);
        
    }
    
    
    
    
    
    
    
    
    
    
    
}

-(void)gameLoop
{
    [self updateTube];
    [self updateGround];
    if(timerCount == 10)
    {
        [self updateFlaps];
        timerCount = 0;
    }
    [self updateGravity];
    timerCount += 1;
}


- (IBAction)goPressed:(id)sender
{
    if(!go)
    {
        gameLoopTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(gameLoop) userInfo:nil repeats:YES];
        
        _tubeBottomImage.frame=CGRectMake(tubeBottomX, tubeBottomY, _tubeBottomImage.frame.size.width, _tubeBottomImage.frame.size.height);
        _tubeBottomImage1.frame=CGRectMake(tubeBottomX, tubeBottomY, _tubeBottomImage1.frame.size.width, _tubeBottomImage1.frame.size.height);
        _tubeTopImage.frame=CGRectMake(tubeTopX, tubeTopY, _tubeTopImage.frame.size.width, _tubeTopImage.frame.size.height);
        _tubeTopImage1.frame=CGRectMake(tubeTopX, tubeTopY, _tubeTopImage1.frame.size.width, _tubeTopImage1.frame.size.height);
        _tubeBottomImage1.hidden=NO;
        _tubeBottomImage.hidden=NO;
        _tubeTopImage1.hidden=NO;
        _tubeTopImage.hidden=NO;
        
        
        
        
        //tubeTimer=[NSTimer scheduledTimerWithTimeInterval:.01 target:(self) selector:@selector(updateTube) userInfo:nil repeats:YES];
        
        //NSRunLoop * theRunLoop = [NSRunLoop currentRunLoop];
        //groundTimer = [NSTimer timerWithTimeInterval:0.01 target:self selector:@selector(updateGround) userInfo:Nil repeats:YES];
        //birdFlapTimer = [NSTimer timerWithTimeInterval:0.10 target:self selector:@selector(updateFlaps) userInfo:Nil repeats:YES];
        //[theRunLoop addTimer:groundTimer forMode:NSDefaultRunLoopMode];
        //[theRunLoop addTimer:birdFlapTimer forMode:NSDefaultRunLoopMode];
        go = YES;
        [_goButton setTitle:@"Stop!" forState:UIControlStateNormal];
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
        //NSRunLoop * theRunLoop = [NSRunLoop currentRunLoop];
        //gravityTimer = [NSTimer timerWithTimeInterval:0.01 target:self selector:@selector(updateGravity) userInfo:Nil repeats:YES];
        //[theRunLoop addTimer:gravityTimer forMode:NSDefaultRunLoopMode];
        gravityOn = YES;
    }
    else
    {
        //[gravityTimer invalidate];
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




-(void)gameOver
{
    [gravityTimer invalidate];
    
    [groundTimer invalidate];
    [tubeTimer invalidate];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}




@end
