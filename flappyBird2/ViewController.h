//
//  ViewController.h
//  flappyBird2
//
//  Created by Malcolm Geldmacher on 2/26/14.
//  Copyright (c) 2014 Malcolm Geldmacher. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    int x;
    int y;
    BOOL go;
    NSTimer * timer;
}
@property (weak, nonatomic) IBOutlet UIImageView *background1;
@property (weak, nonatomic) IBOutlet UIImageView *background2;
@property (weak, nonatomic) IBOutlet UIButton *goButton;
- (IBAction)goPressed:(id)sender;


@end
