//
//  flappyView.m
//  flappyBird2
//
//  Created by Brittny Wright on 2/28/14.
//  Copyright (c) 2014 Malcolm Geldmacher. All rights reserved.
//

#import "flappyView.h"

@implementation flappyView
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
    _okButtonImage.hidden = YES;
    scoreMultiplier=1;
    
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
    
    
    powerupSpeed=-1;
    startPowerupOne=NO;
    startPowerupTwo=NO;
    powerupsBegan=NO;
    powerupWasHit=NO;
}

-(void)setUpMultiplier
{
    
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
    flappyBirdLives=1;
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
            [self updateFlaps];
            [self updateCoins];
            timerCount = 0;
        }
        if(birdIsPassingTube==YES)
        {
            birdPassingCounter+=1;
            if(birdPassingCounter==100)
            {
                birdIsPassingTube=NO;
                birdPassingCounter=0;
            }
        }
        
        if(powerupHit==YES)
        {
            powerupTimer+=1;
            //NSLog(@"%d", powerupTimer);
            if(powerupTimer==600)
            {
                powerupHit=NO;
                scoreMultiplier=1;
                gravityConstant=0.17;
                powerupTimer=0;
            }
        }
        //increase timerCount for updates not synchronous with gameLoop
    }
    else
    {
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
        imageRand=arc4random()%4;
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
    
    if(!dead)
        
    {
        
        for(int i=0; i<[collisionObjectsArray count]; i++)
            
        {
            
            UIImageView *Bird=collisionObjectsArray[i];
            
            
            
            if(CGRectIntersectsRect(_birdPicture.frame, Bird.frame ))
                
            {
                
                if(birdIsPassingTube==NO)
                    
                {
                    
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
                
                if(CGRectIntersectsRect(powerupPicture.frame, _birdPicture.frame))
                    
                {
                    
                    powerupHit=YES;
                    
                    if([powerupPicture.image isEqual:[UIImage imageNamed:@"arrow.png"]])
                        
                    {
                        
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
                            
                            flappyBirdLives+=1;
                            
                            powerupPicture.hidden=YES;
                            
                            powerupWasHit=YES;
                            
                        }
                        
                    }
                    
                    
                    
                    if([powerupPicture.image isEqual:[UIImage imageNamed:@"scoreMultiplier.png"]])
                        
                    {
                        
                        powerupPicture.hidden=YES;
                        
                        powerupWasHit=YES;
                        
                        scoreMultiplier=2;
                        
                        
                        
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
            [self changePowerupImage];
            
        }
    }
}

-(void)changePowerupImage
{
    _powerUpImage.image=[UIImage imageNamed:powerupsImageArray[imageRand]];
}

- (void)goPressed
{
    if(!go)
    {
        gameLoopTimer = [NSTimer scheduledTimerWithTimeInterval:0.009 target:self selector:@selector(gameLoop) userInfo:nil repeats:YES];
        
        
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
    NSString * tubeCountStr = [NSString stringWithFormat:@"%d", tubeCounter];
    NSString * coinCountStr = [NSString stringWithFormat:@"%d", coinCounter];
    _scoreLabel.text = tubeCountStr;
    _scoreboard.hidden = NO;
    _scoreLabel.hidden = NO;
    _okButtonImage.hidden = NO;
    
    
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

@end
