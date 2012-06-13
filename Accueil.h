//
//  Accueil.h
//  Zilek
//
//  Created by Christophe Bergé on 23/07/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "RootViewController.h"
#import "RechercheCarte2.h"
#import "AFOpenFlowView.h"
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"
#import "Annonce.h"
#import "ProgressViewContoller.h"
#import "AfficheAnnonceControllerAccueil.h"
#import "Ville.h"
#import "XMLParserVilles.h"
#import "ZilekAppDelegate.h"

@class ASINetworkQueue;
@class RootViewController;
@class RechercheCarte2;
@class ZilekAppDelegate;

@interface Accueil : UIViewController {
    RootViewController *myTableViewController;
    RechercheCarte2 *rechercheCarte;
    NSString *whichView;
    AFOpenFlowView *myOpenFlowView;
    ASINetworkQueue *networkQueue;
    NSMutableArray *tableauAnnonces1;
    NSMutableArray *tableauVilles;
    BOOL isConnectionErrorPrinted;
    ProgressViewContoller *pvc;
    Annonce *annonceSelected;
    ZilekAppDelegate *appDelegate;

}

@property (nonatomic, retain) RootViewController *myTableViewController;
@property (nonatomic, retain) RechercheCarte2 *rechercheCarte;
@property (nonatomic, assign) NSString *whichView;
@property (nonatomic, copy) NSMutableArray *tableauAnnonces1;
@property (nonatomic, copy) NSMutableArray *tableauVilles;

-(UIImage *) getImage:(NSString *)cheminImage;
-(void) makeRequest;

@end
