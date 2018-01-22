//
//  DetailTableVC.m
//  appstore_transition
//
//  Created by 周希 on 2018/1/15.
//

#import "DetailTableVC.h"



const CGFloat headerHeight = 450.0f;



@interface DetailTableVC ()

@property (nonatomic, assign) BOOL hidden;

@end



@implementation DetailTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    [UIView animateWithDuration:0.3f animations:^{
        _hidden = YES;
        [self setNeedsStatusBarAppearanceUpdate];
    }];
    
    self.tableView.contentInset = UIEdgeInsetsMake(headerHeight, 0.0f, 0.0f, 0.0f);
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(headerHeight, 0.0f, 0.0f, 0.0f);
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0f, -headerHeight, CGRectGetWidth(self.tableView.frame), headerHeight)];
    view.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:78.0f/255.0f blue:49.0f/255.0f alpha:1.0f];
    view.tag = 1000;
    [self.tableView addSubview:view];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)-60.0f, 20.0f-headerHeight, 40.0f, 40.0f)];
    button.backgroundColor = [UIColor whiteColor];
    button.layer.cornerRadius = 20.0f;
    button.tag = 2000;
    [button addTarget:self action:@selector(actionPop:) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:button];
}

- (BOOL)prefersStatusBarHidden {
    return _hidden;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationSlide;
}

- (void)actionPop:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - scroll

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y==-headerHeight && [scrollView.panGestureRecognizer velocityInView:scrollView].y>0.0f) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < -headerHeight) {
        UIView *v = [self.tableView viewWithTag:1000];
        v.frame = CGRectMake(CGRectGetMinX(v.frame), scrollView.contentOffset.y,
                             CGRectGetWidth(v.frame), CGRectGetHeight(v.frame));
    }
    
    UIButton *b = [self.tableView viewWithTag:2000];
    b.frame = CGRectMake(CGRectGetMinX(b.frame), 20.0f+scrollView.contentOffset.y,
                         CGRectGetWidth(b.frame), CGRectGetHeight(b.frame));
    b.backgroundColor = scrollView.contentOffset.y>0.0f ? [UIColor blackColor] : [UIColor whiteColor];
}

@end
