//
//  PandaOCRRecongnizeViewController.m
//  PandaDoctorDev
//
//  Created by xiangxixids on 14/8/31.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import "PandaOCRRecongnizeViewController.h"


//error Provide Application ID and Password
// To create an application and obtain a password,
// register at http://cloud.ocrsdk.com/Account/Register
// More info on getting your application id and password at
// http://ocrsdk.com/documentation/faq/#faq3

// Name of application you created
static NSString* MyApplicationID =  @"pandaDoctor"; //@"my_app_id";
// Password should be sent to your e-mail after application was created
static NSString* MyPassword = @"aYMmnhTGoIyg0zXdIhwnn9Tv";  //@"my_password";

@interface PandaOCRRecongnizeViewController ()

@end

@implementation PandaOCRRecongnizeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _textView.hidden = YES;
    
    _label.hidden = NO;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    _label.text = @"Loading image...";
    Client *client = [[Client alloc] initWithApplicationID:MyApplicationID password:MyPassword];
	[client setDelegate:self];
	
	if([[NSUserDefaults standardUserDefaults] stringForKey:@"installationID"] == nil) {
		NSString* deviceID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
		
		NSLog(@"First run: obtaining installation ID..");
		NSString* installationID = [client activateNewInstallation:deviceID];
		NSLog(@"Done. Installation ID is \"%@\"", installationID);
		
		[[NSUserDefaults standardUserDefaults] setValue:installationID forKey:@"installationID"];
	}
	
	NSString* installationID = [[NSUserDefaults standardUserDefaults] stringForKey:@"installationID"];
	
	client.applicationID = [client.applicationID stringByAppendingString:installationID];
	
	ProcessingParams* params = [[ProcessingParams alloc] init];
	
	[client processImage:_image withParams:params];
	
	_label.text = @"Uploading image...";
	
    [super viewDidAppear:animated];
    
}

#pragma mark - ClientDelegate implementation

- (void)clientDidFinishUpload:(Client *)sender
{
	_label.text = @"Processing image...";
}

- (void)clientDidFinishProcessing:(Client *)sender
{
	_label.text = @"Downloading result...";
}

- (void)client:(Client *)sender didFinishDownloadData:(NSData *)downloadedData
{
	_label.hidden = YES;
    _label.text = @"Loading image...";
	//statusIndicator.hidden = YES;
	
	_textView.hidden = NO;
	
	NSString* result = [[NSString alloc] initWithData:downloadedData encoding:NSUTF8StringEncoding];
	
	_textView.text = result;
}

- (void)client:(Client *)sender didFailedWithError:(NSError *)error
{
	UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error"
													message:[error localizedDescription]
												   delegate:nil
										  cancelButtonTitle:@"Cancel"
										  otherButtonTitles:nil, nil];
	
	[alert show];
	
	_label.text = [error localizedDescription];
	//statusIndicator.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)confirm:(UIBarButtonItem *)sender {
    
    NSLog(@"confirming...");
    
    
}

- (IBAction)back:(UIBarButtonItem *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
