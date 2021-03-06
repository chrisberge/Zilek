//
//  AfficheAnnonceController2.h
//  Zilek
//
//  Created by Christophe Bergé on 13/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
//  CLASSE UTILISEE POUR MOTEUR DE RECHERCHE

#import <UIKit/UIKit.h>
#import "ArrayWithIndex.h"
#import "Annonce.h"
#import "DiapoController3.h"
#import "AFOpenFlowViewDiapo.h"
#import "ProgressViewContoller.h"
#import "FormulaireAnnonce.h"
#import "ZilekAppDelegate.h"

@class ZilekAppDelegate;

@interface AfficheAnnonceController2 : UIViewController <DiapoController3Delegate, FormulaireAnnonceDelegate>{
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
