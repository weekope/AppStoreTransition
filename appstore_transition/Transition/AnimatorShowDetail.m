//
//  AnimatorShowDetail.m
//  appstore_transition
//
//  Created by 周希 on 2018/1/19.
//

#import "AnimatorShowDetail.h"

@implementation AnimatorShowDetail

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *viewTo = [transitionContext viewForKey:UITransitionContextToViewKey];
    [transitionContext.containerView addSubview:viewTo];
    
    [UIView animateWithDuration:0.5f
                     animations:^{
                         viewTo.frame = UIScreen.mainScreen.bounds;
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:YES];
                     }];
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5f;
}

@end
