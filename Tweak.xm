// No manage button on notification swipe
@interface NCNotificationListCellActionButtonsView : UIView
@property (nonatomic,retain) UIStackView * buttonsStackView;
@end

@interface NCNotificationListCellActionButton : UIControl
@end

// No option on top of the quick reply box
@interface PLPlatterHeaderContentView : UIView
@end

@interface PLExpandedPlatterHeaderContentView : PLPlatterHeaderContentView
@end

// Moving down the close arrow on the quick reply box
@interface PLExpandedPlatterView : UIView
@end

@interface NCNotificationLongLookView : PLExpandedPlatterView
@property (nonatomic,readonly) UIControl * dismissControl;
@end


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

%hook PLExpandedPlatterHeaderContentView
-(void)_configureUtilityButton {
    // Do nothing, in order not to generate that ugly manage buttun
}
%end

%hook NCNotificationLongLookView
-(void)layoutSubviews {
    %orig;

    // Move down the close cross
    CGRect rect = self.dismissControl.frame;
    rect.origin.y += 52;
    self.dismissControl.frame = rect;
}
%end
