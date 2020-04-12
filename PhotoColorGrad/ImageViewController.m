//
//  ImageViewController.m
//  PhotoColorGrad
//
//  Created by Michael Redig on 4/10/20.
//  Copyright © 2020 Red_Egg Productions. All rights reserved.
//

#import "ImageViewController.h"
#import <Photos/Photos.h>
#import "REPImageProcessor.h"
#import "GradientView.h"

@interface ImageViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet GradientView *gradientView;

@end

@implementation ImageViewController

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
		NSArray *colorArray = processor.colors;
		dispatch_async(dispatch_get_main_queue(), ^{
			if (colorArray.count > 1) {
				self.gradientView.colors = @[colorArray[0], colorArray[1]];
			}
		});
	}];
}

@end
