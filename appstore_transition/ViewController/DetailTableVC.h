//
//  DetailTableVC.h
//  appstore_transition
//
//  Created by 周希 on 2018/1/15.
//

#import <UIKit/UIKit.h>





@interface DetailTableVC : UITableViewController

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactiveTransition;
@property (nonatomic, assign) BOOL isClosed;
@property (nonatomic, copy) NSString *imageName;

@end
