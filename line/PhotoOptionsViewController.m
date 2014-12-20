//
//  PhotoOptionsViewController.m
//  dot
//
//  Created by Andrew on 4/3/13.
//  Copyright (c) 2013 Andrew. All rights reserved.
//

#import "PhotoOptionsViewController.h"
#import "DemoImageEditor.h"

@interface PhotoOptionsViewController ()
@property(nonatomic,retain) DemoImageEditor *imageEditor;
@property(nonatomic,retain) ALAssetsLibrary *library;

@end

@implementation PhotoOptionsViewController

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
    [Flurry logEvent:@"Enter Photo View"];
    self.library = [[ALAssetsLibrary alloc] init];
    self.imageEditor = [[DemoImageEditor alloc] initWithNibName:@"DemoImageEditor" bundle:nil];
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:NO forKey:@"useUserImage"];
   imageView.image = [self imageWithColor:[self colorWithString:[defaults valueForKey:@"userBoardColor"]]];

    float radius = 20.0f;
    
    for (UIButton * button in self.view.subviews) {
        if (button.tag == 10) {
            [button.layer setMasksToBounds:YES];
            [button.layer setBorderColor:[UIColor darkTextColor].CGColor];
            [button.layer setBorderWidth:3.0];
            [button.layer setCornerRadius:radius];
            button.layer.shadowPath = [UIBezierPath bezierPathWithRect:button.bounds].CGPath;
        }
    }
    
    [imageView.layer setMasksToBounds:YES];
    [imageView.layer setBorderColor:[UIColor darkTextColor].CGColor];
    [imageView.layer setBorderWidth:3.0];
    [imageView.layer setCornerRadius:radius];
    imageView.layer.shadowPath = [UIBezierPath bezierPathWithRect:imageView.bounds].CGPath;
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)showPhotoPicker:(id)sender{
    UIImagePickerController *imagePicker =[[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        UIButton * button = sender;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            [self presentViewController:imagePicker animated:YES completion:nil];
        } else {
            if (!self.imagePopoverController) {
                self.imagePopoverController = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
            }
            if ([self.imagePopoverController isPopoverVisible]) {
                [self.imagePopoverController dismissPopoverAnimated:YES];
            } else {
                [self.imagePopoverController presentPopoverFromRect:button.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
            }
        }
    }
    else
    {
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
    
}


-(IBAction)close:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)displayClear{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,     NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *getImagePath = [documentsDirectory stringByAppendingPathComponent:@"background.JPEG"]; 
    imageView.image = [UIImage imageWithContentsOfFile:getImagePath];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image =  info[UIImagePickerControllerOriginalImage];
    NSURL *assetURL = info[UIImagePickerControllerReferenceURL];
    
    __block id myself = self;
    
    __block UIPopoverController * popover = self.imagePopoverController;
    
    self.imageEditor.doneCallback = ^(UIImage *editedImage, BOOL canceled){
        if(!canceled) {
            
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,     NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSArray *contents = [fileManager contentsOfDirectoryAtPath:documentsDirectory error:NULL];
            NSEnumerator *e = [contents objectEnumerator];
            NSString *filename;
            while ((filename = [e nextObject])) {
                if ([[filename pathExtension] isEqualToString:@".JPEG"]) {
                    [fileManager removeItemAtPath:[documentsDirectory stringByAppendingPathComponent:filename] error:NULL];
                }
            }
            
            NSData * imageData = UIImageJPEGRepresentation(editedImage, 1);
            NSString * fullPathToFile = [documentsDirectory stringByAppendingPathComponent:@"background.JPEG"];
            [imageData writeToFile:fullPathToFile atomically:NO];
            [Flurry logEvent:@"Saved Theme Image"];
            [NSTimer scheduledTimerWithTimeInterval:.5 target:myself selector:@selector(displayClear) userInfo:nil repeats:NO];
        }
        [picker dismissViewControllerAnimated:YES completion:nil];
        [popover dismissPopoverAnimated:YES];
    };

    [self.library assetForURL:assetURL resultBlock:^(ALAsset *asset) {
        UIImage *preview = [UIImage imageWithCGImage:[asset aspectRatioThumbnail]];
        
        self.imageEditor.sourceImage = image;
        self.imageEditor.previewImage = preview;
        [self.imageEditor reset:NO];
        
        [picker pushViewController:self.imageEditor animated:YES];
        [picker setNavigationBarHidden:YES animated:NO];
        
    } failureBlock:^(NSError *error) {
        MBAlertView * alert = [MBAlertView errorWithBody:@"Failed to get asset from library" cancelTitle:@"Ok" cancelBlock:nil];
        [alert addToDisplayQueue];
    }];
}


-(void)clearDocs{
    NSString *extension = @"jpeg";
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentsDirectory = paths[0];
    
    NSArray *contents = [fileManager contentsOfDirectoryAtPath:documentsDirectory error:NULL];
    NSEnumerator *e = [contents objectEnumerator];
    NSString *filename;
    while ((filename = [e nextObject])) {
        
        if ([[filename pathExtension] isEqualToString:extension]) {
            
            [fileManager removeItemAtPath:[documentsDirectory stringByAppendingPathComponent:filename] error:NULL];
        }
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIColor *)colorWithString:(NSString *)name{
    if ([name isEqual:@"Black"]) {
        return [UIColor blackColor];
    }
    else if ([name isEqual:@"Blue"]){
        return [UIColor blueColor];
    }
    else if ([name isEqual:@"Brown"]){
        return [UIColor brownColor];
    }
    else if ([name isEqual:@"Cyan"]){
        return [UIColor cyanColor];
    }
    else if ([name isEqual:@"Light Gray"]){
        return [UIColor lightGrayColor];
    }
    else if ([name isEqual:@"White"]){
        return [UIColor whiteColor];
    }
    else if ([name isEqual:@"Red"]){
        return [UIColor redColor];
    }
    else if ([name isEqual:@"Green"]){
        return [UIColor greenColor];
    }
    else if ([name isEqual:@"Yellow"]){
        return [UIColor yellowColor];
    }
    else if ([name isEqual:@"Magenta"]){
        return [UIColor magentaColor];
    }
    else if ([name isEqual:@"Orange"]){
        return [UIColor orangeColor];
    }
    else if ([name isEqual:@"Purple"]){
        return [UIColor purpleColor];
    }
    else if ([name isEqual:@"Clear"]){
        return [UIColor clearColor];
    }
    return nil;
}
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
