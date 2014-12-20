//
//  MatchViewController.m
//  Boxes
//
//  Created by Andrew on 4/19/13.
//  Copyright (c) 2013 Andrew. All rights reserved.
//

#import "MatchViewController.h"
#import "LocalMatch.h"

@interface MatchViewController () {
    NSMutableArray *_matchIDS;
    NSMutableArray *_idToDelete;
}

@end

@implementation MatchViewController




- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    UIBarButtonItem * add = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(newMatch)];
    self.navigationItem.rightBarButtonItem = add;
}

-(void)newMatch{
    [self performSegueWithIdentifier:@"new" sender:self];
}

-(void)viewWillAppear:(BOOL)animated{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    self.navigationController.navigationBar.tintColor = [[UIColorForString sharedInstance] colorForString:[defaults valueForKey:@"userViewColor"]];
    _matchIDS = [[NSMutableArray alloc]init];
    _idToDelete = [[NSMutableArray alloc]init];
    [_matchIDS removeAllObjects];
    _matchIDS = [[[NSUserDefaults standardUserDefaults] valueForKey:@"allMatchIDS"] mutableCopy];
    [self.tableView reloadData];
    [self updateView];
}

-(void)viewDidAppear:(BOOL)animated {
    [self.tableView reloadData];
}

-(void)viewWillDisappear:(BOOL)animated{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:_matchIDS forKey:@"allMatchIDS"];
    [defaults synchronize];
    for (NSString * object in _idToDelete) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:[NSString stringWithFormat:@"%@LocalMatch",object]];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _matchIDS.count;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_idToDelete addObject:_matchIDS[indexPath.row]];
        [_matchIDS removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self updateView];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)updateView{
    if (_matchIDS.count == 0) {
        disclaimer.hidden = NO;
        self.navigationItem.leftBarButtonItem.enabled = NO;
        [self setEditing:NO animated:YES];
    }
    else {
        disclaimer.hidden = YES;
        self.navigationItem.leftBarButtonItem.enabled = YES;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [[LocalMatch sharedInstance] matchNameForID:_matchIDS[indexPath.row]];
    cell.detailTextLabel.text = [[LocalMatch sharedInstance]participantsForMatchWithID:_matchIDS[indexPath.row]];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[LocalMatch sharedInstance] setNewMatchID:_matchIDS[indexPath.row]];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
