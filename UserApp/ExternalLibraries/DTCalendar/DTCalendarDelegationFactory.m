

#import "DTCalendarDelegationFactory.h"

@implementation DTCalendarDelegationFactory

+ (DTCalendarDelegationProxy *)dataSourceProxy
{
    DTCalendarDelegationProxy *delegation = [[DTCalendarDelegationProxy alloc] init];
    delegation.protocol = @protocol(DTCalendarDataSource);
    return delegation;
}

+ (DTCalendarDelegationProxy *)delegateProxy
{
    DTCalendarDelegationProxy *delegation = [[DTCalendarDelegationProxy alloc] init];
    delegation.protocol = @protocol(DTCalendarDelegateAppearance);
    return delegation;
}

@end

#undef DTCalendarSelectorEntry

