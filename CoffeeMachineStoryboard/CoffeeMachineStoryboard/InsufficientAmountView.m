//
//  InsufficientAmountFlow.m
//  PickerViewTest
//
//  Created by dancho on 8/21/13.
//  Copyright (c) 2013 graci. All rights reserved.
//

#import "InsufficientAmountView.h"
#import "OrderFinalizeView.h"
#import "DrinksTableView.h"
#import "Theme.h"
@interface InsufficientAmountView ()

@end

@implementation InsufficientAmountView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self formatView];
}

-(void)formatView
{
    Theme *theme = [Theme sharedTheme];
    self.backImageView.backgroundColor = [UIColor colorWithPatternImage:[theme backGroudImage]];
    self.backImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.notEnCoins.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1]; // changing style of label
    self.notEnCoins.shadowColor = [UIColor blackColor];
    [self.navigationItem.leftBarButtonItem setEnabled:NO];
    self.navigationItem.hidesBackButton = YES;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"InsufficientToFinalizeView"])
    {
        OrderFinalizeView *order = (OrderFinalizeView *)[segue destinationViewController];
        order.coffeeMachineState = self.coffeeMachineState;
        order.selectedDrink = self.selectedDrink;
        order.change = self.change;
        order.userCoins = self.userCoins;
        order.willGetDrink = _willGetDrink;// shows to orderFinalizeFlow that the custumer woun't get drink
    }
}



//switch to finalize flow, type: "make drink, don't return coins
- (IBAction)switchToFinalizeFlow:(id)sender {
    _willGetDrink = YES;
    [self switchMenu];
}

//switch to finalize flow, type: "don't make drink, return my coins", the name of method is bad, must be changed
- (IBAction)switchToDrinkListFlow:(id)sender {
    _willGetDrink = NO;
    [self switchMenu];
}

-(void)switchMenu
{
    //OrderFinalizeFlow *orderFinalizeFlow = [[OrderFinalizeFlow alloc]init];
    //orderFinalizeFlow.coffeeMachineState =self.coffeeMachineState;
   // orderFinalizeFlow.selectedDrink = self.selectedDrink;
   // orderFinalizeFlow.change = self.change;
   // orderFinalizeFlow.userCoins = self.userCoins;
    
    [UIView  beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.75];
    //[self.navigationController pushViewController:orderFinalizeFlow animated:YES];
    [self performSegueWithIdentifier:@"InsufficientToFinalizeView" sender: self];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
    [UIView commitAnimations];
}

@end











