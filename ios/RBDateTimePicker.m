/**
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "RBDateTimePicker.h"

#import <React/RCTUtils.h>
#import <React/UIView+React.h>

@interface RBDateTimePicker ()

@property (nonatomic, copy) RCTBubblingEventBlock onChange;
@property (nonatomic, assign) NSInteger reactMinuteInterval;

@end

@implementation RBDateTimePicker

- (instancetype)initWithFrame:(CGRect)frame
{
  if ((self = [super initWithFrame:frame])) {
    [self addTarget:self action:@selector(didChange)
               forControlEvents:UIControlEventValueChanged];
    _reactMinuteInterval = 1;
  }
  return self;
}

RCT_NOT_IMPLEMENTED(- (instancetype)initWithCoder:(NSCoder *)aDecoder)

- (void)didChange
{
  if (_onChange) {
    _onChange(@{ @"timestamp": @(self.date.timeIntervalSince1970 * 1000.0) });
  }
}

- (void)setDatePickerMode:(UIDatePickerMode)datePickerMode
{
  [super setDatePickerMode:datePickerMode];
  // We need to set minuteInterval after setting datePickerMode, otherwise minuteInterval is invalid in time mode.
  self.minuteInterval = _reactMinuteInterval;
}

- (void)setMinuteInterval:(NSInteger)minuteInterval
{
  [super setMinuteInterval:minuteInterval];
  _reactMinuteInterval = minuteInterval;
}

- (void)setDate:(NSDate *)date {
    // Need to avoid the case where values coming back through the bridge trigger a new valueChanged event
    if (![self.date isEqualToDate:date]) {
        [super setDate:date animated:YES];
    }
}

@end
