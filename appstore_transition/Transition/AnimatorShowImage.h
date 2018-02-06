//
//  AnimatorDismiss.h
//  appstore_transition
//
//  Created by 周希 on 2018/1/19.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>





@interface AnimatorShowImage : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) BOOL isClosed;
@property (nonatomic, assign) CGFloat viewYTo;
@property (nonatomic, strong) UIView *viewToTransition;

@end
