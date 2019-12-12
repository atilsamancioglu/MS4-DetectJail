//
//  ViewController.m
//  DetectJail
//
//  Created by Atil Samancioglu on 11.12.2019.
//  Copyright © 2019 Atil Samancioglu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
}
- (IBAction)testClicked:(id)sender {
    BOOL myBool = [self isJailbroken];
       
       if (myBool){
           _resultLabel.text = @"Jailbreak, Hacker!";
       } else {
           [self performSegueWithIdentifier:@"toSecondVC" sender:self];
       }
    
}



-(BOOL)isJailbroken{

#if !(TARGET_IPHONE_SIMULATOR)

if ([[NSFileManager defaultManager] fileExistsAtPath:@"/Applications/Cydia.app"]){
return YES;
}else if([[NSFileManager defaultManager] fileExistsAtPath:@"/Library/MobileSubstrate/MobileSubstrate.dylib"]){
return YES;
}else if([[NSFileManager defaultManager] fileExistsAtPath:@"/bin/bash"]){
return YES;
}else if([[NSFileManager defaultManager] fileExistsAtPath:@"/usr/sbin/sshd"]){
return YES;
}else if([[NSFileManager defaultManager] fileExistsAtPath:@"/etc/apt"]){
return YES;
}

NSError *error;
NSString *stringToBeWritten = @"This is a test.";
[stringToBeWritten writeToFile:@"/private/jailbreak.txt" atomically:YES
encoding:NSUTF8StringEncoding error:&error];
if(error==nil){
//Device is jailbroken
return YES;
} else {
[[NSFileManager defaultManager] removeItemAtPath:@"/private/jailbreak.txt" error:nil];
}

if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://package/com.example.package"]]){
//Device is jailbroken
return YES;
}
#endif

//All checks have failed. Most probably, the device is not jailbroken
return NO;
}


@end
