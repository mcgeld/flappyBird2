//
//  gameView.h
//  flappyBird2
//
//  Created by Brittny Wright on 2/27/14.
//  Copyright (c) 2014 Malcolm Geldmacher. All rights reserved.
//

int widthOfViewController=320;

#import <UIKit/UIKit.h>

@interface gameView : UIViewController
{
   
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
    int tubeSpeed;
}

@property (weak, nonatomic) IBOutlet UIImageView *background1;
@property (weak, nonatomic) IBOutlet UIButton *goButton;
@property (weak, nonatomic) IBOutlet UIImageView *ground2;
@property (weak, nonatomic) IBOutlet UIImageView *ground1;
@property (weak, nonatomic) IBOutlet UIImageView *startButtonImage;
@property (weak, nonatomic) IBOutlet UIImageView *birdPicture;
- (IBAction)goPressed:(id)sender;
- (IBAction)gravityPressed:(id)sender;



@property (strong, nonatomic) IBOutlet UIImageView *tubeBottomImage;

@property (strong, nonatomic) IBOutlet UIImageView *tubeBottomImage1;





@end
