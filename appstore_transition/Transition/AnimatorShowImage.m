//
//  AnimatorDismiss.m
//  appstore_transition
//
//  Created by 周希 on 2018/1/19.
//

#import "AnimatorShowImage.h"





@interface AnimatorShowImage ()

@property (nonatomic, assign) BOOL isClosed;
@property (nonatomic, strong) id<UIViewControllerContextTransitioning> transitionContext;

@end





@implementation AnimatorShowImage

- (instancetype)initWithCloses:(BOOL)isClosed {
    self = [super init];
    if (self) {
        _isClosed = isClosed;
    }
    return self;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    _transitionContext = transitionContext;
    
    if (_isClosed) {
        
    }
    else {
        [transitionContext.containerView insertSubview:[transitionContext viewForKey:UITransitionContextToViewKey] belowSubview:transitionContext.containerView.subviews.lastObject];
        UIView *viewFrom = [transitionContext viewForKey:UITransitionContextFromViewKey];
        
        //可以使用maskView或者mask+bezierPath
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0.0f, -450.0f, CGRectGetWidth(viewFrom.frame), CGRectGetHeight(viewFrom.frame))];
        v.backgroundColor = [UIColor whiteColor];
        v.layer.cornerRadius = 0.0f;
        viewFrom.maskView = v;

        [UIView animateWithDuration:0.7f
                         animations:^{
                             viewFrom.transform = CGAffineTransformMakeScale(0.8f, 0.8f);
                             viewFrom.maskView.layer.cornerRadius = 16.0f;
                         }
                         completion:^(BOOL finished) {
                             [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
                         }];
    }
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.7f;
}

- (void)animationEnded:(BOOL)transitionCompleted {
    if (transitionCompleted) {
        UIView *viewFrom = [_transitionContext viewForKey:UITransitionContextFromViewKey];
        UIView *viewTo   = [_transitionContext viewForKey:UITransitionContextToViewKey];
        [_transitionContext.containerView addSubview:viewFrom];
        
        [UIView animateWithDuration:0.3f
                         animations:^{
                             viewFrom.transform = CGAffineTransformIdentity;
                             viewFrom.frame = CGRectMake(CGRectGetMinX(viewFrom.frame), CGRectGetMinY([viewTo viewWithTag:1000].frame),
                                                         CGRectGetWidth(viewFrom.frame), CGRectGetHeight(viewFrom.frame));
                             viewFrom.maskView.frame = CGRectMake(20.0f, 25.0f-450.0f, CGRectGetWidth(UIScreen.mainScreen.bounds)-40.0f, 400.0f);
                         }
                         completion:^(BOOL finished) {
                             [viewFrom removeFromSuperview];
                         }];
    }
    else {
        UIView *viewFrom = [_transitionContext viewForKey:UITransitionContextFromViewKey];
        viewFrom.transform = CGAffineTransformIdentity;
        viewFrom.maskView = nil;
    }
}

@end
