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
    viewTo.frame = CGRectMake(CGRectGetMinX(viewTo.frame), CGRectGetMinY([[transitionContext viewForKey:UITransitionContextFromViewKey] viewWithTag:1000].frame),
                              CGRectGetWidth(viewTo.frame), CGRectGetHeight(viewTo.frame));
    [transitionContext.containerView addSubview:viewTo];
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(20.0f, 25.0f-450.0f, CGRectGetWidth(UIScreen.mainScreen.bounds)-40.0f, 400.0f)];
    v.backgroundColor = [UIColor whiteColor];
    v.layer.cornerRadius = 16.0f;
    viewTo.maskView = v;
    
    [UIView animateWithDuration:0.5f
                     animations:^{
                         viewTo.frame = UIScreen.mainScreen.bounds;
                         viewTo.maskView.frame = CGRectMake(0.0f, -450.0f, CGRectGetWidth(viewTo.frame), CGRectGetHeight(viewTo.frame));
                         viewTo.maskView.layer.cornerRadius = 0.0f;
                     }
                     completion:^(BOOL finished) {
                         viewTo.maskView = nil;
                         [transitionContext completeTransition:YES];
                     }];
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5f;
}

@end
