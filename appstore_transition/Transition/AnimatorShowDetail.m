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
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(imageMaskLeftRight, imageMaskTopBottom-imageOriginHeight, CGRectGetWidth(UIScreen.mainScreen.bounds)-imageMaskLeftRight*2, imageMaskHeight)];
    v.backgroundColor = [UIColor whiteColor];
    v.layer.cornerRadius = imageMaskCornerRadius;
    viewTo.maskView = v;
    
    [UIView animateWithDuration:transitionDuration
                     animations:^{
                         viewTo.frame = UIScreen.mainScreen.bounds;
                         viewTo.maskView.frame = CGRectMake(0.0f, -imageOriginHeight, CGRectGetWidth(viewTo.frame), CGRectGetHeight(viewTo.frame));
                         viewTo.maskView.layer.cornerRadius = 0.0f;
                     }
                     completion:^(BOOL finished) {
                         viewTo.maskView = nil;
                         [transitionContext completeTransition:YES];
                     }];
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return transitionDuration;
}

@end
