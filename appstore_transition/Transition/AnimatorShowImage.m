//
//  AnimatorDismiss.m
//  appstore_transition
//
//  Created by 周希 on 2018/1/19.
//

#import "AnimatorShowImage.h"

@implementation AnimatorShowImage

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {    
    [transitionContext.containerView insertSubview:[transitionContext viewForKey:UITransitionContextToViewKey] belowSubview:transitionContext.containerView.subviews.lastObject];
    [UIView animateWithDuration:0.5f
                     animations:^{
                         [transitionContext viewForKey:UITransitionContextFromViewKey].transform = CGAffineTransformMakeScale(0.8f, 0.8f);
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
                     }];
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5f;
}

@end
