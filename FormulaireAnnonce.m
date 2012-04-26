//
//  FormulaireAnnonce.m
//  Zilek
//
//  Created by Christophe Bergé on 26/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FormulaireAnnonce.h"

@implementation FormulaireAnnonce

@synthesize delegate=_delegate;

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(formulaireGetAnnonce:) name:@"formulaireGetAnnonce" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(formulaireGetAgence:) name:@"formulaireGetAgence" object: nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"formulaireAnnonceReady" object: @"formulaireAnnonceReady"];
    
    UIColor *fond = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.png"]];
    self.view.backgroundColor = fond;
    [fond release];
    
    //self.view.backgroundColor = [UIColor whiteColor];
    
    //HEADER
    UIImageView *enTete = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header.png"]];
    [enTete setFrame:CGRectMake(0,0,320,50)];
    [self.view addSubview:enTete];
    [enTete release];
    
    //SCROLL VIEW
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50, 320, 480)];
    scrollView.showsVerticalScrollIndicator = YES;
    
    [scrollView setContentSize:CGSizeMake(320, 1200)];
    [scrollView setScrollEnabled:YES];
    [self.view addSubview:scrollView];
    
    [scrollView flashScrollIndicators];
    [scrollView release];
    
    //BOUTON RETOUR
    UIButton *boutonRetour = [UIButton buttonWithType:UIButtonTypeCustom];
    boutonRetour.showsTouchWhenHighlighted = NO;
    boutonRetour.tag = 6;
    
    [boutonRetour setFrame:CGRectMake(10,7,50,30)];
    [boutonRetour addTarget:self action:@selector(done:) 
           forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *image = [UIImage imageNamed:@"bouton-retour.png"];
    [boutonRetour setImage:image forState:UIControlStateNormal];
    
    [self.view addSubview:boutonRetour];
    
    /*--- FORMULAIRE DE CONTACT ---*/
    //NOM
    labelNom = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 100, 30)];
    labelNom.text = @"NOM:";
    [scrollView addSubview:labelNom];
    [labelNom release];
    
    nomTF = [[UITextField alloc] initWithFrame:CGRectMake(30, 30, 250, 30)];
    nomTF.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:nomTF];
    [nomTF release];
    
    //TELEPHONE
    labelTelephone = [[UILabel alloc] initWithFrame:CGRectMake(30, 60, 150, 30)];
    labelTelephone.text = @"TELEPHONE:";
    [scrollView addSubview:labelTelephone];
    [labelTelephone release];
    
    telephoneTF = [[UITextField alloc] initWithFrame:CGRectMake(30, 90, 250, 30)];
    telephoneTF.borderStyle = UITextBorderStyleRoundedRect;
    telephoneTF.keyboardType = UIKeyboardTypePhonePad;
    [scrollView addSubview:telephoneTF];
    [telephoneTF release];
    
    //EMAIL
    labelEmail = [[UILabel alloc] initWithFrame:CGRectMake(30, 120, 150, 30)];
    labelEmail.text = @"EMAIL:";
    [scrollView addSubview:labelEmail];
    [labelEmail release];
    
    emailTF = [[UITextField alloc] initWithFrame:CGRectMake(30, 150, 250, 30)];
    emailTF.borderStyle = UITextBorderStyleRoundedRect;
    emailTF.keyboardType = UIKeyboardTypeEmailAddress;
    [scrollView addSubview:emailTF];
    [emailTF release];
    
    //TYPE DE BIEN
    labelQuestion = [[UILabel alloc] initWithFrame:CGRectMake(30, 180, 150, 30)];
    labelQuestion.text = @"QUESTION:";
    [scrollView addSubview:labelQuestion];
    [labelQuestion release];
    
    questionTF = [[UITextField alloc] initWithFrame:CGRectMake(30, 210, 250, 30)];
    questionTF.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:questionTF];
    [questionTF release];
    
    //BOUTON ENVOYER
    boutonEnvoyer = [UIButton buttonWithType:UIButtonTypeCustom];
    boutonEnvoyer.showsTouchWhenHighlighted = NO;
    boutonEnvoyer.tag = 1;
    
    [boutonEnvoyer setFrame:CGRectMake(55,270,200,50)];
    [boutonEnvoyer addTarget:self action:@selector(buttonPushed:) 
            forControlEvents:UIControlEventTouchUpInside];
    
    image = [UIImage imageNamed:@"bouton-envoyer.png"];
    [boutonEnvoyer setImage:image forState:UIControlStateNormal];
    
    [scrollView addSubview:boutonEnvoyer];
    
    /*--- FORMULAIRE DE CONTACT ---*/
    
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

- (void)buttonPushed:(id)sender
{
    NSLog(@"REQUETE POST");
    
    /*--- QUEUE POUR LES REQUETES HTTP ---*/
    ASINetworkQueue *networkQueue = [[ASINetworkQueue alloc] init];
    [networkQueue reset];
	[networkQueue setRequestDidFinishSelector:@selector(requestDone:)];
	[networkQueue setRequestDidFailSelector:@selector(requestFailed:)];
	[networkQueue setDelegate:self];
    /*--- QUEUE POUR LES REQUETES HTTP ---*/
    
    /*--- REQUETE POST ---*/
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://zilek.com/akios_agent_query.pl?pid=%@",
                                       [lAnnonce valueForKey:@"code"]]];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:[lAnnonce valueForKey:@"ref"] forKey:@"pid"];
    [request setPostValue:[questionTF text] forKey:@"question"];
    [request setPostValue:[nomTF text] forKey:@"name"];
    [request setPostValue:[emailTF text] forKey:@"email"];
    [request setPostValue:[telephoneTF text] forKey:@"tel"];
    [request setUserInfo:[NSDictionary dictionaryWithObject:[NSString stringWithString:@"formulaire"] forKey:@"name"]];
    
    [networkQueue addOperation:request];
    [networkQueue go];
    /*--- REQUETE POST ---*/
}

- (void)requestDone:(ASIHTTPRequest *)request
{
	NSData *responseData = [request responseData];
    
    NSLog(@"dataBrute long: %d",[responseData length]);
    
    NSString * string = [[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding] autorelease];
    NSString *string2 = [string stringByAppendingFormat:@"\n"];
    
    NSLog(@"REPONSE DU WEB: \"%@\"\n",string2);
    
    if ([string2 length] > 0) {
        
        NSUInteger zap = 39;
        
        NSData *dataString = [string2 dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        
        NSData *data = [[NSData alloc] initWithData:[dataString subdataWithRange:NSMakeRange(38, [dataString length] - zap)]];
        
        /*--- POUR LE TEST OFF LINE ---
         NSFileManager *fileManager = [NSFileManager defaultManager];
         NSString *xmlSamplePath = [[NSBundle mainBundle] pathForResource:@"Formulaire" ofType:@"xml"];
         data = [fileManager contentsAtPath:xmlSamplePath];
         string2 = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
         NSLog(@"REPONSE DU WEB: %@\n",string);
         */
        
        NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:data];
        XMLParserFormulaire *parser = [[XMLParserFormulaire alloc] initXMLParser];
        
        [xmlParser setDelegate:parser];
        
        BOOL success = [xmlParser parse];
        
        if(success)
            NSLog(@"No Errors on XML parsing.");
        else
            NSLog(@"Error on XML parsing!!!");
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"formulaireAgenceReady" object: @"formulaireAgenceReady"];
        
        [nomTF removeFromSuperview];
        [emailTF removeFromSuperview];
        [telephoneTF removeFromSuperview];
        [questionTF removeFromSuperview];
        
        [labelNom removeFromSuperview];
        [labelTelephone removeFromSuperview];
        [labelEmail removeFromSuperview];
        [labelQuestion removeFromSuperview];
        
        [boutonEnvoyer removeFromSuperview];
        
        NSString *texte = @"Vos coordonnées ont été transmises à l'agence ci-dessous. Vous recevrez un e-mail de confirmation.";
        texte = [texte stringByAppendingFormat:@"\n\n%@\n%@\n%@\n%@ %@\n%@\n%@\n%@",
                 [lAgence valueForKey:@"titre"],
                 [lAgence valueForKey:@"responsable"],
                 [lAgence valueForKey:@"adresse"],
                 [lAgence valueForKey:@"cp"],
                 [lAgence valueForKey:@"ville"],
                 [lAgence valueForKey:@"fixe"],
                 [lAgence valueForKey:@"mobile"],
                 [lAgence valueForKey:@"email"]
                 ];
        
        UITextView *contactMessage = [[UITextView alloc] initWithFrame:CGRectMake(0, 5, 300, 350)];
        contactMessage.editable = NO;
        contactMessage.text = texte;
        
        [scrollView addSubview:contactMessage];
        
        [xmlParser release];
        [parser release];
        }
    //[string release];
    
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    UIAlertView *alert;
    
    NSLog(@"Connection failed! Error - %@",
          [error localizedDescription]);
    
    alert = [[UIAlertView alloc] initWithTitle:@"Erreur de connection."
                                       message:[error localizedDescription]
                                      delegate:self
                             cancelButtonTitle:@"OK"
                             otherButtonTitles:nil];
    [alert show];
    [alert release];
}

- (void)done:(id)sender
{
    [self.delegate formulaireAnnonceDidFinish:self];
}

- (void) formulaireGetAnnonce:(NSNotification *)notify {
	lAnnonce = [[Annonce alloc] init];
    lAnnonce = [notify object];
}

- (void) formulaireGetAgence:(NSNotification *)notify {
	lAgence = [[Agence alloc] init];
    lAgence = [notify object];
}

- (void)dealloc
{
	//[lAnnonce release];
    [lAgence release];
    [super dealloc];
}

@end
