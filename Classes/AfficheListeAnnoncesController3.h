//
//  AfficheListeAnnoncesController3.h
//  Zilek
//
//  Created by Christophe Bergé on 12/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Annonce.h"
#import "AfficheAnnonceController2.h"
#import "ProgressViewContoller.h"


@interface AfficheListeAnnoncesController3 : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    NSMutableArray *listeAnnonces;
    NSMutableDictionary *criteres;
	Annonce *annonceSelected;
    UITableView *tableView1;
    UIButton *boutonPrix;
    UIButton *boutonSurface;
    ProgressViewContoller *pvc;
}

@property (nonatomic, copy) NSMutableArray *listeAnnonces;
@property (nonatomic, copy) NSMutableDictionary *criteres;
@property (nonatomic, copy) Annonce *annonceSelected;

- (id)initFromView:(NSString *)viewName;
-(NSString *)setTextMinMax:(NSString *)critere unit:(NSString *)unit texte:(NSString *)text;

@end
