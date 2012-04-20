//
//  XMLParser.h
//  Zilek
//
//  Created by Christophe Bergé on 01/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Annonce.h"
#import "ZilekAppDelegate.h"

@class ZilekAppDelegate, Annonce;

@interface XMLParser : NSObject {
	NSMutableString *currentElementValue;
	Annonce *uneAnnonce;
	ZilekAppDelegate *appDelegate;
}

- (XMLParser *) initXMLParser;

@end
