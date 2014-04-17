//
//  ViewController.h
//  flappyBird2
//
//  Created by Malcolm Geldmacher on 2/26/14.
//  Copyright (c) 2014 Malcolm Geldmacher. All rights reserved.
//

#import <UIKit/UIKit.h>
  int gameMode;
@interface ViewController : UIViewController
{
  
    
    
    NSTimer * gameLoopTimer;
    NSTimer * groundTimer;
    NSTimer * birdFlapTimer;
    NSTimer * gravityTimer;
    NSTimer * coinTimer;
    int timerCount;
    BOOL go;
    float groundX;
    float groundY;
    BOOL startButtonDown;
    NSMutableArray * birdPics;
    int birdPicNum;
    NSMutableArray * coinPics;
    int coinPicNum;
    BOOL wingsGoingUp;
    float birdY;
    float gravityConstant;
    float birdAccel;
    BOOL gravityOn;
}
@property (weak, nonatomic) IBOutlet UIImageView *background1;
@property (weak, nonatomic) IBOutlet UIButton *goButton;
@property (weak, nonatomic) IBOutlet UIImageView *ground2;
@property (weak, nonatomic) IBOutlet UIImageView *ground1;
@property (weak, nonatomic) IBOutlet UIImageView *startButtonImage;
@property (weak, nonatomic) IBOutlet UIImageView *birdPicture;
@property (weak, nonatomic) IBOutlet UIImageView *coinPicture;
- (IBAction)goPressed:(id)sender;
- (IBAction)gravityPressed:(id)sender;

- (IBAction)easyMode:(id)sender;
- (IBAction)mediumMode:(id)sender;
- (IBAction)hardMode:(id)sender;

@end
