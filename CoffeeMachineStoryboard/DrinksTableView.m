//
//  ViewController.m
//  PickerViewTest
//
//  Created by dancho on 8/6/13.
//  Copyright (c) 2013 graci. All rights reserved.
//

#import "DrinksTableView.h"
#import "PaymentFlow.h"
#import "Drink.h"
#import "DrinksContainer.h"
#import "CoffeeMachineState.h"
#import "MoneyAmount.h"
#import "AdministrationFlow.h"
#import "Theme.h"

@interface DrinksTableView ()

@end

@implementation DrinksTableView

#pragma mark -

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self formatView];
    DrinksContainer *drinks = [[ DrinksContainer alloc] init ];
    [drinks loadDrinksFromPlist];
    MoneyAmount *moneyAmount = [[MoneyAmount alloc] init];
   [moneyAmount loadCoinsFromPlist];
    [self cleanCurrentDrinks];
    if (self.coffeeMachineState == nil) {
        self.coffeeMachineState = [[CoffeeMachineState alloc] init];
        [self.coffeeMachineState setCurrentDrinksAmount:drinks];
        self.coffeeMachineState.coins = moneyAmount;
    }
    _itemsArrayDrinks = [[NSMutableArray alloc] initWithArray:[[_coffeeMachineState currentDrinks] drinksString]];
    _itemsArayDrinkPrices = [[NSMutableArray alloc] initWithArray:[[_coffeeMachineState currentDrinks] drinkPricesString]];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"MySegue"]) {
        AdministrationFlow *admin = (AdministrationFlow *)[segue destinationViewController];
        admin.coffeeMachineState = self.coffeeMachineState;
    }
    if ([[segue identifier] isEqualToString:@"DrinksToPayment"]) {
        
        PaymentFlow *paymentFlow = (PaymentFlow *)[segue destinationViewController];
        paymentFlow.coffeeMachineState = _coffeeMachineState;
        paymentFlow.selectedDrink = self.selectedDrink;
        paymentFlow.title = [self.selectedDrink description];
}
}


-(void)formatView
{
    Theme *theme = [Theme sharedTheme];
    self.title = @"Coffee Machine";
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[theme backGroudImage]];
    self.tableView.contentMode = UIViewContentModeScaleAspectFill;
   // UIBarButtonItem *adminButton = [[UIBarButtonItem alloc] initWithTitle:@"Admin" style:UIBarButtonItemStyleBordered target:self action:@selector(goToAdministrationFlow:)];
    //self.navigationItem.rightBarButtonItem = adminButton;
}

-(void)cleanCurrentDrinks
{
    for (Drink *storedDrink in [self.coffeeMachineState.currentDrinks.drinks allKeys]) {
        if([self.coffeeMachineState.currentDrinks.drinks[storedDrink] intValue] < 1)
            [self.coffeeMachineState.currentDrinks.drinks removeObjectForKey:storedDrink];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark === UITableView data source & delegate ===

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _itemsArrayDrinks.count;
}

- (NSInteger)numberOfSectionsInTableView :(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *) tableView:(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell=[[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"cell" ];
  if(cell == nil) {
      cell=[[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"cell" ];
  }
    cell.textLabel.textAlignment = NSTextAlignmentRight;
    UIImageView *drinkImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 277, 58)];
    drinkImage.backgroundColor = [UIColor clearColor];
    drinkImage.opaque = NO;
    drinkImage.image = [UIImage imageNamed:@"coffee-back.png"];
    NSUInteger count = [_itemsArrayDrinks count];
    NSString* currentDrinkPrice = [[NSString alloc]init];
    for (NSUInteger i = 0; i < count; i++) {
        if(indexPath.row==i){
            NSString *currentDrink = [_itemsArrayDrinks objectAtIndex: i];
            currentDrinkPrice = [_itemsArayDrinkPrices objectAtIndex: i];
            cell.textLabel.text=currentDrink;
            //cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.textLabel.backgroundColor = [UIColor clearColor];
            cell.backgroundView = drinkImage;
            cell.detailTextLabel.text = currentDrinkPrice;
            cell.detailTextLabel.textAlignment = NSTextAlignmentRight;
            cell.detailTextLabel.textColor = [UIColor blackColor];
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
            imgView.image = [UIImage imageNamed:@"kafe-1.png"];
            cell.imageView.image = imgView.image;
          }
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DrinksContainer* tempDrinkContainer = [[DrinksContainer alloc] init];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    PaymentFlow *paymentFlow = [[PaymentFlow alloc] init];
//    paymentFlow.coffeeMachineState = _coffeeMachineState;
   // NSString * tabTitle = [[NSString alloc]initWithString: _itemsArrayDrinks[indexPath.row]];
    //tabTitle = [tabTitle stringByAppendingString:@"  "];
   // tabTitle = [tabTitle stringByAppendingString: _itemsArayDrinkPrices[indexPath.row]];
   // paymentFlow.title = tabTitle;
    
    tempDrinkContainer = _coffeeMachineState.currentDrinksAmount;
    NSArray* tempDrinksArray = [[NSArray alloc] initWithArray:[tempDrinkContainer drinksArray]];
    self.selectedDrink = [tempDrinksArray objectAtIndex:indexPath.row];
    //paymentFlow.selectedDrink = [tempDrinksArray objectAtIndex:indexPath.row];
    [UIView  beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.75];
    //[self.navigationController pushViewController:paymentFlow animated:NO];
    [self performSegueWithIdentifier: @"DrinksToPayment" sender: self];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
    [UIView commitAnimations];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
}

- (void) alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *password = @"pass";
    if(alert.tag == 9998 && buttonIndex == 1) {
        NSString *e_pass = [[alert textFieldAtIndex:0]text ];
        if([e_pass isEqual:password]) {
            [self performSegueWithIdentifier: @"MySegue" sender: self];
            
         // AdministrationFlow *admin = [[AdministrationFlow alloc]init];
          //  admin.coffeeMachineState=self.coffeeMachineState;
         // [self.navigationController pushViewController:admin animated:YES];
          NSLog(@"%@", e_pass);
            

        }else{
            UIAlertView *wrongPassword = [[UIAlertView alloc] initWithTitle:@"Wrong Password" message:@"Try again"
                                                                   delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            wrongPassword.tag = 9999;
            [wrongPassword show];
        }
    }else if (alert.tag == 9999) {
        [self goToAdministrationFlow:nil];
    }
}

-(IBAction)goToAdministrationFlow:(id)sender
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Login"message:nil delegate:self cancelButtonTitle: @"Cancel"otherButtonTitles:@"Ok", nil];
    alertView.alertViewStyle = UIAlertViewStyleSecureTextInput;
    alertView.tag = 9998;
    [alertView show];
}

- (void) viewDidUnload
{
    [self.coffeeMachineState saveStateToFile];
}		

-(void)viewDidAppear:(BOOL)animated
{

   // _itemsArrayDrinks=[[NSMutableArray alloc]initWithArray:[[_coffeeMachineState currentDrinks] drinksString]];
  //  _itemsArayDrinkPrices=[[NSMutableArray alloc]initWithArray:[[_coffeeMachineState currentDrinks] drinkPricesString]];
 //  [self.tableView reloadData];

    [self cleanCurrentDrinks];
    _itemsArrayDrinks = [[NSMutableArray alloc] initWithArray:[[_coffeeMachineState currentDrinks] drinksString]];
    _itemsArayDrinkPrices = [[NSMutableArray alloc] initWithArray:[[_coffeeMachineState currentDrinks] drinkPricesString]];
    [self.tableView reloadData];
}

@end
