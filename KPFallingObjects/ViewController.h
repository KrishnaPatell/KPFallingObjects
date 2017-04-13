//
//  ViewController.h
//  KPFallingObjects
//
//  Created by Krishna on 13/04/17.
//  Copyright © 2017 Krishna Patel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIView *viewContainer;
-(IBAction)btnNumber:(id)sender;
-(IBAction)btnAlphabet:(id)sender;
-(IBAction)btnSnowFall:(id)sender;
-(IBAction)btnBinary:(id)sender;


@end
