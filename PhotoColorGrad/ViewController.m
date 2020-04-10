//
//  ViewController.m
//  PhotoColorGrad
//
//  Created by Michael Redig on 4/10/20.
//  Copyright © 2020 Red_Egg Productions. All rights reserved.
//

#import "ViewController.h"
#import <Photos/Photos.h>
#import "REPImageProcessor.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (IBAction)addButtonPressed:(UIBarButtonItem *)sender {
	UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
	imagePicker.allowsEditing = YES;
	imagePicker.delegate = self;

	[self presentViewController:imagePicker animated:true completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
	[self dismissViewControllerAnimated:true completion:nil];

	UIImage *image = info[UIImagePickerControllerEditedImage];
	self.imageView.image = image;

	REPImageProcessor *processor = [[REPImageProcessor alloc] init];
	[processor loadImage:image completionHandler:^{
		NSLog(@"finished!");
	}];
}

@end
