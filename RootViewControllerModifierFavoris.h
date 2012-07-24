//
//  RootViewControllerModifierFavoris.h
//  Zilek
//
//  Created by Christophe Bergé on 16/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ChoixVilleController3.h"
#import "SelectionTypeBienController.h"
#import "SelectionSurfaceController.h"
#import "SelectionNbPiecesController.h"
#import "SelectionBudgetController.h"
#import "AfficheListeAnnoncesControllerModifierFavoris.h"
#import "Intervalle.h"
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"
#import "XMLParser.h"
#import "ZilekAppDelegate.h"

@class ASINetworkQueue;
@class ZilekAppDelegate;

@interface RootViewControllerModifierFavoris : UIViewController {
	NSMutableArray *tableauAnnonces1;
	NSMutableDictionary *criteres1;
    NSMutableDictionary *criteres2;
    NSMutableDictionary *typeBien;
    BOOL isConnectionErrorPrinted;
    ASINetworkQueue *networkQueue;
    UILabel *labelVille;
    UILabel *labelTypeBien;
    UILabel *labelSurface;
    UILabel *labelNbPiece;
    UILabel *labelBudget;
    NSString *bodyString2;
    int nbRequetes;
}

@property (nonatomic, copy) NSMutableArray *tableauAnnonces1;
@property (nonatomic, copy) NSMutableDictionary *criteres1;
@property (nonatomic, copy) NSMutableDictionary *criteres2;

-(UIImage *) getImage:(NSString *)cheminImage;
- (void) makeRequest;

@end
