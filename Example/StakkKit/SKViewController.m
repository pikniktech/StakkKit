//
//  SKViewController.m
//  StakkKit
//
//  Created by Derek on 09/27/2016.
//  Copyright (c) 2016 Derek. All rights reserved.
//

#import "SKViewController.h"

// StakkKit
#import "StakkKit.h"

@interface SKViewController ()

@end

@implementation SKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    SKNetworkManager *manager = [[SKNetworkManager alloc] init];
    manager.test = @"This is testing";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
