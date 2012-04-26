//
//  XMLParserFormulaire.h
//  Zilek
//
//  Created by Christophe Bergé on 26/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Agence.h"
#import "ZilekAppDelegate.h"

@class ZilekAppDelegate, Agence;

@interface XMLParserFormulaire : NSObject{
    NSMutableString *currentElementValue;
	Agence *uneAgence;
	ZilekAppDelegate *appDelegate;
}


- (XMLParserFormulaire *) initXMLParser;

@end
