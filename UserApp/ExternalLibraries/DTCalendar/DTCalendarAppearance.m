

#import "DTCalendarAppearance.h"
#import "DTCalendarDynamicHeader.h"
#import "DTCalendarExtensions.h"

@interface DTCalendarAppearance ()

@property (weak  , nonatomic) DTCalendar *calendar;

@property (strong, nonatomic) NSMutableDictionary *backgroundColors;
@property (strong, nonatomic) NSMutableDictionary *titleColors;
@property (strong, nonatomic) NSMutableDictionary *subtitleColors;
@property (strong, nonatomic) NSMutableDictionary *borderColors;

@end

@implementation DTCalendarAppearance

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _titleFont = [UIFont systemFontOfSize:DTCalendarStandardTitleTextSize];
        _subtitleFont = [UIFont systemFontOfSize:DTCalendarStandardSubtitleTextSize];
        _weekdayFont = [UIFont systemFontOfSize:DTCalendarStandardWeekdayTextSize];
        _headerTitleFont = [UIFont systemFontOfSize:DTCalendarStandardHeaderTextSize];
        
        _headerTitleColor = DTCalendarStandardTitleTextColor;
        _headerSeparatorColor = DTCalendarStandardLineColor;
        _headerDateFormat = @"MMMM yyyy";
        _headerMinimumDissolvedAlpha = 0.2;
        _headerTitleOffset = CGPointZero;
        _headerTitleAlignment = NSTextAlignmentCenter;
        _weekdayTextColor = DTCalendarStandardTitleTextColor;
        _caseOptions = DTCalendarCaseOptionsHeaderUsesDefaultCase|DTCalendarCaseOptionsWeekdayUsesDefaultCase;
        
        _backgroundColors = [NSMutableDictionary dictionaryWithCapacity:5];
        _backgroundColors[@(DTCalendarCellStateNormal)]      = [UIColor clearColor];
        _backgroundColors[@(DTCalendarCellStateSelected)]    = DTCalendarStandardSelectionColor;
        _backgroundColors[@(DTCalendarCellStateDisabled)]    = [UIColor clearColor];
        _backgroundColors[@(DTCalendarCellStatePlaceholder)] = [UIColor clearColor];
        _backgroundColors[@(DTCalendarCellStateToday)]       = DTCalendarStandardTodayColor;
        
        _titleColors = [NSMutableDictionary dictionaryWithCapacity:5];
        _titleColors[@(DTCalendarCellStateNormal)]      = [UIColor blackColor];
        _titleColors[@(DTCalendarCellStateSelected)]    = [UIColor whiteColor];
        _titleColors[@(DTCalendarCellStateDisabled)]    = [UIColor grayColor];
        _titleColors[@(DTCalendarCellStatePlaceholder)] = [UIColor lightGrayColor];
        _titleColors[@(DTCalendarCellStateToday)]       = [UIColor whiteColor];
        
        _subtitleColors = [NSMutableDictionary dictionaryWithCapacity:5];
        _subtitleColors[@(DTCalendarCellStateNormal)]      = [UIColor darkGrayColor];
        _subtitleColors[@(DTCalendarCellStateSelected)]    = [UIColor whiteColor];
        _subtitleColors[@(DTCalendarCellStateDisabled)]    = [UIColor lightGrayColor];
        _subtitleColors[@(DTCalendarCellStatePlaceholder)] = [UIColor lightGrayColor];
        _subtitleColors[@(DTCalendarCellStateToday)]       = [UIColor whiteColor];
        
        _borderColors[@(DTCalendarCellStateSelected)] = [UIColor clearColor];
        _borderColors[@(DTCalendarCellStateNormal)] = [UIColor clearColor];
        
        _borderRadius = 1.0;
        _eventDefaultColor = DTCalendarStandardEventDotColor;
        _eventSelectionColor = DTCalendarStandardEventDotColor;
        
        _borderColors = [NSMutableDictionary dictionaryWithCapacity:2];
        
#if TARGET_INTERFACE_BUILDER
        _fakeEventDots = YES;
#endif
        
    }
    return self;
}

- (void)setTitleFont:(UIFont *)titleFont
{
    if (![_titleFont isEqual:titleFont]) {
        _titleFont = titleFont;
        [self.calendar configureAppearance];
    }
}

- (void)setSubtitleFont:(UIFont *)subtitleFont
{
    if (![_subtitleFont isEqual:subtitleFont]) {
        _subtitleFont = subtitleFont;
        [self.calendar configureAppearance];
    }
}

- (void)setWeekdayFont:(UIFont *)weekdayFont
{
    if (![_weekdayFont isEqual:weekdayFont]) {
        _weekdayFont = weekdayFont;
        [self.calendar configureAppearance];
    }
}

- (void)setHeaderTitleFont:(UIFont *)headerTitleFont
{
    if (![_headerTitleFont isEqual:headerTitleFont]) {
        _headerTitleFont = headerTitleFont;
        [self.calendar configureAppearance];
    }
}

- (void)setHeaderTitleOffset:(CGPoint)headerTitleOffset {
    if (!CGPointEqualToPoint(_headerTitleOffset, headerTitleOffset)) {
        _headerTitleOffset = headerTitleOffset;
        [self.calendar configureAppearance];
    }
}

- (void)setTitleOffset:(CGPoint)titleOffset
{
    if (!CGPointEqualToPoint(_titleOffset, titleOffset)) {
        _titleOffset = titleOffset;
        [_calendar.visibleCells makeObjectsPerformSelector:@selector(setNeedsLayout)];
    }
}

- (void)setSubtitleOffset:(CGPoint)subtitleOffset
{
    if (!CGPointEqualToPoint(_subtitleOffset, subtitleOffset)) {
        _subtitleOffset = subtitleOffset;
        [_calendar.visibleCells makeObjectsPerformSelector:@selector(setNeedsLayout)];
    }
}

- (void)setImageOffset:(CGPoint)imageOffset
{
    if (!CGPointEqualToPoint(_imageOffset, imageOffset)) {
        _imageOffset = imageOffset;
        [_calendar.visibleCells makeObjectsPerformSelector:@selector(setNeedsLayout)];
    }
}

- (void)setEventOffset:(CGPoint)eventOffset
{
    if (!CGPointEqualToPoint(_eventOffset, eventOffset)) {
        _eventOffset = eventOffset;
        [_calendar.visibleCells makeObjectsPerformSelector:@selector(setNeedsLayout)];
    }
}

- (void)setTitleDefaultColor:(UIColor *)color
{
    if (color) {
        _titleColors[@(DTCalendarCellStateNormal)] = color;
    } else {
        [_titleColors removeObjectForKey:@(DTCalendarCellStateNormal)];
    }
    [self.calendar configureAppearance];
}

- (UIColor *)titleDefaultColor
{
    return _titleColors[@(DTCalendarCellStateNormal)];
}

- (void)setTitleSelectionColor:(UIColor *)color
{
    if (color) {
        _titleColors[@(DTCalendarCellStateSelected)] = color;
    } else {
        [_titleColors removeObjectForKey:@(DTCalendarCellStateSelected)];
    }
    [self.calendar configureAppearance];
}

- (UIColor *)titleSelectionColor
{
    return _titleColors[@(DTCalendarCellStateSelected)];
}

- (void)setTitleTodayColor:(UIColor *)color
{
    if (color) {
        _titleColors[@(DTCalendarCellStateToday)] = color;
    } else {
        [_titleColors removeObjectForKey:@(DTCalendarCellStateToday)];
    }
    [self.calendar configureAppearance];
}

- (UIColor *)titleTodayColor
{
    return _titleColors[@(DTCalendarCellStateToday)];
}

- (void)setTitlePlaceholderColor:(UIColor *)color
{
    if (color) {
        _titleColors[@(DTCalendarCellStatePlaceholder)] = color;
    } else {
        [_titleColors removeObjectForKey:@(DTCalendarCellStatePlaceholder)];
    }
    [self.calendar configureAppearance];
}

- (UIColor *)titlePlaceholderColor
{
    return _titleColors[@(DTCalendarCellStatePlaceholder)];
}

- (void)setTitleWeekendColor:(UIColor *)color
{
    if (color) {
        _titleColors[@(DTCalendarCellStateWeekend)] = color;
    } else {
        [_titleColors removeObjectForKey:@(DTCalendarCellStateWeekend)];
    }
    [self.calendar configureAppearance];
}

- (UIColor *)titleWeekendColor
{
    return _titleColors[@(DTCalendarCellStateWeekend)];
}

- (void)setSubtitleDefaultColor:(UIColor *)color
{
    if (color) {
        _subtitleColors[@(DTCalendarCellStateNormal)] = color;
    } else {
        [_subtitleColors removeObjectForKey:@(DTCalendarCellStateNormal)];
    }
    [self.calendar configureAppearance];
}

-(UIColor *)subtitleDefaultColor
{
    return _subtitleColors[@(DTCalendarCellStateNormal)];
}

- (void)setSubtitleSelectionColor:(UIColor *)color
{
    if (color) {
        _subtitleColors[@(DTCalendarCellStateSelected)] = color;
    } else {
        [_subtitleColors removeObjectForKey:@(DTCalendarCellStateSelected)];
    }
    [self.calendar configureAppearance];
}

- (UIColor *)subtitleSelectionColor
{
    return _subtitleColors[@(DTCalendarCellStateSelected)];
}

- (void)setSubtitleTodayColor:(UIColor *)color
{
    if (color) {
        _subtitleColors[@(DTCalendarCellStateToday)] = color;
    } else {
        [_subtitleColors removeObjectForKey:@(DTCalendarCellStateToday)];
    }
    [self.calendar configureAppearance];
}

- (UIColor *)subtitleTodayColor
{
    return _subtitleColors[@(DTCalendarCellStateToday)];
}

- (void)setSubtitlePlaceholderColor:(UIColor *)color
{
    if (color) {
        _subtitleColors[@(DTCalendarCellStatePlaceholder)] = color;
    } else {
        [_subtitleColors removeObjectForKey:@(DTCalendarCellStatePlaceholder)];
    }
    [self.calendar configureAppearance];
}

- (UIColor *)subtitlePlaceholderColor
{
    return _subtitleColors[@(DTCalendarCellStatePlaceholder)];
}

- (void)setSubtitleWeekendColor:(UIColor *)color
{
    if (color) {
        _subtitleColors[@(DTCalendarCellStateWeekend)] = color;
    } else {
        [_subtitleColors removeObjectForKey:@(DTCalendarCellStateWeekend)];
    }
    [self.calendar configureAppearance];
}

- (UIColor *)subtitleWeekendColor
{
    return _subtitleColors[@(DTCalendarCellStateWeekend)];
}

- (void)setSelectionColor:(UIColor *)color
{
    if (color) {
        _backgroundColors[@(DTCalendarCellStateSelected)] = color;
    } else {
        [_backgroundColors removeObjectForKey:@(DTCalendarCellStateSelected)];
    }
    [self.calendar configureAppearance];
}

- (UIColor *)selectionColor
{
    return _backgroundColors[@(DTCalendarCellStateSelected)];
}

- (void)setTodayColor:(UIColor *)todayColor
{
    if (todayColor) {
        _backgroundColors[@(DTCalendarCellStateToday)] = todayColor;
    } else {
        [_backgroundColors removeObjectForKey:@(DTCalendarCellStateToday)];
    }
    [self.calendar configureAppearance];
}

- (UIColor *)todayColor
{
    return _backgroundColors[@(DTCalendarCellStateToday)];
}

- (void)setTodaySelectionColor:(UIColor *)todaySelectionColor
{
    if (todaySelectionColor) {
        _backgroundColors[@(DTCalendarCellStateToday|DTCalendarCellStateSelected)] = todaySelectionColor;
    } else {
        [_backgroundColors removeObjectForKey:@(DTCalendarCellStateToday|DTCalendarCellStateSelected)];
    }
    [self.calendar configureAppearance];
}

- (UIColor *)todaySelectionColor
{
    return _backgroundColors[@(DTCalendarCellStateToday|DTCalendarCellStateSelected)];
}

- (void)setEventDefaultColor:(UIColor *)eventDefaultColor
{
    if (![_eventDefaultColor isEqual:eventDefaultColor]) {
        _eventDefaultColor = eventDefaultColor;
        [self.calendar configureAppearance];
    }
}

- (void)setBorderDefaultColor:(UIColor *)color
{
    if (color) {
        _borderColors[@(DTCalendarCellStateNormal)] = color;
    } else {
        [_borderColors removeObjectForKey:@(DTCalendarCellStateNormal)];
    }
    [self.calendar configureAppearance];
}

- (UIColor *)borderDefaultColor
{
    return _borderColors[@(DTCalendarCellStateNormal)];
}

- (void)setBorderSelectionColor:(UIColor *)color
{
    if (color) {
        _borderColors[@(DTCalendarCellStateSelected)] = color;
    } else {
        [_borderColors removeObjectForKey:@(DTCalendarCellStateSelected)];
    }
    [self.calendar configureAppearance];
}

- (UIColor *)borderSelectionColor
{
    return _borderColors[@(DTCalendarCellStateSelected)];
}

- (void)setBorderRadius:(CGFloat)borderRadius
{
    borderRadius = MAX(0.0, borderRadius);
    borderRadius = MIN(1.0, borderRadius);
    if (_borderRadius != borderRadius) {
        _borderRadius = borderRadius;
        [self.calendar configureAppearance];
    }
}

- (void)setWeekdayTextColor:(UIColor *)weekdayTextColor
{
    if (![_weekdayTextColor isEqual:weekdayTextColor]) {
        _weekdayTextColor = weekdayTextColor;
        [self.calendar configureAppearance];
    }
}

- (void)setHeaderTitleColor:(UIColor *)color
{
    if (![_headerTitleColor isEqual:color]) {
        _headerTitleColor = color;
        [self.calendar configureAppearance];
    }
}

- (void)setHeaderSeparatorColor:(UIColor *)headerSeparatorColor
{
    if (![_headerSeparatorColor isEqual:headerSeparatorColor]) {
        _headerSeparatorColor = headerSeparatorColor;
        [self.calendar configureAppearance];
    }
}

- (void)setHeaderMinimumDissolvedAlpha:(CGFloat)headerMinimumDissolvedAlpha
{
    if (_headerMinimumDissolvedAlpha != headerMinimumDissolvedAlpha) {
        _headerMinimumDissolvedAlpha = headerMinimumDissolvedAlpha;
        [self.calendar configureAppearance];
    }
}

- (void)setHeaderDateFormat:(NSString *)headerDateFormat
{
    if (![_headerDateFormat isEqual:headerDateFormat]) {
        _headerDateFormat = headerDateFormat;
        [self.calendar configureAppearance];
    }
}

- (void)setHeaderTitleAlignment:(NSTextAlignment)headerTitleAlignment
{
    if (_headerTitleAlignment != headerTitleAlignment) {
        _headerTitleAlignment = headerTitleAlignment;
        [self.calendar configureAppearance];
    }
}

- (void)setCaseOptions:(DTCalendarCaseOptions)caseOptions
{
    if (_caseOptions != caseOptions) {
        _caseOptions = caseOptions;
        [self.calendar configureAppearance];
    }
}

- (void)setSeparators:(DTCalendarSeparators)separators
{
    if (_separators != separators) {
        _separators = separators;
        [_calendar.collectionView.collectionViewLayout invalidateLayout];
    }
}

@end


@implementation DTCalendarAppearance (Deprecated)

- (void)setUseVeryShortWeekdaySymbols:(BOOL)useVeryShortWeekdaySymbols
{
    _caseOptions &= 15;
    self.caseOptions |= (useVeryShortWeekdaySymbols*DTCalendarCaseOptionsWeekdayUsesSingleUpperCase);
}

- (BOOL)useVeryShortWeekdaySymbols
{
    return (_caseOptions & (15<<4) ) == DTCalendarCaseOptionsWeekdayUsesSingleUpperCase;
}

- (void)setTitleVerticalOffset:(CGFloat)titleVerticalOffset
{
    self.titleOffset = CGPointMake(0, titleVerticalOffset);
}

- (CGFloat)titleVerticalOffset
{
    return self.titleOffset.y;
}

- (void)setSubtitleVerticalOffset:(CGFloat)subtitleVerticalOffset
{
    self.subtitleOffset = CGPointMake(0, subtitleVerticalOffset);
}

- (CGFloat)subtitleVerticalOffset
{
    return self.subtitleOffset.y;
}

- (void)setEventColor:(UIColor *)eventColor
{
    self.eventDefaultColor = eventColor;
}

- (UIColor *)eventColor
{
    return self.eventDefaultColor;
}

- (void)setTitleTextSize:(CGFloat)titleTextSize
{
    self.titleFont = [self.titleFont fontWithSize:titleTextSize];
}

- (void)setSubtitleTextSize:(CGFloat)subtitleTextSize
{
    self.subtitleFont = [self.subtitleFont fontWithSize:subtitleTextSize];
}

- (void)setWeekdayTextSize:(CGFloat)weekdayTextSize
{
    self.weekdayFont = [self.weekdayFont fontWithSize:weekdayTextSize];
}

- (void)setHeaderTitleTextSize:(CGFloat)headerTitleTextSize
{
    self.headerTitleFont = [self.headerTitleFont fontWithSize:headerTitleTextSize];
}

- (void)invalidateAppearance
{
    [self.calendar configureAppearance];
}

@end

