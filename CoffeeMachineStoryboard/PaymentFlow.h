//
//  PaymentFlow.h
//  PickerViewTest
//
//  Created by dancho on 8/6/13.
//  Copyright (c) 2013 graci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>


@class CoffeeMachineState;
@class Drink;
@class MoneyAmount;

@interface PaymentFlow : UIViewController 

@property (strong) CoffeeMachineState *coffeeMachineState;
@property (strong) Drink *selectedDrink;
@property (weak, nonatomic) IBOutlet UIImageView *backImgView;
@property (strong) MoneyAmount *userCoins;
@property (strong, nonatomic) IBOutlet UIImageView *coinImg;
@property  CGPoint oldCoinPosition;
@property (strong, nonatomic) IBOutlet UILabel *sumLbl;
@property (strong, nonatomic) IBOutlet UIImageView *slotImg;
@property (strong, nonatomic) IBOutlet UILabel *remainingSum;
@property (weak, nonatomic) IBOutlet UIImageView *fiveImg;
@property (weak, nonatomic) IBOutlet UIImageView *tenImg;
@property (weak, nonatomic) IBOutlet UIImageView *twentyImg;
@property (weak, nonatomic) IBOutlet UIImageView *fiftyImg;
@property (weak, nonatomic) IBOutlet UIImageView *levImg;

-(void)rotateImage: (UIView*) image;
-(IBAction)handlePan:(UIPanGestureRecognizer *)recognizer;
-(void) moveCoin: (UIView*) image;
-(BOOL)didCoinImageIsInSlotImg: (UIView*)coinImage slotImage: (UIView*)slotImage : (int) pixSensitivity;
-(void)updateSum: (UIImageView*) image;
-(void)animatedSwitchMenu: (id)flow;
-(void)formatView;
-(void)remainingSumOfCoins;
@end
