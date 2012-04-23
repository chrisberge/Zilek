//
//  ChoixVilleController3.m
//  Zilek
//
//  Created by Christophe Bergé on 04/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ChoixVilleController3.h"

@implementation ChoixVilleController3

@synthesize selection, searching, letUserSelectRow, resultsController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(setCriteres:) name:@"setCriteres" object: nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"getCriteres" object: nil];
    
    //HEADER
    UIImageView *enTete = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header.png"]];
    [enTete setFrame:CGRectMake(0,0,320,50)];
    [self.view addSubview:enTete];
    [enTete release];
    
    //BOUTON RETOUR
    UIButton *boutonRetour = [UIButton buttonWithType:UIButtonTypeCustom];
    boutonRetour.showsTouchWhenHighlighted = NO;
    boutonRetour.tag = 0;
    
    [boutonRetour setFrame:CGRectMake(10,7,50,30)];
    [boutonRetour addTarget:self action:@selector(buttonPushed:) 
           forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *image = [UIImage imageNamed:@"bouton-retour.png"];
    [boutonRetour setImage:image forState:UIControlStateNormal];
    
    [self.view addSubview:boutonRetour];
    
	//Set the title
	//self.navigationItem.title = @"Villes";
	
    //TEXTE
    UILabel *message = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 320, 50)];
    message.text = @"Sélectionnez une ville";
    message.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:message];
    
    //TABLE VIEW
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, 320, 300) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [myTableView setContentSize:CGSizeMake(320, 10000)];
    //myTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cell.png"]];
    [self.view addSubview:myTableView];
    
    //Add the search bar
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
	myTableView.tableHeaderView = searchBar;
	searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    searchBar.delegate = self;
	//searchBar.tintColor = [UIColor colorWithRed:148.0/255.0 green:127.0/255.0 blue:96.0/255.0 alpha:0.0];
    //searchBar.text = chosenCity;
    
	searching = YES;
	letUserSelectRow = YES;
    
    selection = [[NSMutableArray alloc] init];
    
    //REQUETE CORE DATA
    ZilekAppDelegate *appDelegate = (ZilekAppDelegate *)[[UIApplication sharedApplication] delegate];
	NSManagedObjectContext *context = appDelegate.managedObjectContext;
	
	NSFetchRequest *requete = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Codes" inManagedObjectContext:context];
	
	[requete setEntity:entity];
	[requete setFetchBatchSize:20];
	
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"commune" ascending:YES];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	
	[requete setSortDescriptors:sortDescriptors];
	
	[sortDescriptor release];
	[sortDescriptors release];
    
    NSPredicate *predicat;
    
    predicat = [NSPredicate predicateWithFormat:@"code MATCHES '\\\\d{5}'"];
    
	[requete setPredicate:predicat];
	
	NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc] 
															initWithFetchRequest:requete
															managedObjectContext:context
															sectionNameKeyPath:nil
															cacheName:nil];
	fetchedResultsController.delegate = self;
	NSError *error;
	BOOL success = [fetchedResultsController performFetch:&error];
	if (!success) {
		// Gérez l'erreur ici.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
	
	[requete release];
	
	resultsController = fetchedResultsController;
    //[fetchedResultsController release];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
	[selection release];
    //[searchBar release];
    [super dealloc];
}

- (void) setCriteres:(NSNotification *)notify
{
    NSLog(@"criteres setCriteres %@",[notify object]);
    NSMutableDictionary *criteres = [notify object];
    
    NSString *listeVilles = [criteres valueForKey:@"villes"];
    villes = [listeVilles componentsSeparatedByString:@","];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
	
	return 1;
	
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	if (searching)
		return [[self.resultsController fetchedObjects] count];
	else {
		
		return 0;
	}
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    NSManagedObject *info = [resultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [info valueForKey:@"commune"];
    cell.detailTextLabel.text = [info valueForKey:@"code"];
    //cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cell.png"]];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"ObjectCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
	
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

- (NSIndexPath *)tableView :(UITableView *)theTableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if(letUserSelectRow)
		return indexPath;
	else
		return nil;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSManagedObject *managedObject = [resultsController objectAtIndexPath:indexPath];
	
	NSString *commune = [[NSString alloc] initWithFormat:@"%@",[managedObject valueForKey:@"commune"]];
	NSString *code = [[NSString alloc] initWithFormat:@"%@",[managedObject valueForKey:@"code"]];
	
    [selection release];
    selection = [[NSMutableArray alloc] init];
    
	[selection addObject:commune];
	[selection addObject:code];
	
	[commune release];
	[code release];
	
    [[NSNotificationCenter defaultCenter] postNotificationName:@"citySelected" object: selection];
    
	[self.navigationController popViewControllerAnimated:YES];
	
}

#pragma mark -
#pragma mark searchBar delegate

- (void) searchBarTextDidBeginEditing:(UISearchBar *)theSearchBar {
	
	searching = YES;
	letUserSelectRow = NO;
	myTableView.scrollEnabled = NO;
    
}

- (void)searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText {
	
	if([searchText length] > 0) {
		searching = YES;
		letUserSelectRow = YES;
		myTableView.scrollEnabled = YES;
		[self searchTableView:searchText];
	}
	else {
		
		/*searching = NO;
		letUserSelectRow = NO;
		myTableView.scrollEnabled = NO;*/
        ZilekAppDelegate *appDelegate = (ZilekAppDelegate *)[[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = appDelegate.managedObjectContext;
        
        NSFetchRequest *requete = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Codes" inManagedObjectContext:context];
        
        [requete setEntity:entity];
        [requete setFetchBatchSize:20];
        
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"commune" ascending:YES];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        
        [requete setSortDescriptors:sortDescriptors];
        
        [sortDescriptor release];
        [sortDescriptors release];
        
        NSPredicate *predicat;
        
        predicat = [NSPredicate predicateWithFormat:@"code MATCHES '\\\\d{5}'"];
        
        [requete setPredicate:predicat];
        
        NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc] 
                                                                initWithFetchRequest:requete
                                                                managedObjectContext:context
                                                                sectionNameKeyPath:nil
                                                                cacheName:nil];
        fetchedResultsController.delegate = self;
        NSError *error;
        BOOL success = [fetchedResultsController performFetch:&error];
        if (!success) {
            // Gérez l'erreur ici.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        
        [requete release];
        
        resultsController = fetchedResultsController;
	}
	
	[myTableView reloadData];
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)theSearchBar {
	
	[self searchTableView:theSearchBar.text];
}

- (void) searchTableView:(NSString *)theText {
	
	//REQUETE SUR LA BDD
	
	ZilekAppDelegate *appDelegate = (ZilekAppDelegate *)[[UIApplication sharedApplication] delegate];
	NSManagedObjectContext *context = appDelegate.managedObjectContext;
	
	NSFetchRequest *requete = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Codes" inManagedObjectContext:context];
	
	[requete setEntity:entity];
	[requete setFetchBatchSize:20];
	
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"commune" ascending:YES];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	
	[requete setSortDescriptors:sortDescriptors];
	
	[sortDescriptor release];
	[sortDescriptors release];
	
	NSPredicate *predicat;
	
	if ( ([searchBar.text intValue] > 0)) {
		predicat = [NSPredicate predicateWithFormat:@"code beginswith[cd] %@", theText];
	}
	else {
		predicat = [NSPredicate predicateWithFormat:@"commune beginswith[cd] %@", theText];
	}
	
	
	[requete setPredicate:predicat];
	
	NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc] 
															initWithFetchRequest:requete
															managedObjectContext:context
															sectionNameKeyPath:nil
															cacheName:nil];
	fetchedResultsController.delegate = self;
	NSError *error;
	BOOL success = [fetchedResultsController performFetch:&error];
	if (!success) {
		// Gérez l'erreur ici.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
	
	[requete release];
	
	resultsController = fetchedResultsController;
	
}

- (void) doneSearching_Clicked:(id)sender {
	
	searchBar.text = @"";
	[searchBar resignFirstResponder];
	
	letUserSelectRow = YES;
	searching = NO;
	self.navigationItem.rightBarButtonItem = nil;
	myTableView.scrollEnabled = YES;
	
	[myTableView reloadData];
}

- (void) buttonPushed:(id)sender
{
	UIButton *button = sender;
    
	switch (button.tag) {
        case 0:
            [self.navigationController popViewControllerAnimated:YES];
            break;
		default:
			break;
	}
}

@end
