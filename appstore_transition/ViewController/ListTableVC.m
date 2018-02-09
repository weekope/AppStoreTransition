//
//  ViewController.m
//  appstore_transition
//
//  Created by 周希 on 2018/1/15.
//

#import "ListTableVC.h"
#import "AnimatorShowDetail.h"
#import "AnimatorShowImage.h"
#import "DetailTableVC.h"





@interface ListTableVC () <UINavigationControllerDelegate>

@property (nonatomic, strong) DetailTableVC *destinationVC;
@property (nonatomic, assign) CGFloat imageTappedY;
@property (nonatomic, strong) UIView *viewToTransition;

@end





@implementation ListTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationController.delegate = self;
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(imageMaskLeftRight, imageMaskTopBottom, CGRectGetWidth(UIScreen.mainScreen.bounds)-imageMaskLeftRight*2, imageMaskHeight)];
    v.backgroundColor = [UIColor whiteColor];
    v.layer.cornerRadius = imageMaskCornerRadius;
    [self.view viewWithTag:1000].maskView = v;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - table view

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return imageOriginHeight+imageMaskTopBottom*2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_card"];
    
    ((UIImageView *)[cell viewWithTag:1000]).image = [UIImage imageNamed:[NSString stringWithFormat:@"image%ld",(long)indexPath.row]];
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(imageMaskLeftRight, imageMaskTopBottom, CGRectGetWidth(UIScreen.mainScreen.bounds)-imageMaskLeftRight*2, imageMaskHeight)];
    v.backgroundColor = [UIColor whiteColor];
    v.layer.cornerRadius = imageMaskCornerRadius;
    [cell viewWithTag:1000].maskView = v;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTap:)];
    tap.accessibilityHint = [NSString stringWithFormat:@"image%ld",(long)indexPath.row];
    [[cell viewWithTag:1000] addGestureRecognizer:tap];
    
    return cell;
}


#pragma mark - action

- (void)actionTap:(UITapGestureRecognizer *)gesture {
    _imageTappedY = 25.0f+CGRectGetMinY(gesture.view.superview.superview.frame)-self.tableView.contentOffset.y;
    _viewToTransition = gesture.view;
    [self performSegueWithIdentifier:@"segue_list_detail" sender:gesture.accessibilityHint];
}


#pragma mark - transition

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPush) {
        AnimatorShowDetail *animator = [[AnimatorShowDetail alloc] init];
        animator.viewYFrom = _imageTappedY;
        return animator;
    }
    else if (operation == UINavigationControllerOperationPop) {
        AnimatorShowImage *animator = [[AnimatorShowImage alloc] init];
        animator.isClosed = _destinationVC.isClosed;
        animator.viewYTo = _imageTappedY;
        animator.viewToTransition = _viewToTransition;
        return animator;
    }
    else {
        return nil;
    }
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                         interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    //返回值必须和实际转场类型强关联。例：非交互式转场返回空，交互式转场返回interactive对象
    return _destinationVC.interactiveTransition;
}


#pragma mark - segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    _destinationVC = segue.destinationViewController;
    _destinationVC.imageName = sender;
}

@end
