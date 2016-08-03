//
//  UserQuestionsViewController.m
//  StackeOverflowClient
//
//  Created by Michael Sweeney on 8/1/16.
//  Copyright © 2016 Michael Sweeney. All rights reserved.
//

#import "UserQuestionsViewController.h"
#import "StackOverflowService.h"
#import "User.h"

@interface UserQuestionsViewController ()<UITableViewDataSource, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) NSArray *searchedArray;

@end

@implementation UserQuestionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchBar.delegate = self;
    self.tableView.dataSource = self;

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    _searchBar.placeholder = @"Enter a name";
    
   }

#pragma mark - TableViewDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserCell" forIndexPath:indexPath];
    
    User *user = self.searchedArray[indexPath.row];
    cell.textLabel.text = user.username;
    
    return cell;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.searchedArray.count;
}

#pragma mark - SearchBarDelegate

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    NSString *searchText = searchBar.text;
    NSString *token = [[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    
    if (token) {
        
        [StackOverflowService usersForSearchTerm:searchText completionHandler:^(NSArray *results, NSError *error) {
            
            if (!error) {
                
                NSLog(@"why no work? Plz work. Work naow!");
                
                self.searchedArray = results;
//                NSLog(@"%@", _searchedArray);
                
                [self.tableView reloadData];
                
            } else {
                NSLog(@"%@", error.localizedDescription);
            }

        }];
        
    }
}

@end
