//
//  EggLoadingView.h
//  NeweggCNiPhone
//
//  Created by Pis Chen on 14-4-9.
//  Copyright (c) 2015年 macbook. All rights reserved.
//
#import <UIKit/UIKit.h>
@interface EggLoadingView : UIView
- (void)startAnimating;
- (void)stopAnimating;
+ (id)viewFromXib;
@end
