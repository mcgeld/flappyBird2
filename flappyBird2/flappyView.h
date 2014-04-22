//
//  flappyView.h
//  flappyBird2
//
//  Created by Brittny Wright on 2/28/14.
//  Copyright (c) 2014 Malcolm Geldmacher. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#include "dataBase.h"

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
    int tubeCounter;
   
    
    //Collision Variables
    NSMutableArray * collisionObjectsArray;
    NSMutableArray * deadCollisionObjectsArray;
    
    //Background Variables
    float groundX;
    float groundY;
    
    //Bird Variables
    int birdPassingCounter;
    bool birdIsPassingTube;
    NSMutableArray * birdPics;
    int flappyBirdLives;
    int birdFall;
    int birdPicNum;
    int birdAccelMax;
    float birdY;
    float birdAccel;
    BOOL dead;
    BOOL wingsGoingUp;
    BOOL done;
    BOOL flap;
    int flapMultiplier;
    int modifier;
    BOOL flash;
    int flashCount;
    
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
    NSTimer * birdFlashTimer;
    NSTimer * fasterFlashTimer;
    NSTimer * powerupFlashTimer;
    int fasterFlashCount;
    BOOL invalidateFaster;
    NSTimer * powerupFlashTimer;
    int timerCount;
    bool changeTimerOne;
    bool changeTimerTwo;
    
    //Coin Variables
    NSMutableArray *coinPics;
    NSMutableArray *coinCollisionArray;
    int coinRand;
    int coinSpeed;
    int coinPicNum;
    bool coinsBegan;
    bool startCoinOne;
    bool startCoinTwo;
    int coinCounter;
    bool coinWasHit;
    
    //Powerups variables
    NSMutableArray *powerupsCollisionArray;
    NSMutableArray *powerupsImageArray;
    int imageRand;
    int powerupRand;
    int powerupSpeed;
    int powerupTimer;
    int scoreMultiplier;
    bool powerupsBegan;
    bool startPowerupOne;
    bool startPowerupTwo;
    bool powerupWasHit;
    bool powerupHit;
    int canStartPowerUp;
    int powModifier;
    BOOL powFlash;
    int powFlashCount;
    
    
    //Miscellaneous Variables
    BOOL go;
    BOOL startButtonDown;
    
    //Multiplier Variables
    int multRand;
    
    //Sound Variables
    NSString * flapSound;
    NSString * hitSound;
    NSString * coinSound;
    NSString * powerupSound;
    
    
    
}

@property (strong, nonatomic) database * db;


@property (weak, nonatomic) IBOutlet UIImageView *background1;

@property (weak, nonatomic) IBOutlet UIImageView *ground2;
@property (weak, nonatomic) IBOutlet UIImageView *ground1;
@property (weak, nonatomic) IBOutlet UIImageView *startButtonImage;
@property (weak, nonatomic) IBOutlet UIImageView *birdPicture;
@property (weak, nonatomic) IBOutlet UIImageView *scoreboard;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *highScoreLabel;
@property (weak, nonatomic) IBOutlet UIButton *okButtonImage;
@property (weak, nonatomic) IBOutlet UIImageView *powerUpImage;
- (IBAction)okButton:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *flappyLivesLabel;
@property (weak, nonatomic) IBOutlet UIImageView *powerUpNotification;



//Tube Properties
@property (weak, nonatomic) IBOutlet UIImageView *tubeBottomImage;
@property (weak, nonatomic) IBOutlet UIImageView *tubeBottomImage1;
@property (weak, nonatomic) IBOutlet UIImageView *tubeTopImage;
@property (weak, nonatomic) IBOutlet UIImageView *tubeTopImage1;
@property (weak, nonatomic) IBOutlet UILabel *tubeCountLabel;

//Coin Properties
@property (weak, nonatomic) IBOutlet UIImageView *coinPicture;
@property (weak, nonatomic) IBOutlet UIImageView *coinPicture1;
@property (weak, nonatomic) IBOutlet UILabel *coinCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *fasterImage;



@end
