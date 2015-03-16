//
//  CXDiscoverTableViewController.m
//  CXWeibo
//
//  Created by mac on 15-2-5.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "CXDiscoverTableViewController.h"
#import "CXSearchBar.h"

@interface CXDiscoverTableViewController ()

@end

@implementation CXDiscoverTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CXSearchBar *searchBar = [CXSearchBar searchBar];
    searchBar.frame = CGRectMake(0, 0, 300, 30);
    self.navigationItem.titleView = searchBar;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}


@end
