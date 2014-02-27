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
    _background2.frame = CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
    x = 0;
    y = 0;
    go = NO;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateBackground
{
    [UIView animateWithDuration:0.02 animations:^(void){
        [_background1 setFrame:CGRectMake(x, y, self.view.frame.size.width, self.view.frame.size.height)];
        [_background2 setFrame:CGRectMake(x + self.view.frame.size.width, y, self.view.frame.size.width, self.view.frame.size.height)];
    }completion:^(BOOL finished){}];
    x -= 1;
    if(x < self.view.frame.size.width * -1)
    {
        x = 0;
    }
}

- (IBAction)goPressed:(id)sender
{
    if(!go)
    {
        timer = [NSTimer timerWithTimeInterval:0.02
                                        target:self
                                      selector:@selector(updateBackground)
                                      userInfo:nil
                                       repeats:YES];
        NSRunLoop * theRunLoop = [NSRunLoop currentRunLoop];
        [theRunLoop addTimer:timer forMode:NSDefaultRunLoopMode];
        go = YES;
        [_goButton setTitle:@"Stop!" forState:UIControlStateNormal];
        //[timer fire];
    }
    else
    {
        [_goButton setTitle:@"Go!" forState:UIControlStateNormal];
        [timer invalidate];
        go = NO;
    }
}
@end
