//
//  DetailViewController.m
//  Meek
//
//  Created by ZIWEI LIU on 3/3/14.
//  Copyright (c) 2014 ZIWEI LIU. All rights reserved.
//

#import "DetailViewController.h"
#import "DreamRecord+DreamRecord_Edit.h"
@interface DetailViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UITextView *textArea;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *categoryTextField;
@end

@implementation DetailViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
    
}

-(void)setup
{
    [self.titleLabel setFont:[UIFont fontWithName:@"BradleyHandITCTT-Bold" size:20]];
    UIFont *titleFont = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    UIFont *categoryFont = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
    UIFont *textAreaFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.textArea.font = textAreaFont;
    self.titleTextField.font = titleFont;
    self.categoryTextField.font = categoryFont;
    if(self.dreamRecord) {
        [self.textArea setText:self.dreamRecord.detail];
        self.titleTextField.text = self.dreamRecord.title;
        self.categoryTextField.text = self.dreamRecord.category;
    }
}



-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if([self.textArea.text length]) {
        self.dreamRecord.detail = self.textArea.text;
    }
    if([self.titleTextField.text length]) {
        self.dreamRecord.title = self.titleTextField.text;
    }
    if([self.categoryTextField.text length]) {
        self.dreamRecord.category = self.categoryTextField.text;
    }
}

#pragma - mark Delegate
// to make the keyboard disappear
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
