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

    // Remove the ugly option button
    [self.utilityButton removeFromSuperview];
}
%end

%hook NCNotificationLongLookView
-(void)layoutSubviews {
    %orig;

    // Base location
    CGFloat baseLocation = self.dismissControl.frame.origin.y;
    CGRect headerRect;
    BOOL foundHeader = false;

    // Move the header to the top
    for (UIView *view in self.subviews)
    {
		if ([view isMemberOfClass:[%c(PLExpandedPlatterHeaderContentView) class]])
        {
            headerRect          = view.frame;
            headerRect.origin.y = baseLocation;
            view.frame          = headerRect;

            foundHeader = true;
            continue;
		}

        if (foundHeader)
        {
            CGRect lineRect   = view.frame;
            lineRect.origin.y = baseLocation + headerRect.size.height;
            view.frame        = lineRect;
            break;
        }
	}

    // Just in case the header is missing
    if (foundHeader)
    {
        // Move up the core
        CGFloat baseScrollLocation = baseLocation + headerRect.size.height - 2;
        CGRect scrollRect          = self.scrollView.frame;
        //scrollRect.size.height    += scrollRect.origin.y - baseScrollLocation;
        scrollRect.origin.y        = baseScrollLocation;
        self.scrollView.frame      = scrollRect;

        // Move down the close cross a bit
        CGRect closeRect = self.dismissControl.frame;
        closeRect.origin.y += (headerRect.size.height - closeRect.size.height) / 2;
        self.dismissControl.frame = closeRect;
    }
}
%end
