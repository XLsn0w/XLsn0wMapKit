//
//  PopupController.h
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/19.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PopupControllerDelegate;
@class PopupController, PopupTheme, PopupButton;


@protocol PopupControllerDelegate <NSObject>

@optional
- (void)popupControllerWillPresent:(nonnull PopupController *) controller;
- (void)popupControllerDidPresent:(nonnull PopupController *) controller;
- (void)popupControllerWillDismiss:(nonnull PopupController *) controller;
- (void)popupControllerDidDismiss:(nonnull PopupController *) controller;

@end


typedef NS_ENUM(NSUInteger, PopupMode) {
    PopupModeFullScreen = 0, // Displays the popup similar to an action sheet from the bottom.
    PopupModeWithNavigationbar, // Displays the popup in the center of the screen.
    PopupModeWithTabbar // Displays the popup similar to a fullscreen viewcontroller.
};

@interface PopupController : NSObject

// 弹出视图
@property (nonatomic, strong) UIView *popupView;
// 背景图
@property (nonatomic, strong) UIView *maskView;
// 子视图
@property (nonatomic, strong) NSArray <UIView *> *views;
// 是否支持导航栏控制器
@property (nonatomic, assign) PopupMode  mode;
// 是否支持手势
@property (nonatomic, assign) BOOL isOpenGesture;
// 是否支持键盘
@property (nonatomic, assign) BOOL isSupperKeyboard;
// 主题风格
@property (nonatomic, strong) PopupTheme *_Nonnull theme;
// 代理方法
@property (nonatomic, weak) id <PopupControllerDelegate> _Nullable delegate;

- (nonnull instancetype) init __attribute__((unavailable("You cannot initialize through init - please use initWithContents:")));
- (nonnull instancetype)initWithContents:(nonnull NSArray<UIView *> *)contents andFrameRect:(CGRect) frame andPopupMode:(PopupMode) mode andSupperKeyboard:(BOOL) isSupper andGesture:(BOOL) isOn NS_DESIGNATED_INITIALIZER;

- (void)presentPopupControllerAnimated:(BOOL)flag;
- (void)dismissPopupControllerAnimated:(BOOL)flag;
- (void)presentPopupControllerInNavigationController:(UIViewController *) controller Animated:(BOOL)flag;
@end

typedef void(^SelectionHandler) (PopupButton *_Nonnull button);

@interface PopupButton : UIButton

@property (nonatomic, copy) SelectionHandler _Nullable selectionHandler;

@end

// PopupStyle: Controls how the popup looks once presented
typedef NS_ENUM(NSUInteger, PopupStyle) {
    PopupStyleActionSheet = 0, // Displays the popup similar to an action sheet from the bottom.
    PopupStyleCentered, // Displays the popup in the center of the screen.
    PopupStyleFullscreen // Displays the popup similar to a fullscreen viewcontroller.
};

// PopupPresentationStyle: Controls how the popup is presented
typedef NS_ENUM(NSInteger, PopupPresentationStyle) {
    PopupPresentationStyleFadeIn = 0,
    PopupPresentationStyleSlideInFromTop,
    PopupPresentationStyleSlideInFromBottom,
    PopupPresentationStyleSlideInFromLeft,
    PopupPresentationStyleSlideInFromRight
};

// CNPPopupMaskType
typedef NS_ENUM(NSInteger, PopupMaskType) {
    PopupMaskTypeClear,
    PopupMaskTypeDimmed
};

NS_ASSUME_NONNULL_BEGIN
@interface PopupTheme : NSObject

@property (nonatomic, strong) UIColor *backgroundColor; // Background color of the popup content view (Default white)
@property (nonatomic, assign) CGFloat cornerRadius; // Corner radius of the popup content view (Default 4.0)
@property (nonatomic, assign) UIEdgeInsets popupContentInsets; // Inset of labels, images and buttons on the popup content view (Default 16.0 on all sides)
@property (nonatomic, assign) PopupStyle popupStyle; // How the popup looks once presented (Default centered)
@property (nonatomic, assign) PopupPresentationStyle presentationStyle; // How the popup is presented (Defauly slide in from bottom. NOTE: Only applicable to PopupStyleCentered)
@property (nonatomic, assign) PopupMaskType maskType; // Backgound mask of the popup (Default dimmed)
@property (nonatomic, assign) BOOL dismissesOppositeDirection; // If presented from a direction, should it dismiss in the opposite? (Defaults to NO. i.e. Goes back the way it came in)
@property (nonatomic, assign) BOOL shouldDismissOnBackgroundTouch; // Popup should dismiss on tapping on background mask (Default yes)
@property (nonatomic, assign) BOOL movesAboveKeyboard; // Popup should move up when the keyboard appears (Default yes)
@property (nonatomic, assign) CGFloat contentVerticalPadding; // Spacing between each vertical element (Default 12.0)
@property (nonatomic, assign) CGFloat maxPopupWidth; // Maxiumum width that the popup should be (Default 300)
@property (nonatomic, assign) CGFloat animationDuration; // Duration of presentation animations (Default 0.3s)

+ (PopupTheme *)defaultTheme;
+ (PopupTheme *)custormTheme;
@end
NS_ASSUME_NONNULL_END


