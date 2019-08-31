#import "Tweak.h"

%hook NCNotificationListCellActionButtonsView
-(void)layoutSubviews {
    %orig;

    // Get the options StackView array
    NSArray<NCNotificationListCellActionButton*> *buttonsArray = self.buttonsStackView.arrangedSubviews;

    // Process only if 3 CellActionButton are present
    // Less than 3 means the left option pannel is opened or the right one is already processed
    if (buttonsArray.count == 3)
    {
        // Remove the Manage option
        [buttonsArray[0] removeFromSuperview];
    }
}
%end

%hook PLPlatterHeaderContentView
-(void)layoutSubviews {
    %orig;

    // Check if we are on a notification (https://stackoverflow.com/a/2309978)
    BOOL isNotification = false;
    for (UIView *next = [self superview]; next; next = next.superview)
    {
        if ([next isKindOfClass:[%c(NCNotificationLongLookView) class]])
        {
            isNotification = true;
            break;
        }
    }

    if (isNotification)
    {
        // Remove the ugly option button
        [self.utilityButton removeFromSuperview];
    }
}
%end
