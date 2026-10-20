

#import "DTCalendar.h"
#import "DTCalendarExtensions.h"
#import "DTCalendarHeaderView.h"
#import "DTCalendarCollectionView.h"
#import "DTCalendarDynamicHeader.h"


@interface DTCalendarHeaderView ()<UICollectionViewDataSource,UICollectionViewDelegate,DTCalendarCollectionViewInternalDelegate>

- (void)scrollToOffset:(CGFloat)scrollOffset animated:(BOOL)animated;
- (void)configureCell:(DTCalendarHeaderCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end

@implementation DTCalendarHeaderView

#pragma mark - Life cycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

-  (BOOL) isRTLMode{
    NSString *languageType = [[NSUserDefaults standardUserDefaults] objectForKey:@"LANG_IS_RTL"];
  
    if (languageType != nil){
        if([languageType.uppercaseString isEqualToString:@"RTL"]){
            return YES;
        }
    }
    return NO;
}

- (void)initialize
{
    _scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _scrollEnabled = YES;
    
    DTCalendarHeaderLayout *collectionViewLayout = [[DTCalendarHeaderLayout alloc] init];
    self.collectionViewLayout = collectionViewLayout;
    
    DTCalendarCollectionView *collectionView = [[DTCalendarCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:collectionViewLayout];
    collectionView.scrollEnabled = NO;
    collectionView.userInteractionEnabled = NO;
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    
    if(self.isRTLMode == TRUE){
        collectionView.transform = CGAffineTransformMakeScale( -1.0, 1.0);
    }
    
    
    [self addSubview:collectionView];
    [collectionView registerClass:[DTCalendarHeaderCell class] forCellWithReuseIdentifier:@"cell"];
    self.collectionView = collectionView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.collectionView.frame = CGRectMake(0, self.fs_height*0.1, self.fs_width, self.fs_height*0.9);
}

- (void)dealloc
{
    self.collectionView.dataSource = nil;
    self.collectionView.delegate = nil;
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger numberOfSections = self.calendar.collectionView.numberOfSections;
    if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
        return numberOfSections;
    }
    return numberOfSections + 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DTCalendarHeaderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.header = self;
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_collectionView.visibleCells makeObjectsPerformSelector:@selector(setNeedsLayout)];
}

#pragma mark - Properties

- (void)setCalendar:(DTCalendar *)calendar
{
    _calendar = calendar;
    [self configureAppearance];
}

- (void)setScrollOffset:(CGFloat)scrollOffset
{
    [self setScrollOffset:scrollOffset animated:NO];
}

- (void)setScrollOffset:(CGFloat)scrollOffset animated:(BOOL)animated
{
    [self scrollToOffset:scrollOffset animated:NO];
}

- (void)scrollToOffset:(CGFloat)scrollOffset animated:(BOOL)animated
{
    if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        CGFloat step = self.collectionView.fs_width*((self.scrollDirection==UICollectionViewScrollDirectionHorizontal)?0.5:1);
        [_collectionView setContentOffset:CGPointMake((scrollOffset+0.5)*step, 0) animated:animated];
    } else {
        CGFloat step = self.collectionView.fs_height;
        [_collectionView setContentOffset:CGPointMake(0, scrollOffset*step) animated:animated];
    }
}

- (void)setScrollDirection:(UICollectionViewScrollDirection)scrollDirection
{
    if (_scrollDirection != scrollDirection) {
        _scrollDirection = scrollDirection;
        _collectionViewLayout.scrollDirection = scrollDirection;
        [self setNeedsLayout];
    }
}

- (void)setScrollEnabled:(BOOL)scrollEnabled
{
    if (_scrollEnabled != scrollEnabled) {
        _scrollEnabled = scrollEnabled;
        [_collectionView.visibleCells makeObjectsPerformSelector:@selector(setNeedsLayout)];
    }
}

#pragma mark - Public

- (void)reloadData
{
    [_collectionView reloadData];
}

- (void)configureCell:(DTCalendarHeaderCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    DTCalendarAppearance *appearance = self.calendar.appearance;
    cell.titleLabel.font = appearance.headerTitleFont;
    cell.titleLabel.textColor = appearance.headerTitleColor;
    cell.titleLabel.textAlignment = appearance.headerTitleAlignment; 
    _calendar.formatter.dateFormat = appearance.headerDateFormat;
    NSString *text = nil;
    switch (self.calendar.transitionCoordinator.representingScope) {
        case DTCalendarScopeMonth: {
            if (_scrollDirection == UICollectionViewScrollDirectionHorizontal) {
               
                if ((indexPath.item == 0 || indexPath.item == [self.collectionView numberOfItemsInSection:0] - 1)) {
                    text = nil;
                } else {
                    
                    NSLog(@"Your minimumDate is %@", self.calendar.minimumDate);
                    NSLog(@"Your maximumDate is %@", self.calendar.maximumDate);
//                    NSLog(@"Your gregorian is %@", self.calendar.gregorian.);
                    NSDate *date = [self.calendar.gregorian dateByAddingUnit:NSCalendarUnitMonth value:indexPath.item-1 toDate: self.calendar.minimumDate options:0];
                    text = [_calendar.formatter stringFromDate:date];
                }
            } else {
                NSDate *date = [self.calendar.gregorian dateByAddingUnit:NSCalendarUnitMonth value:indexPath.item toDate:self.calendar.minimumDate options:0];
                text = [_calendar.formatter stringFromDate:date];
            }
            break;
        }
        case DTCalendarScopeWeek: {
            if ((indexPath.item == 0 || indexPath.item == [self.collectionView numberOfItemsInSection:0] - 1)) {
                text = nil;
            } else {
                NSDate *firstPage = [self.calendar.gregorian fs_middleDayOfWeek:self.calendar.minimumDate];
                NSDate *date = [self.calendar.gregorian dateByAddingUnit:NSCalendarUnitWeekOfYear value:indexPath.item-1 toDate:firstPage options:0];
                text = [_calendar.formatter stringFromDate:date];
            }
            break;
        }
        default: {
            break;
        }
    }
    BOOL usesUpperCase   = (appearance.caseOptions & 15) == DTCalendarCaseOptionsHeaderUsesUpperCase;
    BOOL usesCapitalized = (appearance.caseOptions & 15) == DTCalendarCaseOptionsHeaderUsesCapitalized;
    if (usesUpperCase) {
        text = text.uppercaseString;
    } else if (usesCapitalized) {
        text = text.capitalizedString;
    }
    cell.titleLabel.text = text;
    [cell setNeedsLayout];
}

- (void)configureAppearance
{
    [self.collectionView.visibleCells enumerateObjectsUsingBlock:^(__kindof DTCalendarHeaderCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        [self configureCell:cell atIndexPath:[self.collectionView indexPathForCell:cell]];
    }];
}

@end


@implementation DTCalendarHeaderCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        titleLabel.numberOfLines = 0;
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
    }
    return self;
}

- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    self.titleLabel.frame = bounds;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    CGPoint titleHeaderOffset = self.header.calendar.appearance.headerTitleOffset;
    self.titleLabel.frame = CGRectOffset(self.contentView.bounds,
                                         titleHeaderOffset.x,
                                         titleHeaderOffset.y);
    
    if (self.header.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        CGFloat position = [self.contentView convertPoint:CGPointMake(CGRectGetMidX(self.contentView.bounds), CGRectGetMidY(self.contentView.bounds)) toView:self.header].x;
        CGFloat center = CGRectGetMidX(self.header.bounds);
        if (self.header.scrollEnabled) {
            self.contentView.alpha = 1.0 - (1.0-self.header.calendar.appearance.headerMinimumDissolvedAlpha)*ABS(center-position)/self.fs_width;
        } else {
            self.contentView.alpha = (position > self.header.fs_width*0.25 && position < self.header.fs_width*0.75);
        }
    } else if (self.header.scrollDirection == UICollectionViewScrollDirectionVertical) {
        CGFloat position = [self.contentView convertPoint:CGPointMake(CGRectGetMidX(self.contentView.bounds), CGRectGetMidY(self.contentView.bounds)) toView:self.header].y;
        CGFloat center = CGRectGetMidY(self.header.bounds);
        self.contentView.alpha = 1.0 - (1.0-self.header.calendar.appearance.headerMinimumDissolvedAlpha)*ABS(center-position)/self.fs_height;
    }
}

@end


@implementation DTCalendarHeaderLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.minimumInteritemSpacing = 0;
        self.minimumLineSpacing = 0;
        self.sectionInset = UIEdgeInsetsZero;
        self.itemSize = CGSizeMake(1, 1);
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(didReceiveOrientationChangeNotification:) name:UIDeviceOrientationDidChangeNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [NSNotificationCenter.defaultCenter removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)prepareLayout
{
    [super prepareLayout];
    
    self.itemSize = CGSizeMake(
                               self.collectionView.fs_width*((self.scrollDirection==UICollectionViewScrollDirectionHorizontal)?0.5:1),
                               self.collectionView.fs_height
                              );
    
}

- (void)didReceiveOrientationChangeNotification:(NSNotification *)notificatino
{
    [self invalidateLayout];
}

-  (BOOL) isRTLMode{
    NSString *languageType = [[NSUserDefaults standardUserDefaults] objectForKey:@"LANG_IS_RTL"];
  
    if (languageType != nil){
        if([languageType.uppercaseString isEqualToString:@"RTL"]){
            return YES;
        }
    }
    return NO;
}

- (BOOL)flipsHorizontallyInOppositeLayoutDirection
{
    if(self.isRTLMode == TRUE){
        return TRUE;
    }else{
        return FALSE;
    }
    
}

@end

@implementation DTCalendarHeaderTouchDeliver

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *hitView = [super hitTest:point withEvent:event];
    if (hitView == self) {
        return _calendar.collectionView ?: hitView;
    }
    return hitView;
}

@end


