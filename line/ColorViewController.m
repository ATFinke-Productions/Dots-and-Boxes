//
//  ColorViewController.m
//  dot
//
//  Created by Andrew on 4/3/13.
//  Copyright (c) 2013 Andrew. All rights reserved.
//

#import "ColorViewController.h"

@interface ColorViewController () {
    NSMutableArray *colors;
}

@end

@implementation ColorViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setThemeItem:(id)newThemeItem
{
    if (_themeItem != newThemeItem) {
        _themeItem = newThemeItem;
        
        // Update the view.
        [self viewDidLoad];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    colors = [NSMutableArray arrayWithObjects:@"Black", @"Blue", @"Brown", @"Clear" ,@"Cyan", @"Dark Gray", @"Gray", @"Green", @"Light Gray", @"Magenta", @"Orange", @"Purple", @"Red", @"White", @"Yellow", nil];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    self.navigationController.navigationBar.tintColor = [[UIColorForString sharedInstance] colorForString:[defaults valueForKey:@"userViewColor"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [colors count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = colors[indexPath.row];

    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    if ([_themeItem isEqual:@"board"]) {
        [defaults setValue:colors[indexPath.row] forKey:@"userBoardColor"];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,     NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@",documentsDirectory,@"background.JPEG"] error:nil];
    }
    else if ([_themeItem isEqual:@"lines"]) {
        [defaults setValue:colors[indexPath.row] forKey:@"userLineColor"];
    }
    else if ([_themeItem isEqual:@"P1Box"]) {
        [defaults setValue:colors[indexPath.row] forKey:@"userP1Color"];
    }
    else if ([_themeItem isEqual:@"P2Box"]) {
        [defaults setValue:colors[indexPath.row] forKey:@"userP2Color"];
    }
    else if ([_themeItem isEqual:@"P3Box"]) {
        [defaults setValue:colors[indexPath.row] forKey:@"userP3Color"];
    }
    else if ([_themeItem isEqual:@"P4Box"]) {
        [defaults setValue:colors[indexPath.row] forKey:@"userP4Color"];
    }
    else if ([_themeItem isEqual:@"view"]) {
        [defaults setValue:colors[indexPath.row] forKey:@"userViewColor"];
    }
    [defaults synchronize];
    
    [MBHUDView hudWithBody:[NSString stringWithFormat:@"%@ Selected",colors[indexPath.row]] type:MBAlertViewHUDTypeCheckmark hidesAfter:.5 show:YES];
    
    self.navigationController.navigationBar.tintColor = [[UIColorForString sharedInstance] colorForString:[defaults valueForKey:@"userViewColor"]];
}

@end
