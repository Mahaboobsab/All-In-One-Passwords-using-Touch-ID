//
//  AllPasswords.m
//  AllMyPasswords
//
//  Created by Mahaboobsab Nadaf on 14/10/16.
//  Copyright © 2016 com.NeoRays. All rights reserved.
//

#import "AllPasswords.h"

@interface AllPasswords ()

@end

@implementation AllPasswords{

    NSMutableArray *shortResults;
    NSManagedObject *allTitles;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   // self.employeeObjects = [[NSMutableArray alloc] init];
    [self fetchData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  shortResults.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
 
    allTitles = [shortResults objectAtIndex:indexPath.row];
    
  
    
    cell.title.text = [allTitles valueForKey:@"title"];
    
   
    cell.userName.text = [NSString stringWithFormat:@"User Name : %@",[allTitles valueForKey:@"userName"] ];
    cell.password.text = [NSString stringWithFormat:@"Password : %@",[allTitles valueForKey:@"password"] ];
    return cell;
}




















- (IBAction)addButton:(id)sender{
    UIAlertController* controller=[UIAlertController alertControllerWithTitle:@"Add Details" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    
    [controller addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder=@"Enter Title";
        
    }];
    
    [controller addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder=@"Enter User Name";
        
    }];
    
    [controller addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder=@"Enter Password";
        
    }];
    
    
    
    
    UIAlertAction* alertaction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        UITextField* title = [controller.textFields objectAtIndex:0];
        
      
        
        UITextField* userName = [controller.textFields objectAtIndex:1];
          UITextField* password = [controller.textFields objectAtIndex:2];
        
        
        
        NSManagedObjectContext* context=[self getContext];
        NSManagedObject* emp=[NSEntityDescription insertNewObjectForEntityForName:@"AllPasswords" inManagedObjectContext:context];
        [emp setValue:title.text forKey:@"title"];
        
        
        [emp setValue:userName.text forKey:@"userName"];
        [emp setValue:password.text forKey:@"password"];
        NSError* error=nil;
        
        if (![context save:&error
              ]) {
            NSLog(@"Failed to save data");
        }
        else{
            
            NSLog(@"Saved Data");
        }
        
        
        [self fetchData];
        
    }];
    
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                       
                                   }];
    
    
    [controller addAction:alertaction];
    [controller addAction:cancelAction];
    
    [self presentViewController:controller animated:YES completion:nil];
    
    
    [self fetchData];
    [self.myTableView reloadData];
    
}




-(void)fetchData{
    
    NSManagedObjectContext* context=[self getContext];
    NSFetchRequest* req=[[NSFetchRequest alloc] initWithEntityName:@"AllPasswords"];
    NSError* error=nil;
    
    self.employeeObjects=[[NSMutableArray alloc] initWithArray:[context executeFetchRequest:req error:&error]];
    
    //Taking temp var to hold values for Search
    shortResults = [[NSMutableArray alloc]initWithArray:self.employeeObjects];
    
    [self.myTableView reloadData];
    
}


-(NSManagedObjectContext *)getContext{
    
    AppDelegate *App = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    NSManagedObjectContext *context = [App persistentContainer].viewContext;
    
    return context;
    
}
- (IBAction)swifeLeft:(id)sender {
    
    CGPoint location = [sender locationInView:self.myTableView];
    self.selectedPath = [self.myTableView indexPathForRowAtPoint:location];
    
    TableViewCell *cell = [self.myTableView cellForRowAtIndexPath:self.selectedPath];
    
    cell.editButtonOutlet.hidden = NO;
    cell.deleteButtonOutlet.hidden = NO;
}

- (IBAction)deleteButton:(UIButton*)sender {
    
    
    
    NSIndexPath *indexPath = [self.myTableView indexPathForCell:(TableViewCell *)sender.superview.superview];
    
    NSManagedObjectContext *context = [self getContext];
    
    [context deleteObject:[shortResults objectAtIndex:indexPath.row]];
    
    NSError *error = nil;
    [context save:&error];
    
    TableViewCell *cell = [_myTableView cellForRowAtIndexPath:indexPath];
    
    [shortResults removeObjectAtIndex:indexPath.row];
    cell.editButtonOutlet.hidden = YES;
    cell.deleteButtonOutlet.hidden = YES;
    
    
    [self.myTableView reloadData];
    
    
    
}

- (IBAction)swipeRight:(id)sender {
    
    CGPoint location = [sender locationInView:self.myTableView];
    self.selectedPath = [self.myTableView indexPathForRowAtPoint:location];
    
    TableViewCell *cell = [self.myTableView cellForRowAtIndexPath:self.selectedPath];
    
    cell.editButtonOutlet.hidden = YES;
    cell.deleteButtonOutlet.hidden = YES;
}



- (IBAction)editButton:(UIButton *)sender {
    
    
    NSManagedObject *employeeObject =[ shortResults objectAtIndex:self.selectedPath.row];
    
    
    UIAlertController* controller=[UIAlertController alertControllerWithTitle:@"Re-Enter Details" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    
    [controller addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        textField.text=[employeeObject valueForKey:@"title"];
        
    }];
    
  
    [controller addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text=[employeeObject valueForKey:@"userName"];
        
    }];
    
    [controller addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text=[employeeObject valueForKeyPath:@"Password"];
    }];
    
    
    UIAlertAction* alertaction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        UITextField* title = [controller.textFields objectAtIndex:0];
        
        UITextField* userName = [controller.textFields objectAtIndex:1];
        
        UITextField* password = [controller.textFields objectAtIndex:2];
        
       
        
        
        NSIndexPath *indexPath = [self.myTableView indexPathForCell:(TableViewCell *)sender.superview.superview];
        
        
        NSManagedObjectContext* context=[self getContext];
        
        
        [employeeObject setValue:title.text forKey:@"title"];
        
       
        [employeeObject setValue:password.text forKey:@"password"];
        [employeeObject setValue:userName.text forKey:@"userName"];
        NSError* error=nil;
        
        if (![context save:&error
              ]) {
            NSLog(@"Failed to save data");
        }
        else{
            
            NSLog(@"Saved Data");
        }
        
        
        
        
        
        
        
        
        TableViewCell *cell = [_myTableView cellForRowAtIndexPath:indexPath];
        
        
        cell.editButtonOutlet.hidden = YES;
        cell.deleteButtonOutlet.hidden = YES;
        [self fetchData];
        
    }];
    
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                       
                                   }];
    
    
    [controller addAction:alertaction];
    [controller addAction:cancelAction];
    
    [self presentViewController:controller animated:YES completion:nil];
    
    
    [self fetchData];
    [self.myTableView reloadData];
    
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if (searchText.length == 0) {
        
        //removes all objects of shortResults when Search text is nil and reload all Objects again
        [shortResults removeAllObjects];
        
        [shortResults addObjectsFromArray:self.employeeObjects];
    }
    
    
    else{
        
        //removes Previously Loaded Data to reload new Search
        [shortResults removeAllObjects];
        
        for (allTitles in shortResults) {
            
            //Stores the object according to searchText and artistName in artObject
            
            //NSRange is used to count number of serch results after searching
            NSRange r=[[allTitles valueForKey:
                        @"title"] rangeOfString:searchText];
            //options:NSCaseInsensitiveSearch
            
            
            //If Object Found According to Search
            if (r.location!=NSNotFound) {
                
                //Stores the Searched objects in mutableArray shortResults
                [shortResults addObject:allTitles];
            }
        }
    }
    
    //Reloads the Table View
    [self.myTableView reloadData];
}
@end
