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
    coinPics = [[NSMutableArray alloc]init];
    [coinPics addObject:@"flappyBirdCoin1.png"];
    [coinPics addObject:@"flappyBirdCoin2.png"];
    [coinPics addObject:@"flappyBirdCoin3.png"];
    [coinPics addObject:@"flappyBirdCoin4.png"];
    [coinPics addObject:@"flappyBirdCoin5.png"];
    [coinPics addObject:@"flappyBirdCoin6.png"];
    [coinPics addObject:@"flappyBirdCoin7.png"];
    [coinPics addObject:@"flappyBirdCoin8.png"];
    [coinPics addObject:@"flappyBirdCoin9.png"];
    [coinPics addObject:@"flappyBirdCoin10.png"];
    coinPicNum = 1;
    UIImage * coinImage = [UIImage imageNamed:coinPics[0]];
    _coinPicture.image = coinImage;
    wingsGoingUp = NO;
    birdY = _birdPicture.frame.origin.y;
    gravityOn = NO;
    gravityConstant = 0.22;
    birdAccel = 0;
    timerCount = 0;
    _coinPicture.frame = CGRectMake(_coinPicture.frame.origin.x, _coinPicture.frame.origin.y, _coinPicture.frame.size.width, _coinPicture.frame.size.height);
 
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [gravityTimer invalidate];
    
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
    [UIView animateWithDuration:0.1
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
    if(_birdPicture.frame.origin.y > self.view.frame.size.height / 2)
    {
        birdAccel += gravityConstant;
    }
    else
    {
        birdAccel -= gravityConstant;
    }
    
}

-(void)updateCoins
{
    [UIView animateWithDuration:0.1 animations:^(void){
        UIImage * newImage = [UIImage imageNamed:coinPics[coinPicNum]];
        _coinPicture.image = newImage;
     }completion:^(BOOL finished){}];
    coinPicNum += 1;
    //NSLog([NSString stringWithFormat:@"%d", coinPicNum]);
    if(coinPicNum == [coinPics count])
    {
        coinPicNum = 0;
    }
}

-(void)gameLoop
{
    if(timerCount == 10)
    {
        [self updateFlaps];
        [self updateCoins];
        timerCount = 0;
    }
    [self updateGravity];
    [self updateGround];
    timerCount += 1;
}

- (IBAction)goPressed:(id)sender
{
    if(!go)
    {
        gameLoopTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(gameLoop) userInfo:nil repeats:YES];
        //groundTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(updateGround) userInfo:Nil repeats:YES];
        //birdFlapTimer = [NSTimer scheduledTimerWithTimeInterval:0.10 target:self selector:@selector(updateFlaps) userInfo:Nil repeats:YES];
        go = YES;
        [_goButton setTitle:@"Stop!" forState:UIControlStateNormal];
    }
    else
    {
        //[groundTimer invalidate];
        //[birdFlapTimer invalidate];
        [gameLoopTimer invalidate];
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
        //theRunLoop addTimer:gravityTimer forMode:NSDefaultRunLoopMode];
        gravityOn = YES;
    }
    else
    {
        //[gravityTimer invalidate];
        gravityOn = NO;
    }
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
        [self goPressed:event];
        [self gravityPressed:event];
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
