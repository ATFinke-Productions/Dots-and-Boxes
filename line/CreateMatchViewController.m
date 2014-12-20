//
//  CreateMatchViewController.m
//  Boxes
//
//  Created by Andrew on 4/19/13.
//  Copyright (c) 2013 Andrew. All rights reserved.
//

#import "CreateMatchViewController.h"
#import "PlayerCell.h"
#import "LocalMatch.h"
@interface CreateMatchViewController () {
    NSMutableArray *_players;
}
@end

@implementation CreateMatchViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(prepareToInsert)];
    self.navigationItem.rightBarButtonItem = addButton;
    [self updateInterface];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    self.navigationController.navigationBar.tintColor = [[UIColorForString sharedInstance] colorForString:[defaults valueForKey:@"userViewColor"]];
    for (UIButton * button in bottomView.subviews) {
        if (button.tag == 10) {
            float radius = 20.0f;
            [button.layer setMasksToBounds:YES];
            [button.layer setBorderColor:[UIColor darkTextColor].CGColor];
            [button.layer setBorderWidth:3.0];
            [button.layer setCornerRadius:radius];
            button.layer.shadowPath = [UIBezierPath bezierPathWithRect:button.bounds].CGPath;
        }
    }
}

-(void)prepareToInsert{
    MBAlertView * alert = [MBAlertView errorWithBody:@"Add what type of player?" cancelTitle:@"Human" cancelBlock:^{
        [self insertNewObjectPlayer:@"Human Player Name"];
    }];
    [alert addButtonWithText:@"AI" type:MBAlertViewItemTypeDefault block:^{
        [self insertNewObjectPlayer:@"AI Player Name"];
    }];

    [alert addToDisplayQueue];
}

- (void)insertNewObjectPlayer:(NSString *)player
{
    if (!_players) {
        _players = [[NSMutableArray alloc] init];
    }
    [_players addObject:player];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_players.count-1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self updateInterface];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _players.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    PlayerCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.playerName.tag = _players.count+10;
    cell.playerName.placeholder = _players[indexPath.row];

    
    return cell;
}


- (IBAction)dismissKeyboard:(id)sender{
    [sender resignFirstResponder];
}

-(IBAction)save:(id)sender{
    int players = _players.count;
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray * participents = [[NSMutableArray alloc]init];
    NSMutableArray * indexOfAIParticpents = [[NSMutableArray alloc]init];
    
    
    switch (players) {
        case 2:
            if ([((UITextField*)[self.view viewWithTag:11]).text isEqual:@""]) {
                ((UITextField*)[self.view viewWithTag:11]).text = @"Player 1";
            }
            if ([((UITextField*)[self.view viewWithTag:12]).text isEqual:@""]) {
                ((UITextField*)[self.view viewWithTag:12]).text = @"Player 2";
            }
            [participents addObject:((UITextField*)[self.view viewWithTag:11]).text];
            [participents addObject:((UITextField*)[self.view viewWithTag:12]).text];
            
            if ([((UITextField*)[self.view viewWithTag:11]).placeholder isEqual:@"AI Player Name"]) {
                [indexOfAIParticpents addObject:@"0"];
            }
            if ([((UITextField*)[self.view viewWithTag:12]).placeholder isEqual:@"AI Player Name"]) {
                [indexOfAIParticpents addObject:@"1"];
            }
            
            
            break;
        case 3:
            if ([((UITextField*)[self.view viewWithTag:11]).text isEqual:@""]) {
                ((UITextField*)[self.view viewWithTag:11]).text = @"Player 1";
            }
            if ([((UITextField*)[self.view viewWithTag:12]).text isEqual:@""]) {
                ((UITextField*)[self.view viewWithTag:12]).text = @"Player 2";
            }
            if ([((UITextField*)[self.view viewWithTag:13]).text isEqual:@""]) {
                ((UITextField*)[self.view viewWithTag:13]).text = @"Player 3";
            }
            [participents addObject:((UITextField*)[self.view viewWithTag:11]).text];
            [participents addObject:((UITextField*)[self.view viewWithTag:12]).text];
            [participents addObject:((UITextField*)[self.view viewWithTag:13]).text];
            if ([((UITextField*)[self.view viewWithTag:11]).placeholder isEqual:@"AI Player Name"]) {
                [indexOfAIParticpents addObject:@"0"];
            }
            if ([((UITextField*)[self.view viewWithTag:12]).placeholder isEqual:@"AI Player Name"]) {
                [indexOfAIParticpents addObject:@"1"];
            }
            if ([((UITextField*)[self.view viewWithTag:13]).placeholder isEqual:@"AI Player Name"]) {
                [indexOfAIParticpents addObject:@"2"];
            }
            break;
        case 4:
            if ([((UITextField*)[self.view viewWithTag:11]).text isEqual:@""]) {
                ((UITextField*)[self.view viewWithTag:11]).text = @"Player 1";
            }
            if ([((UITextField*)[self.view viewWithTag:12]).text isEqual:@""]) {
                ((UITextField*)[self.view viewWithTag:12]).text = @"Player 2";
            }
            if ([((UITextField*)[self.view viewWithTag:13]).text isEqual:@""]) {
                ((UITextField*)[self.view viewWithTag:13]).text = @"Player 3";
            }
            if ([((UITextField*)[self.view viewWithTag:14]).text isEqual:@""]) {
                ((UITextField*)[self.view viewWithTag:14]).text = @"Player 4";
            }
            [participents addObject:((UITextField*)[self.view viewWithTag:11]).text];
            [participents addObject:((UITextField*)[self.view viewWithTag:12]).text];
            [participents addObject:((UITextField*)[self.view viewWithTag:13]).text];
            [participents addObject:((UITextField*)[self.view viewWithTag:14]).text];
            if ([((UITextField*)[self.view viewWithTag:11]).placeholder isEqual:@"AI Player Name"]) {
                [indexOfAIParticpents addObject:@"0"];
            }
            if ([((UITextField*)[self.view viewWithTag:12]).placeholder isEqual:@"AI Player Name"]) {
                [indexOfAIParticpents addObject:@"1"];
            }
            if ([((UITextField*)[self.view viewWithTag:13]).placeholder isEqual:@"AI Player Name"]) {
                [indexOfAIParticpents addObject:@"2"];
            }
            if ([((UITextField*)[self.view viewWithTag:14]).placeholder isEqual:@"AI Player Name"]) {
                [indexOfAIParticpents addObject:@"3"];
            }
            break;
            
        default:
            break;
    }
    
    int matchID = [defaults integerForKey:@"totalMatches"]+1;
    if (matchID == 1) {
        matchID++;
    }
    NSMutableArray * allMatchIDS = [[NSMutableArray alloc]init];
    for (id objects in [defaults valueForKey:@"allMatchIDS"]) {
        [allMatchIDS addObject:objects];
    }
    [allMatchIDS addObject:[NSString stringWithFormat:@"%d",matchID]];
    [defaults setValue:allMatchIDS forKey:@"allMatchIDS"];
    [defaults setInteger:matchID forKey:@"totalMatches"];
    
    NSString *potientialMatch = matchName.text;
    if ([potientialMatch isEqual:@""]) {
        potientialMatch = @"Local Match";
    }
    
    
    NSArray * objectsForDictionary = [NSArray arrayWithObjects:potientialMatch,@"0", participents, indexOfAIParticpents, nil];
    
    NSArray * keysForDictionary = [NSArray arrayWithObjects:@"MatchName",@"currentPlayerIndex", @"participants",@"indexOfAIParticpents", nil];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjects:objectsForDictionary forKeys:keysForDictionary];
    
    [defaults setValue:dict forKey:[NSString stringWithFormat:@"%dLocalMatch",matchID]];
    
    [defaults synchronize];
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)updateInterface {
    
    if (_players.count >= 2) {
        saveButton.hidden = NO;
        prompt.hidden = YES;
    }
    else {
        saveButton.hidden = YES;
        prompt.hidden = NO;
    }

    
    
    if (_players.count >=4) {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
    else {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
    
}


@end
