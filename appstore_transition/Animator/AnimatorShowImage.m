//
//  AnimatorDismiss.m
//  appstore_transition
//
//  Created by 周希 on 2018/1/19.
//

#import "AnimatorShowImage.h"

@implementation AnimatorShowImage

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    [UIView animateWithDuration:1.0f
                     animations:^{
                         [transitionContext viewForKey:UITransitionContextFromViewKey].alpha = 0.0f;
                     }
                     completion:^(BOOL finished) {
                         [transitionContext.containerView addSubview:[transitionContext viewForKey:UITransitionContextToViewKey]];
                         [transitionContext completeTransition:YES];
                     }];
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 1.0f;
}

@end
