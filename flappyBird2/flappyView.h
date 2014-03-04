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
    //Tube Variables
    int random;
    int tubeTopX;
    int tubeTopY;
    int tubeSpeed;
    int tubeWidth;
    int tubeHeight;
    int tubeBottomY;
    int tubeBottomX;
    int sizeBetweenTubes;
    int widthOfViewController;
    bool startTubeOne;
    bool startTubeTwo;
    
    //Collision Variables
    NSMutableArray * collisionObjectsArray;
    
    //Background Variables
    float groundX;
    float groundY;
    
    //Bird Variables
    NSMutableArray * birdPics;
    int birdFall;
    int birdPicNum;
    float birdY;
    float birdAccel;
    BOOL dead;
    BOOL wingsGoingUp;
    
    //Gravity Variables
    float gravityConstant;
    BOOL gravityOn;
    
    //Timer Variables
    NSTimer * tubeTimer;
    NSTimer * fallTimer;
    NSTimer * groundTimer;
    NSTimer * gravityTimer;
    NSTimer * birdFlapTimer;
    NSTimer * gameLoopTimer;
    int timerCount;
    
    //Miscellaneous Variables
    BOOL go;
    BOOL startButtonDown;
    
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
@property (weak, nonatomic) IBOutlet UIImageView *coinPicture;


@end
