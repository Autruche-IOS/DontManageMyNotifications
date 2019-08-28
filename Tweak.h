// No manage button on notification swipe
@interface NCNotificationListCellActionButtonsView : UIView
@property (nonatomic,retain) UIStackView * buttonsStackView;
@end

@interface NCNotificationListCellActionButton : UIControl
@end

// No option on top of the quick reply box
@interface PLPlatterHeaderContentView : UIView
@property (nonatomic,readonly) UIButton * utilityButton;
@end
