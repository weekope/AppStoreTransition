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
    [self.navigationController.interactivePopGestureRecognizer removeTarget:nil action:nil];
    [self.navigationController.interactivePopGestureRecognizer addTarget:self action:@selector(actionInteractivePop:)];
    [UIView animateWithDuration:0.3f animations:^{
        _hidden = YES;
        [self setNeedsStatusBarAppearanceUpdate];
    }];
    
    self.tableView.contentInset = UIEdgeInsetsMake(headerHeight, 0.0f, 0.0f, 0.0f);
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(headerHeight, 0.0f, 0.0f, 0.0f);
    
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, -headerHeight, CGRectGetWidth(self.tableView.frame), headerHeight)];
    iv.image = [UIImage imageNamed:@"image"];
    iv.contentMode = UIViewContentModeScaleAspectFill;
    iv.clipsToBounds = YES;
    iv.tag = 1000;
    [self.tableView addSubview:iv];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)-52.0f, 20.0f-headerHeight, 32.0f, 32.0f)];
    button.backgroundColor = [UIColor whiteColor];
    button.layer.cornerRadius = 16.0f;
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


#pragma mark - action

- (void)actionInteractivePop:(UIGestureRecognizer *)gesture {
    CGFloat progress = [gesture locationInView:self.view].x / CGRectGetWidth(self.view.frame);
    progress = MIN(1.0, MAX(0.0, progress));
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            _interactiveTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case UIGestureRecognizerStateChanged:
            if (progress > 0.4f) {
                [_interactiveTransition finishInteractiveTransition];
            }
            else {
                [_interactiveTransition updateInteractiveTransition:progress];
            }
            break;
        case UIGestureRecognizerStateEnded:
            if (progress > 0.4f) {
                [_interactiveTransition finishInteractiveTransition];
            }
            else {
                [_interactiveTransition cancelInteractiveTransition];
            }
            break;
        default:
            break;
    }
}

@end
