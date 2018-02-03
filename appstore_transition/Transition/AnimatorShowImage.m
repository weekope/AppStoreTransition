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

    [transitionContext.containerView insertSubview:[transitionContext viewForKey:UITransitionContextToViewKey] belowSubview:transitionContext.containerView.subviews.lastObject];
    UIView *viewFrom = [transitionContext viewForKey:UITransitionContextFromViewKey];

    //可以使用maskView或者mask+bezierPath
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0.0f, ((UITableView *)viewFrom).contentOffset.y, CGRectGetWidth(UIScreen.mainScreen.bounds), CGRectGetHeight(UIScreen.mainScreen.bounds))];
    v.backgroundColor = [UIColor whiteColor];
    v.layer.cornerRadius = 0.0f;
    viewFrom.maskView = v;
    
    if (_isClosed) {
        [UIView animateWithDuration:transitionDuration
                         animations:^{
                             viewFrom.frame = CGRectMake(CGRectGetMinX(viewFrom.frame), CGRectGetMinY([[transitionContext viewForKey:UITransitionContextToViewKey] viewWithTag:1000].frame),
                                                         CGRectGetWidth(viewFrom.frame), CGRectGetHeight(viewFrom.frame));
                             viewFrom.maskView.frame = CGRectMake(imageMaskLeftRight, imageMaskTopBottom-imageOriginHeight, CGRectGetWidth(UIScreen.mainScreen.bounds)-imageMaskLeftRight*2, imageMaskHeight);
                             viewFrom.maskView.layer.cornerRadius = imageMaskCornerRadius;
                             ((UITableView *)viewFrom).contentOffset = CGPointMake(0.0f, -imageOriginHeight);
                         }
                         completion:^(BOOL finished) {
                             [transitionContext completeTransition:YES];
                         }];
    }
    else {
        [UIView animateWithDuration:0.3f
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
    return 0.3f;
}

- (void)animationEnded:(BOOL)transitionCompleted {
    if (!_isClosed) {
        if (transitionCompleted) {
            UIView *viewFrom = [_transitionContext viewForKey:UITransitionContextFromViewKey];
            [_transitionContext.containerView addSubview:viewFrom];

            [UIView animateWithDuration:animationEndDuration
                             animations:^{
                                 viewFrom.transform = CGAffineTransformIdentity;
                                 viewFrom.frame = CGRectMake(CGRectGetMinX(viewFrom.frame), CGRectGetMinY([[_transitionContext viewForKey:UITransitionContextToViewKey] viewWithTag:1000].frame),
                                                             CGRectGetWidth(viewFrom.frame), CGRectGetHeight(viewFrom.frame));
                                 viewFrom.maskView.frame = CGRectMake(imageMaskLeftRight, imageMaskTopBottom-imageOriginHeight, CGRectGetWidth(UIScreen.mainScreen.bounds)-imageMaskLeftRight*2, imageMaskHeight);
                                 ((UITableView *)viewFrom).contentOffset = CGPointMake(0.0f, -imageOriginHeight);
                             }
                             completion:^(BOOL finished) {
                                 [viewFrom removeFromSuperview];
                             }];
        }
        else {
            UIView *viewFrom = [_transitionContext viewForKey:UITransitionContextFromViewKey];
            viewFrom.maskView = nil;
        }
    }
}

@end
