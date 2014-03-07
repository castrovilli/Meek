//
//  MoodCollectionViewController.m
//  Meek
//
//  Created by ZIWEI LIU on 3/7/14.
//  Copyright (c) 2014 ZIWEI LIU. All rights reserved.
//

#import "MoodCollectionViewController.h"

@interface MoodCollectionViewController ()
@property (nonatomic, strong) NSArray *moodImg; // array of strings
@end

@implementation MoodCollectionViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.moodImg = @[@"anger.png", @"cry.png", @"confused.png",@"miao.png", @"smile.png", @"spook.png"];
}

#pragma mark - UICollectionView Data Source

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.moodImg count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"Mood Cell" forIndexPath:indexPath];

    UIImageView *imageView = (UIImageView *) [cell viewWithTag:100];
    imageView.image = [UIImage imageNamed:[self.moodImg objectAtIndex:indexPath.row]];
    return cell;
}


@end
