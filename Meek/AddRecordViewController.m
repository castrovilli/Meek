//
//  AddRecordViewController.m
//  Meek
//
//  Created by ZIWEI LIU on 3/4/14.
//  Copyright (c) 2014 ZIWEI LIU. All rights reserved.
//

#import "AddRecordViewController.h"
#import "DreamRecord+DreamRecord_Edit.h"

@interface AddRecordViewController ()<UITextFieldDelegate, UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *categoryTextField;
@property (weak, nonatomic) IBOutlet UITextView *detailTextArea;

@end

@implementation AddRecordViewController
#pragma mark - Target/Action
- (IBAction)cancelButton{
//    self.addedDate = nil;
    // delete it
    [self.addedRecord.managedObjectContext deleteObject:self.addedRecord];
//    self.addedRecord.date = nil;
//    self.addedRecord = nil;
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - Navigation

#define UNWIND_SEGUE_IDENTIFIER @"Do Add Record"

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:UNWIND_SEGUE_IDENTIFIER])
    {
        self.addedRecord.title = self.titleTextField.text;
        self.addedRecord.category = self.categoryTextField.text;
        self.addedRecord.detail = self.detailTextArea.text;
    }
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:UNWIND_SEGUE_IDENTIFIER]) {
        if (![self.titleTextField.text length]) {
            [self alert:@"Title required!"];
            return NO;
        } else if (![self.categoryTextField.text length]) {
            [self alert:@"Category required!"];
            return NO;
        } else if (![self.detailTextArea.text length]) {
            [self alert:@"Detail required!"];
            return NO;
        } else { // should check imageURL too to be sure we could write the file
            return YES;
        }
    } else {
        return [super shouldPerformSegueWithIdentifier:identifier sender:sender];
    }
}


-(IBAction)addMood:(UIStoryboardSegue *)segue
{
    
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder]; // make "return key" hide keyboard
    return YES;
}


#pragma mark - Alerts

- (void)alert:(NSString *)msg
{
    [[[UIAlertView alloc] initWithTitle:@"Add Record"
                                message:msg
                               delegate:nil
                      cancelButtonTitle:nil
                      otherButtonTitles:@"OK", nil] show];
}

- (void)fatalAlert:(NSString *)msg
{
    [[[UIAlertView alloc] initWithTitle:@"Add Record"
                                message:msg
                               delegate:self // we're going to cancel when dismissed
                      cancelButtonTitle:nil
                      otherButtonTitles:@"OK", nil] show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self cancelButton];
}

@end
