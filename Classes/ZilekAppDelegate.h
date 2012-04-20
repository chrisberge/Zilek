//
//  ZilekAppDelegate.h
//  Zilek
//
//  Created by Christophe Bergé on 23/07/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Utility.h"
#import "Accueil.h"
#import "ContactViewController.h"
#import "Favoris.h"
#import "AgenceViewController.h"

@class Accueil;
@class AgenceViewController;
@class Favoris;

@interface ZilekAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UITabBarController *tabBarController;
	Accueil *accueilView;
	Favoris *favorisView;
	AgenceViewController *agenceView;
	ContactViewController *contactView;
    BOOL isAccueil;
    UIImageView *imagePresentation;
    NSString *whichView;
	
@private
    NSManagedObjectContext *managedObjectContext_;
    NSManagedObjectModel *managedObjectModel_;
    NSPersistentStoreCoordinator *persistentStoreCoordinator_;
	
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) UITabBarController *tabBarController;
@property (nonatomic, retain) Accueil *accueilView;
@property (nonatomic, retain) Favoris *favorisView;
@property (nonatomic, retain) AgenceViewController *agenceView;
@property (nonatomic, retain) ContactViewController *contactView;
@property (nonatomic, assign) BOOL isAccueil;
@property (nonatomic, assign) NSString *whichView;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSString *)applicationDocumentsDirectory;

@end

