//
//  EggLoadingView.m
//  NeweggCNiPhone
//
//  Created by Pis Chen on 14-4-9.
//  Copyright (c) 2015年 macbook. All rights reserved.
//

#import "EggLoadingView.h"

static const CGFloat AnimationDuration = 2.0f;
static const CGFloat AnimationInterval = 0.8f;

typedef NS_ENUM(char, ShadowImageViewState){
    ShadowImageViewStateNormal,
    ShadowImageViewStateBig,
    ShadowImageViewStateSmall
};

@interface EggLoadingView ()
@property (weak, nonatomic) IBOutlet UIImageView *eggImageView;
@property (weak, nonatomic) IBOutlet UIImageView *shadowImageView;

@property (nonatomic, assign) CGPoint	originPosition;
@end

@implementation EggLoadingView
+ (id)viewFromXib {
    Class cellClass = [self class];
    NSString *cellClassName = NSStringFromClass(cellClass);
    NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:cellClassName owner:nil options:nil];
    for (NSObject *item in nibArray) {
        if ([item isMemberOfClass:cellClass]) {
            return item;
        }
    }
    return nil;
}
- (void)awakeFromNib
{
    [self reset];
    self.originPosition = self.eggImageView.layer.position;
    
}

- (void)startAnimating{
    NSArray *animationImages = @[@"image_egg_loading1",
                                 @"image_egg_loading1",
                                 @"image_egg_loading1",
                                 @"image_egg_loading1",
                                 @"image_egg_loading2",
                                 @"image_egg_loading2",
                                 @"image_egg_loading2",
                                 @"image_egg_loading2",
                                 @"image_egg_loading2",
                                 @"image_egg_loading1",
                                 @"image_egg_loading1",
                                 @"image_egg_loading3",
                                 @"image_egg_loading3",
                                 @"image_egg_loading3",
                                 @"image_egg_loading1_1",
                                 @"image_egg_loading1_1",
                                 @"image_egg_loading1_1",
                                 @"image_egg_loading2_1",
                                 @"image_egg_loading2_1",
                                 @"image_egg_loading1_1",
                                 @"image_egg_loading3",
                                 @"image_egg_loading3",
                                 @"image_egg_loading2",
                                 @"image_egg_loading2",
                                 @"image_egg_loading1",
                                 @"image_egg_loading3",
                                 @"image_egg_loading3",
                                 @"image_egg_loading2_1",
                                 @"image_egg_loading2_1",
                                 @"image_egg_loading3",
                                 @"image_egg_loading3",
                                 @"image_egg_loading3",
                                 @"image_egg_loading2",
                                 @"image_egg_loading2",
                                 @"image_egg_loading1",
                                 @"image_egg_loading1",
                                 @"image_egg_loading1",
                                 @"image_egg_loading1",
                                 @"image_egg_loading1",
                                 @"image_egg_loading1"
                                 ];
    
    NSMutableArray *images = [NSMutableArray array];
    for(NSString *imageName in animationImages){
        [images addObject:[UIImage imageNamed:imageName]];
    }
    self.eggImageView.animationDuration = AnimationDuration;
    self.eggImageView.animationImages = images;
    [self.eggImageView startAnimating];
    
    CAAnimation *shadowImageViewAnimation = [self shadowImageViewAnimation];
    shadowImageViewAnimation.delegate = self;
    [self.shadowImageView.layer addAnimation:shadowImageViewAnimation
                                      forKey:nil];
    [self.eggImageView.layer addAnimation:[self eggAnimation]
                                   forKey:nil];
}

- (void)stopAnimating{
    [self reset];
}


- (void)reset{
    [self.shadowImageView.layer removeAllAnimations];
    [self.eggImageView.layer removeAllAnimations];
    [self.eggImageView stopAnimating];
    
    self.shadowImageView.transform = CGAffineTransformMakeScale(0.8f, 0.8f);
    self.shadowImageView.alpha = 0.8f;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self reset];
    
    [self performSelector:@selector(startAnimating)
               withObject:nil
               afterDelay:AnimationInterval];
}

- (CAAnimation *)shadowImageViewAnimation{
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    
    ShadowImageViewState states[] = {
        ShadowImageViewStateNormal,
        ShadowImageViewStateBig,
        ShadowImageViewStateNormal,
        ShadowImageViewStateSmall,
        ShadowImageViewStateSmall,
        ShadowImageViewStateBig,
        ShadowImageViewStateSmall,
        ShadowImageViewStateSmall,
        ShadowImageViewStateBig,
        ShadowImageViewStateSmall,
        ShadowImageViewStateNormal,
        ShadowImageViewStateSmall,
        ShadowImageViewStateNormal
    };
    
    CGFloat times[] = {
        0.1,
        0.125,
        0.05,
        0.25,
        0.025,
        0.05,
        0.175,
        0.025,
        0.05,
        0.05,
        0.05,
        0.05
    };
    
    NSMutableArray *keyTimes = [NSMutableArray array];
    short keyTimeLength = sizeof(times) / sizeof(CGFloat);
    CGFloat startTime = 0;
    for(short i = 0; i <= keyTimeLength; i++){
        [keyTimes addObject:@(startTime)];
        startTime += times[i];
    }
    
    short statesLength = sizeof(states) / sizeof(ShadowImageViewState);
    
    NSDictionary *stateAlphaMapping = @{@(ShadowImageViewStateNormal)	: @(0.8),
                                        @(ShadowImageViewStateBig)		: @(1),
                                        @(ShadowImageViewStateSmall)	: @(0.6)};
    
    NSMutableArray *shadowImageViewAlphaValues = [NSMutableArray array];
    for(short i = 0; i < statesLength; i++){
        [shadowImageViewAlphaValues addObject:stateAlphaMapping[@(states[i])]];
    }
    
    NSDictionary *stateScaleMapping = @{
                                        @(ShadowImageViewStateNormal)	: @(0.8),
                                        @(ShadowImageViewStateBig)		: @(1),
                                        @(ShadowImageViewStateSmall)	: @(0.5)
                                        };
    
    NSMutableArray *shadowImageViewScaleValues = [NSMutableArray array];
    for(short i = 0; i < statesLength; i++){
        CGFloat scale = [stateScaleMapping[@(states[i])] floatValue];
        
        [shadowImageViewScaleValues addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(scale, scale, 1)]];
    }
    
    CAKeyframeAnimation *alphaAnimation = [CAKeyframeAnimation animationWithKeyPath:@"alpha"];
    alphaAnimation.keyTimes = keyTimes;
    alphaAnimation.values = shadowImageViewAlphaValues;
    
    CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.keyTimes = keyTimes;
    scaleAnimation.values = shadowImageViewScaleValues;
    
    animationGroup.animations = @[alphaAnimation, scaleAnimation];
    animationGroup.duration = AnimationDuration;
    
    return animationGroup;
}

- (CAAnimation *)eggPositionAnimation{
    CGFloat positionOffsetY[] = {
        0,
        0,
        -10,
        -15,
        -26,
        -38,
        -26,
        -15,
        -3,
        0,
        -5,
        -10,
        -27,
        -10,
        -3,
        0,
        -4,
        0,
        -2,
        0
    };
    CGFloat positionTranslationTimes[] = {
        0.225,
        0.05,
        0.025,
        0.05,
        0.075,
        0.05,
        0.025,
        0.025,
        0.025,
        0.05,
        0.025,
        0.05,
        0.05,
        0.05,
        0.025,
        0.05,
        0.05,
        0.05,
        0.05
    };
    
    NSMutableArray *positionTranslationValues = [NSMutableArray array];
    short positionTranslationLength = sizeof(positionOffsetY) / sizeof(CGFloat);
    
    for(short i = 0; i < positionTranslationLength; i++){
        CGFloat offsetY = positionOffsetY[i];
        CGPoint newPosition = CGPointMake(self.originPosition.x, self.originPosition.y + offsetY);
        
        [positionTranslationValues addObject:[NSValue valueWithCGPoint:newPosition]];
    }
    
    NSMutableArray *keyTimes = [NSMutableArray array];
    short timesLength = sizeof(positionTranslationTimes) / sizeof(CGFloat);
    
    CGFloat startTime = 0;
    for(short i = 0; i <= timesLength; i++){
        [keyTimes addObject:@(startTime)];
        startTime += positionTranslationTimes[i];
    }
    
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAnimation.values = positionTranslationValues;
    positionAnimation.keyTimes = keyTimes;
    
    return positionAnimation;
}



- (CAAnimation *)eggAnimation{
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    
    animationGroup.animations = @[[self eggPositionAnimation]];
    animationGroup.duration = AnimationDuration;
    
    return animationGroup;
}
@end
