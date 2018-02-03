//
//  ViewController.m
//  appstore_transition
//
//  Created by 周希 on 2018/1/15.
//

#import "ViewController.h"
#import "AnimatorShowDetail.h"
#import "AnimatorShowImage.h"
#import "DetailTableVC.h"





@interface ViewController () <UINavigationControllerDelegate>

@property (nonatomic, strong) DetailTableVC *destinationVC;

@end





@implementation ViewController

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


#pragma mark - transition

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPush) {
        return [[AnimatorShowDetail alloc] init];
    }
    else if (operation == UINavigationControllerOperationPop) {
        return [[AnimatorShowImage alloc] initWithCloses:_destinationVC.isClosed];
    }
    else {
        return nil;
    }
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                         interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    return _destinationVC.interactiveTransition;
}


#pragma mark - segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    _destinationVC = segue.destinationViewController;
}

@end
