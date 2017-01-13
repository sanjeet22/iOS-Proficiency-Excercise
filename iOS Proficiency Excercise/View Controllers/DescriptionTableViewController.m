//
//  DescriptionTableViewController.m
//  iOS Proficiency Excercise
//
//  Created by Sanjeet on 1/11/17.
//  Copyright © 2017 Sanjeet. All rights reserved.
//

#import "DescriptionTableViewController.h"
#import "DataCell.h"
#import "Reachability.h"

float   const heightOfTableViewCell = 103.0f;
float   const heightOfNavigationBar = 44.0f;


@interface DescriptionTableViewController ()
{
    
}

@end

@implementation DescriptionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    CGRect frame = spinner.frame;
    frame.origin.x = self.view.frame.size.width / 2 - frame.size.width / 2;
    frame.origin.y = self.view.frame.size.height / 2 - frame.size.height / 2 - heightOfNavigationBar;
    spinner.frame = frame;
    [self.view addSubview:spinner];
    [self.tableView bringSubviewToFront:spinner];
    [spinner startAnimating];
    [spinner setHidden:NO];
    
    [self fetchData];
    
    
    // Pull to refresh 
    refreshControl = [[UIRefreshControl alloc]init];
    [self.tableView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    
}

# pragma arg fetching data 

- (void)fetchData
{
    [NetworkEngine fetchDataWithCompletion:^(NSDictionary * _Nullable response, NSError * _Nullable error) {
        if (!response) {
           
            NetworkStatus networkStatus =
            [[Reachability reachabilityForInternetConnection]
             currentReachabilityStatus];
            if (networkStatus == NotReachable) {
                
                UIAlertController * alert=   [UIAlertController
                                              alertControllerWithTitle:@"Network Unavailable"
                                              message:@"Requires an Internet connection"
                                              preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* ok = [UIAlertAction
                                     actionWithTitle:@"OK"
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action)
                                     {
                                         //Do some thing here
                                         [alert dismissViewControllerAnimated:YES completion:nil];
                                         
                                     }];
                [alert addAction:ok];
                
                
            }

        }
        else {
            factData = [[Facts alloc] initWithDictionary:response];
            
            self.title = factData.screenTitle;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // update the UI with your calculated results
                
                [self.tableView reloadData];
                [spinner stopAnimating];
                [spinner setHidden:YES];
            });
            
        }
    }];

}

- (void)refreshTable {
    //TODO: refresh your data
    [refreshControl endRefreshing];
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return factData.factRows.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    
    // Configure the cell...
    
    static NSString *CellIdentifier = @"tableViewDataCell";
    DataCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[DataCell alloc]initWithFrame:CGRectZero reuseIdentifier:CellIdentifier];
        [cell setupCellUIConstraints];
    }
    //etc.
    
    FactsRow *row = [factData.factRows objectAtIndex:indexPath.row];
    
    cell.lableTitle.text = row.titleText;
    cell.lableDescription.text = row.descriptionText;
    
    // lazy loading
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:row.imageUrl] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            UIImage *image = [UIImage imageWithData:data];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    DataCell *myCell = (id)[tableView cellForRowAtIndexPath:indexPath];
                    if (myCell)
                        myCell.imageProfile.image = image;
                });
            }
        }
    }];
    [task resume];

    
    return cell;
    
    
}

#pragma mark - Table view delegates

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    static DataCell *cell = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        cell = [[DataCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"tableViewDataCell"];
    });
    
    [self setUpCell:cell atIndexPath:indexPath];
    
    return [self calculateHeightForConfiguredSizingCell:cell];
}

#pragma mark calculating height of each cell

// calculating the correct required height for each cell based upon its content.

- (CGFloat)calculateHeightForConfiguredSizingCell:(DataCell *)sizingCell {
    
    NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:sizingCell.lableTitle.text attributes:@{NSFontAttributeName:sizingCell.lableTitle.font}];
    CGRect rectTitle = [attributedTitle boundingRectWithSize:(CGSize){sizingCell.lableTitle.frame.size.width, CGFLOAT_MAX}
                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                     context:nil];
    
    NSAttributedString *attributedDesc = [[NSAttributedString alloc] initWithString:sizingCell.lableDescription.text attributes:@{NSFontAttributeName:sizingCell.lableDescription.font}];
    CGRect rectDesc = [attributedDesc boundingRectWithSize:(CGSize){sizingCell.lableDescription.frame.size.width, CGFLOAT_MAX}
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                   context:nil];
    
    float height = ceil(rectTitle.size.height) + ceil(rectDesc.size.height) + 25.0f; //calculating the correct required height for each cell based upon its content.
    
    return (height < heightOfTableViewCell) ? heightOfTableViewCell : height;; // return the correct required height for each cell based upon its content.
}



# pragma mark - Cell Setup

- (void)setUpCell:(DataCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    FactsRow *row = [factData.factRows objectAtIndex:indexPath.row];
    
    cell.lableTitle.text = row.titleText;
    cell.lableDescription.text = row.descriptionText;
    
}



@end
