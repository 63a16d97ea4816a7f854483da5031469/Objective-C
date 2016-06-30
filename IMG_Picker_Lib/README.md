
	You have to use custom imagepicker. And I think ELCImagePickerController is the best option in my opinion.
	
	There is also some other library that can be used..
	
	Objective-C
	1. ELCImagePickerController
	2. WSAssetPickerController
	3. QBImagePickerController
	4. ZCImagePickerController
	5. CTAssetsPickerController
	6. AGImagePickerController
	7. UzysAssetsPickerController
	8. MWPhotoBrowser
	9. TSAssetsPickerController
	10. CustomImagePicker
	11. InstagramPhotoPicker
	12. GMImagePicker
	13. DLFPhotosPicker
	14. CombinationPickerController
	15. AssetPicker
	16. BSImagePicker
	17. SNImagePicker
	18. DoImagePickerController
	19. grabKit
	20. IQMediaPickerController
	21. HySideScrollingImagePicker
	22. MultiImageSelector
	23. TTImagePicker
	24. SelectImages
	25. ImageSelectAndSave
	26. imagepicker-multi-select
	27. MultiSelectImagePickerController
	
	Swift
	1. LimPicker (Similar to WhatsApp's image picker) 
	2. RMImagePicker
	3. DKImagePickerController
	4. BSImagePicker
	5. Fusuma(Instagram like image selector)
	
	Thanx to @androidbloke,
	I have added some library that i know for multiple image picker in swift.
	Will update list as i find new ones.
	Thank You.







# ELCImagePickerController

*A clone of the UIImagePickerController using the Assets Library Framework allowing for multiple asset selection.*

## Usage

The image picker is created and displayed in a very similar manner to the `UIImagePickerController`. The sample application  shows its use. To display the controller you instantiate it and display it modally like so.

```obj-c
// Create the image picker
ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initImagePicker];
elcPicker.maximumImagesCount = 4; //Set the maximum number of images to select, defaults to 4
elcPicker.returnsOriginalImage = NO; //Only return the fullScreenImage, not the fullResolutionImage
elcPicker.returnsImage = YES; //Return UIimage if YES. If NO, only return asset location information
elcPicker.onOrder = YES; //For multiple image selection, display and return selected order of images
elcPicker.imagePickerDelegate = self;

//Present modally
[self presentViewController:elcPicker animated:YES completion:nil];

// Release if not using ARC
[elcPicker release];
```

The `ELCImagePickerController` will return the select images back to the `ELCImagePickerControllerDelegate`. The delegate contains methods very similar to the `UIImagePickerControllerDelegate`. Instead of returning one dictionary representing a single image the controller sends back an array of similarly structured dictionaries. The two delegate methods are:

```obj-c
- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info;
- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker;
```

The Image Picker allows for some customization, including limiting 
    to just one photo album, limiting to single image selection, and automatically
    scrolling to the bottom. See the demo viewcontroller for example usage.

## License

The MIT License

Copyright (c) 2010 ELC Technologies

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
