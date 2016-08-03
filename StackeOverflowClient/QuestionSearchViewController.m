//
//  QuestionSearchViewController.m
//  StackeOverflowClient
//
//  Created by Michael Sweeney on 8/1/16.
//  Copyright © 2016 Michael Sweeney. All rights reserved.
//

#import "QuestionSearchViewController.h"
#import "StackOverflowService.h"
#import "Question.h"

@interface QuestionSearchViewController () <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *searchedQuestions;

@end

@implementation QuestionSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView.dataSource = self;
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSString *token = [[NSUserDefaults standardUserDefaults]objectForKey:@"token"];

    if (token) {
        
        [StackOverflowService questionsForSearchTerm:@"iOS" completionHandler:^(NSArray *results, NSError *error) {
            
            if (error) {
                NSLog(@"%@", error.localizedDescription);
                return;
            }
            
            self.searchedQuestions = results;
            [self.tableView reloadData];
        
        }];
        
    }
    
    
}

#pragma mark - TableViewDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuestionCell" forIndexPath:indexPath];
    
    Question *currentQuesion = self.searchedQuestions[indexPath.row];
    cell.textLabel.text = currentQuesion.title;
    
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.searchedQuestions.count;
    
}

@end
