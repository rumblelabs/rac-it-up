//
//  UINavigationItem+indicateActivityWithSignal.m
//  RACItUp
//
//  Created by Iain Wilson on 08/08/2014.
//  Copyright (c) 2014 Rumble Labs. All rights reserved.
//

#import "UINavigationItem+indicateActivityWithSignal.h"
#import "UIActivityIndicatorView+animateWithSignal.h"

@implementation UINavigationItem (indicateActivityWithSignal)

- (RACSignal *)rmb_indicateActivityWithSignal:(RACSignal *)signal {
  UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];

  return [[RACSignal createSignal:^(id<RACSubscriber> subscriber) {
    RACSignal *animated = [activityIndicator rmb_animateWithSignal:signal];

    UIView *previousTitleView = self.titleView;
    BOOL didHideBackButton = self.hidesBackButton;

    self.titleView = activityIndicator;
    self.hidesBackButton = YES;

    RACDisposable *indicatorDisposable = [animated subscribe:subscriber];

    RACDisposable *titleViewDisposable = [RACDisposable disposableWithBlock:^{
      self.titleView = previousTitleView;
      self.hidesBackButton = didHideBackButton;
    }];

    return [RACCompoundDisposable compoundDisposableWithDisposables:@[
      indicatorDisposable,
      titleViewDisposable
    ]];
  }] setNameWithFormat:@"[%@] -rmb_indicateActivityWithSignal: %@", self, signal];
}

@end
