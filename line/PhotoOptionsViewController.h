//
//  PhotoOptionsViewController.h
//  dot
//
//  Created by Andrew on 4/3/13.
//  Copyright (c) 2013 Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface PhotoOptionsViewController : UIViewController <UIPopoverControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    IBOutlet UIImageView *imageView;
}
@property (strong, nonatomic) UIPopoverController *imagePopoverController;

-(IBAction)showPhotoPicker:(id)sender;
-(IBAction)close:(id)sender;
@end
