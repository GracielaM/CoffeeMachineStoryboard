//
//  ViewController.h
//  PickerViewTest
//
//  Created by dancho on 8/6/13.
//  Copyright (c) 2013 graci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoffeeMachineState.h"

NSInteger globalPrice;

@interface DrinksTableView : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property(strong, nonatomic) NSMutableArray *itemsArrayDrinks;
@property(strong,nonatomic) NSMutableArray *itemsArayDrinkPrices;
@property(strong) CoffeeMachineState *coffeeMachineState;
@property(strong, nonatomic) UIAlertView *alertView;
@property(strong) Drink *selectedDrink;

-(IBAction)goToAdministrationFlow:(id)sender;
-(void)cleanCurrentDrinks;
-(void)formatView;

@end
