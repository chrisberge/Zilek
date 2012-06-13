//
//  AfficheAnnonceControllerAccueil.h
//  Zilek
//
//  Created by Christophe Bergé on 12/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
//  CLASSE UTILISEE POUR ACCUEIL

#import <UIKit/UIKit.h>
#import "ArrayWithIndex.h"
#import "Annonce.h"
#import "DiapoController3.h"
#import "AFOpenFlowViewDiapo.h"
#import "ProgressViewContoller.h"
#import "FormulaireAnnonce.h"
#import "ZilekAppDelegate.h"

@class ZilekAppDelegate;

@interface AfficheAnnonceControllerAccueil : UIViewController <DiapoController3Delegate, FormulaireAnnonceDelegate>{
    Annonce *lAnnonce;
    Agence *lAgence;
	NSMutableArray *imagesArray;
	ArrayWithIndex *arrayWithIndex;
    AFOpenFlowViewDiapo *myOpenFlowView;
    UIScrollView *scrollView;
    ProgressViewContoller *pvc;
    UIButton *boutonRetour;
    ZilekAppDelegate *appDelegate;
}

@end
