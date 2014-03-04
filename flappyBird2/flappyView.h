//
//  flappyView.h
//  flappyBird2
//
//  Created by Brittny Wright on 2/28/14.
//  Copyright (c) 2014 Malcolm Geldmacher. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface flappyView : UIViewController
{
    
    NSMutableArray * collisionObjectsArray;
    int random;
    int sizeBetweenTubes;
    int tubeSpeed;
    int widthOfViewController;
    bool startTubeOne;
    bool startTubeTwo;
    int tubeWidth;
    int tubeHeight;
    int tubeBottomY;
    int tubeBottomX;
    int tubeTopX;
    int tubeTopY;
    NSTimer * gameLoopTimer;
    NSTimer * tubeTimer;
    NSTimer * groundTimer;
    NSTimer * birdFlapTimer;
    NSTimer * gravityTimer;
    BOOL go;
    float groundX;
    float groundY;
    BOOL startButtonDown;
    NSMutableArray * birdPics;
    int birdPicNum;
    BOOL wingsGoingUp;
    float birdY;
    float gravityConstant;
    float birdAccel;
    BOOL gravityOn;
    int timerCount;
}
@property (weak, nonatomic) IBOutlet UIImageView *background1;
@property (weak, nonatomic) IBOutlet UIButton *goButton;
@property (weak, nonatomic) IBOutlet UIImageView *ground2;
@property (weak, nonatomic) IBOutlet UIImageView *ground1;
@property (weak, nonatomic) IBOutlet UIImageView *startButtonImage;
@property (weak, nonatomic) IBOutlet UIImageView *birdPicture;
- (IBAction)goPressed:(id)sender;
- (IBAction)gravityPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *tubeBottomImage;
@property (weak, nonatomic) IBOutlet UIImageView *tubeBottomImage1;
@property (weak, nonatomic) IBOutlet UIImageView *tubeTopImage;
@property (weak, nonatomic) IBOutlet UIImageView *tubeTopImage1;

@end
