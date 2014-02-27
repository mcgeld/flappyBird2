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
    go = NO;
    groundX = 0;
    groundY = self.view.frame.size.height - _ground1.frame.size.height;
    UIImage * birdImage1 = [UIImage imageNamed:@"flappyBirdFlying1"];
    UIImage * birdImage2 = [UIImage imageNamed:@"flappyBirdFlying2"];
    UIImage * birdImage3 = [UIImage imageNamed:@"flappyBirdFlying3"];
    [birdPics addObject:birdImage1];
    [birdPics addObject:birdImage2];
    [birdPics addObject:birdImage3];
    birdPicNum = 0;
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

- (IBAction)goPressed:(id)sender
{
    if(!go)
    {
        timer = [NSTimer timerWithTimeInterval:0.01 target:self selector:@selector(updateGround) userInfo:Nil repeats:YES];
        NSRunLoop * theRunLoop = [NSRunLoop currentRunLoop];
        [theRunLoop addTimer:timer forMode:NSDefaultRunLoopMode];
        go = YES;
        [_goButton setTitle:@"Stop!" forState:UIControlStateNormal];
    }
    else
    {
        [timer invalidate];
        go = NO;
        [_goButton setTitle:@"Go!" forState:UIControlStateNormal];
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
