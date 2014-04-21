//
//  flappyView.m
//  flappyBird2
//
//  Created by Brittny Wright on 2/28/14.
//  Copyright (c) 2014 Malcolm Geldmacher. All rights reserved.
//

#import "flappyView.h"
#import "ViewController.h"

@implementation flappyView
@synthesize db=_db;
/******************OVERVIEW*********************
 "flappyView" is the view controller that handles the actual game play of the game. It handles everything about game play and is the main part of the game.
 **********************************************/


/***********************************************
 INITIALIZATION -- BEGIN
 ***********************************************/


/****************viewDidLoad********************
 PARAMS: NONE
 RETURNS: NONE
 DESCRIPTION: Called when the view loads. Handles most of the initialization needed for the game. Then  proceeds to the rest of the code.
 **********************************************/
- (void)viewDidLoad
{
    [self loadPlist];
  //  NSString * val= [_db getUser:0];
    [super viewDidLoad];
    [self setUpTubes];
    [self setUpCollisionObjects];
    [self setUpBackground];
    [self setUpBird];
    [self setUpGravity];
    [self setUpCoins];
    [self setUpPowerups];
    go = NO;
    _scoreboard.hidden = YES;
    _scoreLabel.hidden = YES;
    _highScoreLabel.hidden=YES;
    _okButtonImage.hidden = YES;
    _powerUpNotification.hidden = YES;
    scoreMultiplier=1;
    changeTimerOne=NO;
    changeTimerTwo=NO;
    
}

/****************setUpCoins**********************
 PARAMS: NONE
 RETURNS: NONE
 DESCRIPTION: Initializes and sets constants for coins.
 ***********************************************/
-(void)setUpCoins
{
    coinPics = [[NSMutableArray alloc]init];
    coinCollisionArray=[[NSMutableArray alloc] init];
    [coinCollisionArray addObject:_coinPicture];
    [coinCollisionArray addObject:_coinPicture1];
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
    _coinPicture1.image=coinImage;
    _coinPicture1.hidden=YES;
    _coinPicture.hidden=YES;
    coinRand=arc4random()%396;  //above ground
    coinSpeed=-1;
    startCoinOne=NO;
    startCoinTwo=NO;
    coinsBegan=NO;
    coinCounter=0;
    _coinCountLabel.text=@"0";
    coinWasHit=NO;
    
}

/****************setUpPowerups**********************
 PARAMS: NONE
 RETURNS: NONE
 DESCRIPTION: Initializes and sets constants for powerups.
 ***********************************************/
-(void)setUpPowerups
{
    powerupsCollisionArray=[[NSMutableArray alloc] init];
    powerupsImageArray=[[NSMutableArray alloc] init];
    [powerupsCollisionArray addObject:_powerUpImage];
    [powerupsImageArray addObject:@"oneUpMedal.png"];
    [powerupsImageArray addObject:@"scoreMultiplier.png"];
    [powerupsImageArray addObject:@"arrow.png"];
    [powerupsImageArray addObject:@"dash.jpg"];
    _powerUpImage.hidden=YES;
    powerupRand=arc4random()%396;  //above ground
    
    canStartPowerUp=0;
    powerupSpeed=-1;
    startPowerupOne=NO;
    startPowerupTwo=NO;
    powerupsBegan=NO;
    powerupWasHit=NO;
    powerupFlashTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(makePowerupNotificationFlash) userInfo:nil repeats:YES];
    powModifier = -1;
    powFlash = NO;
    powFlashCount = 0;
}



/****************setUpTubes**********************
 PARAMS: NONE
 RETURNS: NONE
 DESCRIPTION: Initializes and sets constants for tubes.
 ***********************************************/
-(void)setUpTubes
{
    widthOfViewController=320;
    sizeBetweenTubes=128;
    tubeWidth=59;
    tubeHeight=256;
    tubeBottomY=321;
    tubeBottomX=350;
    tubeTopX=350;
    tubeTopY=-107;
    tubeSpeed=-1;
    random=150;
    startTubeOne=YES;
    startTubeTwo=NO;
    
    _tubeBottomImage.hidden=YES;
    _tubeBottomImage1.hidden=YES;
    
    _tubeTopImage.hidden=YES;
    _tubeTopImage1.hidden=YES;
    _tubeCountLabel.text=@"0";
    tubeCounter=0;
    
    
}

/*************setUpCollisionObjects*************
 PARAMS: NONE
 RETURNS: NONE
 DESCRIPTION: Initializes and adds objects to a collision array for detecting collisions.
 **********************************************/
-(void)setUpCollisionObjects
{
    collisionObjectsArray=[[NSMutableArray alloc] init];
    
    [collisionObjectsArray addObject:_tubeBottomImage];
    [collisionObjectsArray addObject:_tubeBottomImage1];
    [collisionObjectsArray addObject:_tubeTopImage];
    [collisionObjectsArray addObject:_tubeTopImage1];
    //[collisionObjectsArray addObject:_ground1];
    //[collisionObjectsArray addObject:_ground2];
    
    deadCollisionObjectsArray = [[NSMutableArray alloc]init];
    [deadCollisionObjectsArray addObject:_ground1];
    [deadCollisionObjectsArray addObject:_ground2];
}

/*****************setUpBackground****************
 PARAMS: NONE
 RETURNS: NONE
 DESCRIPTION: Sets up and initializes both the static background and the moving foreground
 ***********************************************/
-(void)setUpBackground
{
    _background1.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    _ground1.frame = CGRectMake(0, self.view.frame.size.height - _ground1.frame.size.height, _ground1.frame.size.width, _ground1.frame.size.height);
    _ground2.frame = CGRectMake(self.view.frame.size.width, self.view.frame.size.height - _ground2.frame.size.height, _ground2.frame.size.width, _ground2.frame.size.height);
    
    groundY = self.view.frame.size.height - _ground1.frame.size.height;
    groundX = 0;
}

/******************setUpBird**********************
 PARAMS: NONE
 RETURNS: NONE
 DESCRIPTION: Sets up and initializes the bird view, the bird images array, and all the variables associated with the bird
 ************************************************/
-(void)setUpBird
{
    _birdPicture.frame = CGRectMake(_birdPicture.frame.origin.x, _birdPicture.frame.origin.y, 34, 24);
    flappyBirdLives=gameMode;   //gamemode gives 1 life for hard, 2 lives medium, and 3 easy.
    birdIsPassingTube=NO;
    birdPassingCounter=0;
    birdPics = [[NSMutableArray alloc]init];
    [birdPics addObject:@"flappyBirdFlying1.png"];
    [birdPics addObject:@"flappyBirdFlying2.png"];
    [birdPics addObject:@"flappyBirdFlying3.png"];
    _flappyLivesLabel.text=[NSString stringWithFormat:@"%d",flappyBirdLives];
    birdY = _birdPicture.frame.origin.y;
    birdPicNum = 0;
    birdAccel = 0;
    birdAccelMax = -10;
    wingsGoingUp = NO;
    dead = NO;
    flap = NO;
    flapMultiplier = -1;
    birdFlashTimer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(makeBirdFlash) userInfo:nil repeats:YES];
    modifier = -1;
    flash = NO;
    flashCount = 0;
}

/*********************setUpGravity****************
 PARAMS: NONE
 RETURNS: NONE
 DESCRIPTION: Initializes the variables associated with the gravity of the game
 ************************************************/
-(void)setUpGravity
{
    gravityConstant = 0.17;
    gravityOn = NO;
}


/*************************************************
 INITIALIZATION -- END
 ************************************************/



/*************************************************
 DEFAULTS -- BEGIN
 ************************************************/

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    [gravityTimer invalidate];
    [tubeTimer invalidate];
}

/*************************************************
 DEFAULTS -- END
 ************************************************/


/****************gameLoop*************************
 PARAMS: NONE
 RETURNS: NONE
 DESCRIPTION: The main loop of the game. Checks states of all situations, performs actions and updates states of all objects and views
 ************************************************/
-(void)gameLoop
{
    if(!dead)
    {
        [self updateTube];
        [self updateGround];
        [self updateGravity];
        [self updateCoinMovement];
        [self updatePowerupMovement];
        [self collisionChecking];
        [self updateRandomNumbers];
        if(timerCount == 10)
        {
            canStartPowerUp+=1;
        
            //[self updateFlaps];
            [self updateCoins];
            timerCount = 0;
        }
        if(tubeCounter>30&&changeTimerOne==NO)
        {
            
            [gameLoopTimer invalidate];
            gameLoopTimer=nil;
             gameLoopTimer = [NSTimer scheduledTimerWithTimeInterval:0.008 target:self selector:@selector(gameLoop) userInfo:nil repeats:YES];
            changeTimerOne=YES;
        }
        if(tubeCounter>80&&changeTimerTwo==NO)
        {
            
            [gameLoopTimer invalidate];
            gameLoopTimer=nil;
            gameLoopTimer = [NSTimer scheduledTimerWithTimeInterval:0.007 target:self selector:@selector(gameLoop) userInfo:nil repeats:YES];
            changeTimerTwo=YES;
        }
        if(birdIsPassingTube==YES)
        {
            birdPassingCounter+=1;
            if(birdPassingCounter<50)
            {
                //_birdPicture.alpha=.4;
            }
            else if(birdPassingCounter<120)
            {
                //_birdPicture.alpha=1;
            }
            else if(birdPassingCounter<160)
            {
                //_birdPicture.alpha=.4;
            }
            if(birdPassingCounter==160)
            {
                //_birdPicture.alpha=1;
                birdIsPassingTube=NO;
                birdPassingCounter=0;
            }
        }
        
        if(powerupHit==YES)
        {
            powerupTimer+=1;
            //NSLog(@"%d", powerupTimer);
            if(powerupTimer == 400)
            {
                powFlash = YES;
            }
            
            if(powerupTimer==650)
            {
                _powerUpNotification.hidden = YES;
                powFlash = NO;
                powerupHit=NO;
                powModifier = 1;
                scoreMultiplier=1;
                gravityConstant=0.17;
                powerupTimer=0;
                [gameLoopTimer invalidate];
                gameLoopTimer = nil;
                gameLoopTimer = [NSTimer scheduledTimerWithTimeInterval:0.009 target:self selector:@selector(gameLoop) userInfo:nil repeats:YES];
            }
        }
        //increase timerCount for updates not synchronous with gameLoop
    }
    else
    {
          _birdPicture.alpha=1;
        [self updateGravity];
        [self collisionChecking];
        if(timerCount == 10)
        {
            [self updateCoins];
            timerCount = 0;
        }
    }
    timerCount += 1;
    
}

/****************UpdateRandomNumbers******************
 PARAMS: NONE
 RETURNS: NONE
 DESCRIPTION: Updates the random numbers used for tubes and coins
 ************************************************/
-(void)updateRandomNumbers
{
    
    if(_tubeBottomImage.frame.origin.x<2||_tubeBottomImage1.frame.origin.x<2)
    {
        random=(arc4random()%238)*-1;
        coinRand=(arc4random()%396);  //above the ground
        powerupRand=(arc4random()%396);
        imageRand=arc4random()%10;
    }
}



/****************CollisionChecking*************************
 PARAMS: NONE
 RETURNS: NONE
 DESCRIPTION: Checks for any collisions involving the bird picture. I.E.(coins, death objects)
 ************************************************/
-(void)collisionChecking

{
    
    //collision checking
    
    CFBundleRef mainBundle = CFBundleGetMainBundle();
    CFURLRef soundFileURLRef;
    UInt32 soundID;
    
    
    
    if(!dead)
        
    {
        
        for(int i=0; i<[collisionObjectsArray count]; i++)
            
        {
            
            UIImageView *Bird=collisionObjectsArray[i];
            
            
            
            if(CGRectIntersectsRect(_birdPicture.frame, Bird.frame ))
                
            {
                
                if(birdIsPassingTube==NO)
                    
                {
                    hitSound = @"sfx_hit";
                    soundFileURLRef = CFBundleCopyResourceURL(mainBundle, (__bridge CFStringRef) hitSound, CFSTR ("wav"), NULL);
                    AudioServicesCreateSystemSoundID(soundFileURLRef, &soundID);
                    AudioServicesPlaySystemSound(soundID);
                    
                    flash = YES;
                    //_birdPicture.alpha=.5;
                    flappyBirdLives-=1;
                    
                    
                    
                    birdIsPassingTube=YES;
                    
                    if(flappyBirdLives==0)
                        
                    {
                        
                        dead = YES;
                        
                        birdAccel = 0;
                        
                        //[self gameOver];
                        
                    }
                    
                }
                
            }
            
        }
        
        
        
        for(int i=0; i<[deadCollisionObjectsArray count]; i++)
            
        {
            
            UIImageView *Bird=deadCollisionObjectsArray[i];
            
            
            
            if(CGRectIntersectsRect(_birdPicture.frame, Bird.frame ))
                
            {
                
                dead = YES;
                
                birdAccel = 0;
                
                //[self gameOver];
                
            }
            
        }
        
        
        
        //If the bird hits any coins.
        
        
        
        if(coinWasHit==NO)
            
        {
            
            for (int j=0; j<[coinCollisionArray count]; j++)
                
            {
                
                UIImageView * coinPicture=coinCollisionArray[j];
                
                if(CGRectIntersectsRect(coinPicture.frame, _birdPicture.frame))
                    
                {
                    coinSound = @"smw_coin";
                    soundFileURLRef = CFBundleCopyResourceURL(mainBundle, (__bridge CFStringRef) coinSound, CFSTR ("wav"), NULL);
                    AudioServicesCreateSystemSoundID(soundFileURLRef, &soundID);
                    AudioServicesPlaySystemSound(soundID);
                    
                    coinCounter += scoreMultiplier;
                    
                    coinPicture.hidden=YES;
                    
                    _coinCountLabel.text = [NSString stringWithFormat:@"%d", coinCounter];
                    
                    coinWasHit=YES;
                    
                }
                
            }
            
        }
        
        if(powerupWasHit==NO)
            
        {
            
            for (int j=0; j<[powerupsCollisionArray count]; j++)
                
            {
                
                UIImageView * powerupPicture=powerupsCollisionArray[j];
              
                if(CGRectIntersectsRect(powerupPicture.frame, _birdPicture.frame)&&canStartPowerUp>15)
                    
                {
                    
                    powerupHit=YES;
                    if([powerupPicture.image isEqual:[UIImage imageNamed:@"dash.jpg"]])
                    {
                        powerupSound = @"here_we_go";
                        soundFileURLRef = CFBundleCopyResourceURL(mainBundle, (__bridge CFStringRef) powerupSound, CFSTR ("wav"), NULL);
                        AudioServicesCreateSystemSoundID(soundFileURLRef, &soundID);
                        AudioServicesPlaySystemSound(soundID);
                        
                        _powerUpNotification.image = [UIImage imageNamed:@"dash.jpg"];
                        _powerUpNotification.hidden = NO;
                        
                        powerupPicture.hidden=YES;
                    
                        powerupWasHit=YES;
                        
                        //gravityConstant *= 2;
                        
                        [gameLoopTimer invalidate];
                        
                        gameLoopTimer = [NSTimer scheduledTimerWithTimeInterval:0.006 target:self selector:@selector(gameLoop) userInfo:nil repeats:YES];
                        
                    }
                    
                    
                    
                    if([powerupPicture.image isEqual:[UIImage imageNamed:@"oneUpMedal.png"]])
                        
                    {
                        
                        if(powerupPicture.hidden==NO)
                            
                        {
                            powerupSound = @"smw_power_up";
                            soundFileURLRef = CFBundleCopyResourceURL(mainBundle, (__bridge CFStringRef) powerupSound, CFSTR ("wav"), NULL);
                            AudioServicesCreateSystemSoundID(soundFileURLRef, &soundID);
                            AudioServicesPlaySystemSound(soundID);
                            
                            flappyBirdLives+=1;
                            
                            powerupPicture.hidden=YES;
                            
                            powerupWasHit=YES;
                            
                        }
                        
                    }
                    
                    
                    
                    if([powerupPicture.image isEqual:[UIImage imageNamed:@"scoreMultiplier.png"]])
                        
                    {
                        powerupSound = @"score_mult";
                        soundFileURLRef = CFBundleCopyResourceURL(mainBundle, (__bridge CFStringRef) powerupSound, CFSTR ("wav"), NULL);
                        AudioServicesCreateSystemSoundID(soundFileURLRef, &soundID);
                        AudioServicesPlaySystemSound(soundID);
                        
                        _powerUpNotification.image = [UIImage imageNamed:@"scoreMultiplier.png"];
                        _powerUpNotification.hidden = NO;
                    
                        powerupPicture.hidden=YES;
                        
                        powerupWasHit=YES;
                        
                        scoreMultiplier=2;
                        
                        
                        
                    }
                    
                    if([powerupPicture.image isEqual:[UIImage imageNamed:@"arrow.png"]])
                    {
                        powerupSound = @"blip";
                        soundFileURLRef = CFBundleCopyResourceURL(mainBundle, (__bridge CFStringRef) powerupSound, CFSTR ("wav"), NULL);
                        AudioServicesCreateSystemSoundID(soundFileURLRef, &soundID);
                        AudioServicesPlaySystemSound(soundID);
                        
                        _powerUpNotification.image = [UIImage imageNamed:@"arrow.png"];
                        _powerUpNotification.hidden = NO;
                    
                        powerupPicture.hidden=YES;
                        powerupWasHit=YES;
                        gravityConstant *= 1.5;
                    }
                    
                    
                }
                
            }
            
        }
        
    }
    
    else
        
    {
        
        
        
        for(int i=0; i<[deadCollisionObjectsArray count]; i++)
            
        {
            
            UIImageView *object=deadCollisionObjectsArray[i];
            
            
            
            if(CGRectIntersectsRect(_birdPicture.frame, object.frame ))
                
            {
                
                done = YES;
                
                birdAccel = 0;
                
                
                [self showScore];
                
            }
            
        }
        
    }
    
    
    
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
    if(flap)
    {
        flapSound = @"sfx_wing";
        
        CFBundleRef mainBundle = CFBundleGetMainBundle();
        CFURLRef soundFileURLRef;
        
        
        
        soundFileURLRef = CFBundleCopyResourceURL(mainBundle, (__bridge CFStringRef) flapSound, CFSTR ("wav"), NULL);
        UInt32 soundID;
        AudioServicesCreateSystemSoundID(soundFileURLRef, &soundID);
        
        
        [UIView animateWithDuration:0.01
                     animations:^(void)
         {
             _birdPicture.image = [UIImage imageNamed:birdPics[birdPicNum]];
         }
                     completion:^(BOOL finished){}];
        if(birdPicNum == [birdPics count] - 1)
        {
            birdPicNum = [birdPics count] - 2;
            flapMultiplier *= -1;
            //wingsGoingUp = YES;
            AudioServicesPlaySystemSound(soundID);
        }
        else if(birdPicNum == 0)
        {
            birdPicNum = 1;
            flap = NO;
            //wingsGoingUp = NO;
        }
        else
        {
            birdPicNum += 1 * flapMultiplier;
        }
    }
}

-(void)updateGravity
{
    if(_birdPicture.frame.origin.y <= 0)
    {
        birdAccel = 0;
        [UIView animateWithDuration:0.01
                         animations:^(void)
         {
             _birdPicture.frame = CGRectMake(_birdPicture.frame.origin.x, 1, _birdPicture.frame.size.width, _birdPicture.frame.size.height)   ;
         }
                         completion:^(BOOL finished){}];
    }
    else
    {
        [UIView animateWithDuration:0.01
                         animations:^(void)
         {
             _birdPicture.frame = CGRectMake(_birdPicture.frame.origin.x, _birdPicture.frame.origin.y - birdAccel, _birdPicture.frame.size.width, _birdPicture.frame.size.height)   ;
         }
                         completion:^(BOOL finished){}];
    }
    birdAccel -= gravityConstant;
    if(birdAccel < birdAccelMax)
    {
        birdAccel = birdAccelMax;
    }
}

-(void)updateCoins
{
    [UIView animateWithDuration:0.1 animations:^(void){
        UIImage * newImage = [UIImage imageNamed:coinPics[coinPicNum]];
        _coinPicture.image = newImage;
        _coinPicture1.image= newImage;
    }completion:^(BOOL finished){}];
    coinPicNum += 1;
    //NSLog([NSString stringWithFormat:@"%d", coinPicNum]);
    if(coinPicNum == [coinPics count])
    {
        coinPicNum = 0;
    }
}

/****************UpdateTubes**********************
 PARAMS: NONE
 RETURNS: NONE
 DESCRIPTION: Updates the tubes movment. Checks for collisions. And updates the tube label counter.
 ***********************************************/
-(void)updateTube
{
    
    
    
    _flappyLivesLabel.text=[NSString stringWithFormat:@"%d", flappyBirdLives];
    _tubeCountLabel.text=[NSString stringWithFormat:@"%d",tubeCounter];
    
    
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




/******************UpdateCoinMovement***********
 PARAMS: NONE
 RETURNS: NONE
 DESCRIPTION: Updates coin movement across the screen.
 ***********************************************/
-(void)updateCoinMovement
{
    if(coinCounter>=10)      //if they get 5 coins, they recieve and extra life
    {
        coinCounter-=10;
        _coinCountLabel.text=[NSString stringWithFormat:@"%i",coinCounter];
        flappyBirdLives+=1;
    }
    
    
    
    if(_tubeBottomImage.frame.origin.x<160) // 160== half way acroos the screen
    {
        startCoinOne=YES;
        
    }
    if(_tubeBottomImage1.frame.origin.x<160&&_tubeBottomImage1.frame.origin.x>158)
    {
        tubeCounter+=scoreMultiplier;
        
        
    }
    if(_tubeBottomImage.frame.origin.x<160&&_tubeBottomImage.frame.origin.x>158)
    {
        tubeCounter+=scoreMultiplier;
        
        
    }
    
    
    
    
    if(startCoinOne==YES)
    {
        _coinPicture.frame=CGRectMake(_coinPicture.frame.origin.x+coinSpeed, _coinPicture.frame.origin.y, _coinPicture.frame.size.width, _coinPicture.frame.size.height);
    }
    if(startCoinTwo==YES)
    {
        _coinPicture1.frame=CGRectMake(_coinPicture1.frame.origin.x+coinSpeed, _coinPicture1.frame.origin.y, _coinPicture1.frame.size.width, _coinPicture1.frame.size.height);
        
    }
    
    
    if(_coinPicture.frame.origin.x<0)
    {
        startCoinTwo=YES;
    }
    if(_coinPicture1.frame.origin.x<0)
    {
        startCoinOne=YES;
    }
    
    if(_coinPicture.frame.origin.x<(_coinPicture.frame.size.width*-1))
    {
        _coinPicture.hidden=NO;
        coinWasHit=NO;
        startCoinOne=NO;
        _coinPicture.frame=CGRectMake(tubeBottomX, coinRand, _coinPicture.frame.size.width, _coinPicture.frame.size.height);
    }
    if(_coinPicture1.frame.origin.x<(_coinPicture1.frame.size.width*-1))
    {
        _coinPicture1.hidden=NO;
        coinWasHit=NO;
        startCoinTwo=NO;
        _coinPicture1.frame=CGRectMake(tubeBottomX, coinRand, _coinPicture.frame.size.width, _coinPicture.frame.size.height);
    }
    
    
}

/******************UpdatePowerupMovement***********
 PARAMS: NONE
 RETURNS: NONE
 DESCRIPTION: Updates coin movement across the screen.
 ***********************************************/
-(void)updatePowerupMovement
{
    
    
    
    if(_tubeBottomImage.frame.origin.x<160) // 160== half way acroos the screen
    {
        if(arc4random()%4==1)
        {
            startPowerupOne=YES;
            
        }
        
    }
    
    
    if(startPowerupOne==YES)
    {
        _powerUpImage.frame=CGRectMake(_powerUpImage.frame.origin.x+powerupSpeed, _powerUpImage.frame.origin.y, _powerUpImage.frame.size.width, _powerUpImage.frame.size.height);
    }
    
    
    
    if(_powerUpImage.frame.origin.x<(_powerUpImage.frame.size.width*-1))
    {
        
        if(powerupHit==NO)
        {
            _powerUpImage.hidden=NO;
            powerupWasHit=NO;
            startPowerupOne=NO;
            _powerUpImage.frame=CGRectMake(tubeBottomX, powerupRand, _powerUpImage.frame.size.width, _powerUpImage.frame.size.height);
            if(CGRectIntersectsRect(_powerUpImage.frame, _tubeBottomImage.frame)||CGRectIntersectsRect(_powerUpImage.frame, _tubeBottomImage1.frame)||CGRectIntersectsRect(_powerUpImage.frame, _tubeTopImage.frame)||CGRectIntersectsRect(_powerUpImage.frame, _tubeTopImage1.frame))
            {
                _powerUpImage.frame=CGRectMake(tubeBottomX+(_tubeTopImage.frame.size.width+_tubeTopImage.frame.size.width), powerupRand, _powerUpImage.frame.size.width, _powerUpImage.frame.size.height);
            }
            [self changePowerupImage];
            
        }
    }
}

-(void)changePowerupImage
{
    if(imageRand<2)
    {
        _powerUpImage.image=[UIImage imageNamed:powerupsImageArray[1]];
    }
    else if(imageRand<5)
    {
        _powerUpImage.image=[UIImage imageNamed:powerupsImageArray[2]];
    }
    else if(imageRand<8)
    {
        _powerUpImage.image=[UIImage imageNamed:powerupsImageArray[3]];
    }
    else
    {
         _powerUpImage.image=[UIImage imageNamed:powerupsImageArray[0]];
    }
    
}

- (void)goPressed
{
    if(!go)
    {
        gameLoopTimer = [NSTimer scheduledTimerWithTimeInterval:0.009 target:self selector:@selector(gameLoop) userInfo:nil repeats:YES];

        birdFlapTimer = [NSTimer scheduledTimerWithTimeInterval:0.07 target:self selector:@selector(updateFlaps) userInfo:nil repeats:YES];
        
        
        _coinPicture.frame=CGRectMake(tubeBottomX, coinRand, _coinPicture.frame.size.width, _coinPicture.frame.size.height);
        _coinPicture.hidden=NO;
        _coinPicture1.frame=CGRectMake(tubeBottomX, coinRand, _coinPicture.frame.size.width, _coinPicture.frame.size.height);
        _coinPicture1.hidden=NO;
        
        _tubeBottomImage.frame=CGRectMake(tubeBottomX, tubeBottomY, _tubeBottomImage.frame.size.width, _tubeBottomImage.frame.size.height);
        _tubeBottomImage1.frame=CGRectMake(tubeBottomX, tubeBottomY, _tubeBottomImage1.frame.size.width, _tubeBottomImage1.frame.size.height);
        _tubeTopImage.frame=CGRectMake(tubeTopX, tubeTopY, _tubeTopImage.frame.size.width, _tubeTopImage.frame.size.height);
        _tubeTopImage1.frame=CGRectMake(tubeTopX, tubeTopY, _tubeTopImage1.frame.size.width, _tubeTopImage1.frame.size.height);
        _tubeBottomImage1.hidden=NO;
        _tubeBottomImage.hidden=NO;
        _tubeTopImage1.hidden=NO;
        _tubeTopImage.hidden=NO;
        
        _startButtonImage.frame=CGRectMake(tubeBottomX, tubeBottomY, _startButtonImage.frame.size.width, _startButtonImage.frame.size.height);
        
        go = YES;
        
    }
    else
    {
        [tubeTimer invalidate];
        [groundTimer invalidate];
        [birdFlapTimer invalidate];
        go = NO;
        
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(!dead)
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
            flap = YES;
            flapMultiplier = 1;
            birdAccel = 4.7;
        }
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(!dead)
    {
        UITouch * curTouch = [touches anyObject];
        CGPoint curTouchPoint = [curTouch locationInView:self.view];
        if(startButtonDown && CGRectContainsPoint(_startButtonImage.frame, curTouchPoint))
        {
            _startButtonImage.hidden=YES;
            [_startButtonImage setFrame:CGRectMake(_startButtonImage.frame.origin.x, _startButtonImage.frame.origin.y - 2, _startButtonImage.frame.size.width, _startButtonImage.frame.size.height)];
            startButtonDown = NO;
            [self goPressed];
            //  [self gravityPressed:event];
        }
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

-(void)makeBirdFlash
{
    if(flash)
    {
        _birdPicture.alpha = _birdPicture.alpha + 0.75 * modifier;
        modifier *= -1;
        flashCount += 1;
    }
    if(flashCount == 20)
    {
        flash = NO;
        flashCount = 0;
        modifier = -1;
    }
}

-(void)makePowerupNotificationFlash
{
    if(powFlash)
    {
        _powerUpNotification.alpha = _powerUpNotification.alpha + 0.75 * powModifier;
        powModifier *= -1;
        powFlashCount += 1;
    }
    
    else{
        powFlash = NO;
        powFlashCount = 0;
        powModifier = -1;
    }
}

-(void)makeBirdFall
{
   
    [UIView animateWithDuration:0.01
                     animations:^(void)
     {
         _birdPicture.frame = CGRectMake(_birdPicture.frame.origin.x, birdFall, _birdPicture.frame.size.width, _birdPicture.frame.size.height);
     }
                     completion:^(BOOL finished){}];
    if(_birdPicture.frame.origin.y + _birdPicture.frame.size.height >= _ground1.frame.origin.y)
    {
        [self finish];
    }
    birdFall -= birdAccel;
}

-(void)dropBird
{
    
    birdFall = _birdPicture.frame.origin.y;
    fallTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(updateGravity) userInfo:nil repeats:YES];
}

-(void)gameOver
{
  
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:2];
    _birdPicture.center=CGPointMake(_birdPicture.center.x, _birdPicture.center.y);
    _birdPicture.transform = CGAffineTransformMakeRotation(234 * (M_PI / 180));
    [UIView commitAnimations];
    sleep(1.9);
    //[self dropBird];
    [self finish];
}

-(void)showScore
{
    NSMutableArray * sizeOfData=[_db getDB];
    if([sizeOfData count]>3)
    {
    
    NSString * val= [_db getUser:(gameMode-1)];
    int value=[val intValue];
        if(tubeCounter>value)
        {
            [_db removeUser:(gameMode-1)];
            val=[NSString stringWithFormat:@"%i",tubeCounter];
            [_db addUser:val atIndex:(gameMode-1)];
            _highScoreLabel.text = val;
        }
        else
        {
            [_db removeUser:(gameMode-1)];
            val=[NSString stringWithFormat:@"%i",value];
            [_db addUser:val atIndex:(gameMode-1)];
            _highScoreLabel.text = val;
        }
    }
    else
    {
        NSString *zero=[NSString stringWithFormat:@"%i",0];
        [_db addUser:zero atIndex:0];
        [_db addUser:zero atIndex:1];
        [_db addUser:zero atIndex:2];
        NSString * val=[NSString stringWithFormat:@"%i",tubeCounter];
        [_db removeUser:(gameMode-1)];
         [_db addUser:val atIndex:(gameMode-1)];
        _highScoreLabel.text = val;
    }
        
        NSString * tubeCountStr = [NSString stringWithFormat:@"%d", tubeCounter];
    
   
    [_db savePlist:[_db getDB]];
    //  NSString * coinCountStr = [NSString stringWithFormat:@"%d", coinCounter];
    _scoreLabel.text = tubeCountStr;
    
    _highScoreLabel.hidden=NO;
    _scoreboard.hidden = NO;
    _scoreLabel.hidden = NO;
    _okButtonImage.hidden = NO;
    _powerUpNotification.hidden = YES;

    
    
}

-(void)finish
{
    [fallTimer invalidate];
    [gravityTimer invalidate];
    [groundTimer invalidate];
    [tubeTimer invalidate];
    [gameLoopTimer invalidate];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)okButton:(id)sender
{
    if(_okButtonImage.hidden == NO)
        [self finish];
}

-(void)enterUser:(NSString *)sender
{
 
        [_db addUser:sender];
    
   // NSLog(sender);
        [_db savePlist:[_db getDB]];
    
    
}


-(void)loadPlist
{
    NSString * plistPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0] stringByAppendingPathComponent:@"database.plist"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath])
    {
        plistPath = [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"plist"];
    }
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    
    _db = [[database alloc] initWithArray:(NSMutableArray *)[NSPropertyListSerialization propertyListFromData:plistXML mutabilityOption:NSPropertyListMutableContainersAndLeaves format:&format errorDescription:&errorDesc]];
}

-(void)loadBinary
{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"database.db"];
    _db = [[database alloc] initWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:path]];
}


@end