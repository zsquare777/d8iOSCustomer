

#import "DTCalendarConstants.h"

CGFloat const DTCalendarStandardHeaderHeight = 40;
CGFloat const DTCalendarStandardWeekdayHeight = 25;
CGFloat const DTCalendarStandardMonthlyPageHeight = 300.0;
CGFloat const DTCalendarStandardWeeklyPageHeight = 108+1/3.0;
CGFloat const DTCalendarStandardCellDiameter = 100/3.0;
CGFloat const DTCalendarStandardSeparatorThickness = 0.5;
CGFloat const DTCalendarAutomaticDimension = -1;
CGFloat const DTCalendarDefaultBounceAnimationDuration = 0.15;
CGFloat const DTCalendarStandardRowHeight = 38;
CGFloat const DTCalendarStandardTitleTextSize = 13.5;
CGFloat const DTCalendarStandardSubtitleTextSize = 10;
CGFloat const DTCalendarStandardWeekdayTextSize = 14;
CGFloat const DTCalendarStandardHeaderTextSize = 16.5;
CGFloat const DTCalendarMaximumEventDotDiameter = 4.8;

NSInteger const DTCalendarDefaultHourComponent = 0;
NSInteger const DTCalendarMaximumNumberOfEvents = 3;

NSString * const DTCalendarDefaultCellReuseIdentifier = @"_DTCalendarDefaultCellReuseIdentifier";
NSString * const DTCalendarBlankCellReuseIdentifier = @"_DTCalendarBlankCellReuseIdentifier";
NSString * const DTCalendarInvalidArgumentsExceptionName = @"Invalid argument exception";

CGPoint const CGPointInfinity = {
    .x =  CGFLOAT_MAX,
    .y =  CGFLOAT_MAX
};

CGSize const CGSizeAutomatic = {
    .width =  DTCalendarAutomaticDimension,
    .height =  DTCalendarAutomaticDimension
};



