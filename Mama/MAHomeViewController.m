//
//  MAHomeViewController.m
//  Mama
//
//  Created by Kevin Nguy on 8/14/14.
//  Copyright (c) 2014 Kevin Nguy. All rights reserved.
//

#import "MAHomeViewController.h"

#import "MAContact.h"

@interface MAHomeViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *contactArray;
@end

@implementation MAHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.contactArray = [NSMutableArray new];
    for (int i = 0; i < 30; i++) {
        MAContact *contact = [[MAContact alloc] initWithFirstName:@"Kevin" lastName:@"Nguy"];
        [self.contactArray addObject:contact];
    }
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contactArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellIdentifier"];
    }
    
    MAContact *contact = self.contactArray[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", contact.firstName, contact.lastName];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"SegueToContact" sender:self];
}



@end
