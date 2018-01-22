//
//  ViewController.m
//  appstore_transition
//
//  Created by 周希 on 2018/1/15.
//

#import "ViewController.h"
#import "AnimatorShowDetail.h"
#import "AnimatorShowImage.h"





@interface ViewController () <UINavigationControllerDelegate>

@end





@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationController.delegate = self;
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
    else {
        return [[AnimatorShowImage alloc] init];
    }
}

@end
