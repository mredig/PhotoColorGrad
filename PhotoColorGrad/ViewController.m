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
#import "GradientView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet GradientView *gradientView;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (IBAction)addButtonPressed:(UIBarButtonItem *)sender {
	UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
	imagePicker.delegate = self;

	[self presentViewController:imagePicker animated:true completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
	[self dismissViewControllerAnimated:true completion:nil];

	UIImage *image = info[UIImagePickerControllerOriginalImage];
	self.imageView.image = image;

	REPImageProcessor *processor = [[REPImageProcessor alloc] init];
	[processor loadImage:image completionHandler:^{
		dispatch_async(dispatch_get_main_queue(), ^{
			self.gradientView.colors = processor.colors;
		});
	}];
}

@end
