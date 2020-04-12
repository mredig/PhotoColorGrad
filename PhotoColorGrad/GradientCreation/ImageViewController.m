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
#import "PhotoColorGrad-Swift.h"

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
				NSArray *newColors = @[colorArray[0], colorArray[1]];
				self.gradientView.colors = newColors;
				NSMutableArray *oldSavedValues = [[DefaultWrapper shared].gradientHistory mutableCopy];
				[oldSavedValues insertObject:newColors atIndex:0];
				[DefaultWrapper shared].gradientHistory = [oldSavedValues copy];
			}
		});
	}];
}

@end
