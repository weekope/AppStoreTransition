//
//  AnimatorShowDetail.m
//  appstore_transition
//
//  Created by 周希 on 2018/1/19.
//

#import "AnimatorShowDetail.h"

@implementation AnimatorShowDetail

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *viewTo   = [transitionContext viewForKey:UITransitionContextToViewKey];
    viewTo.alpha = 0.0f;
    [transitionContext.containerView addSubview:viewTo];
    
    [UIView animateWithDuration:1.0f
                     animations:^{
                         viewTo.alpha = 1.0f;
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:YES];
                     }];
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 1.0f;
}

@end
