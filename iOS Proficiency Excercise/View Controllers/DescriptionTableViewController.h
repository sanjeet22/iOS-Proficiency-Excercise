//
//  DescriptionTableViewController.h
//  iOS Proficiency Excercise
//
//  Created by Sanjeet on 1/11/17.
//  Copyright © 2017 Sanjeet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkEngine.h"
#import "Facts.h"

@interface DescriptionTableViewController : UITableViewController  <UITableViewDelegate,UITableViewDataSource>
{
    Facts *factData;
    NSMutableArray *dataSource;
    UIActivityIndicatorView *spinner;
    UIRefreshControl *refreshControl;

}
@end
