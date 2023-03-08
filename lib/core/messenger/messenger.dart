import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:injectable/injectable.dart';
import 'package:simpletodoapp/core/theme/app_colors.dart';

import '../di/service_locator.dart';
import '../theme/text_style.dart';
import 'snackbar.dart';

abstract class Messenger {
  void showSnackBar({
    required String message,
    SnackbarState state,
    Widget? snackbar,
    IconData? leadingIcon,
    Widget? leading,
    Widget? trailing,
    String? actionText,
    double bottomPadding,
    void Function()? actionCallback,
  });

  void showPersistentSnackBar({
    required String message,
    required BuildContext context,
    Duration duration = const Duration(seconds: 4),
    Widget? snackbar,
    IconData? leadingIcon,
    Widget? leading,
    Widget? trailing,
    String? actionText,
    double bottomPadding = 0,
    SnackbarState state = SnackbarState.neutral,
    void Function()? actionCallback,
  });
}

@LazySingleton()
class MessengerService implements Messenger {
  /* Create GlobalKey to be used in navigation */
  final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void showSnackBar({
    required String message,
    Widget? snackbar,
    IconData? leadingIcon,
    Widget? leading,
    Widget? trailing,
    String? actionText,
    double bottomPadding = 0,
    SnackbarState state = SnackbarState.neutral,
    void Function()? actionCallback,
  }) {
    if (rootScaffoldMessengerKey.currentState != null) {
      rootScaffoldMessengerKey.currentState
        ?..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
            content: snackbar ??
                PropertekSnackBar(
                  message: message,
                  state: state,
                  bottomPadding: bottomPadding,
                  leadingIcon: leadingIcon,
                  leading: leading,
                  trailing: trailing,
                  actionText: actionText,
                  actionCallback: actionCallback,
                ),
          ),
        );
    }
  }

  @override
  void showPersistentSnackBar({
    required String message,
    required BuildContext context,
    Duration duration = const Duration(seconds: 4),
    Widget? snackbar,
    IconData? leadingIcon,
    Widget? leading,
    Widget? trailing,
    String? actionText,
    double bottomPadding = 0,
    SnackbarState state = SnackbarState.neutral,
    void Function()? actionCallback,
  }) {
    /* UI Vars */
    var _bgColor = AppColors.grey[0];
    var _borderColor = AppColors.grey[0];
    Color _textColor = AppColors.grey;

    switch (state) {
      case SnackbarState.success:
        _bgColor = AppColors.success;
        _textColor = AppColors.grey[0]!;
        _borderColor = Colors.transparent;
        break;
      case SnackbarState.error:
        _bgColor = AppColors.error;
        _textColor = AppColors.grey[0]!;
        _borderColor = Colors.transparent;
        break;
      case SnackbarState.warning:
        _bgColor = AppColors.warning;
        _textColor = AppColors.grey[0]!;
        _borderColor = Colors.transparent;
        break;
      case SnackbarState.neutral:
        _bgColor = AppColors.primary;
        _textColor = AppColors.grey[0]!;
        _borderColor = Colors.transparent;
        break;
    }
    // ScaffoldMessenger.of(context).hideCurrentSnackBar();
    showFlash(
      context: context,
      duration: duration,
      builder: (context, controller) {
        // if (controller.persistent) {
        //   controller.dismiss();
        // }

        // print();
        return Flash(
          controller: controller,
          borderRadius: BorderRadius.circular(8.r),
          margin: EdgeInsets.all(20.w).copyWith(bottom: bottomPadding),
          horizontalDismissDirection: HorizontalDismissDirection.horizontal,
          behavior: FlashBehavior.floating,
          position: FlashPosition.bottom,
          enableVerticalDrag: false,
          borderColor: _borderColor,
          backgroundColor: _bgColor,
          borderWidth: 1.w,
          child: FlashBar(
            padding: EdgeInsets.all(12.w),
            shouldIconPulse: false,
            icon: leading ??
                (leadingIcon == null
                    ? null
                    : Icon(
                        leadingIcon,
                        color: _textColor,
                        size: 20.sp,
                      )),
            primaryAction: actionCallback == null
                ? null
                : Padding(
                    padding: EdgeInsets.only(right: 12.w),
                    child: GestureDetector(
                      onTap: () {
                        controller.dismiss();
                        actionCallback();
                      },
                      child: Text(actionText ?? 'Retry',
                          style: AppTextStyle.detailMedium16()),
                    ),
                  ),
            content: Text(
              message,
              textAlign: TextAlign.left,
              style: AppTextStyle.bodyRegular14(_textColor),
            ),
          ),
        );
      },
    );
  }
}

class PropertekSnackBar extends StatelessWidget {
  PropertekSnackBar({
    required this.message,
    required this.state,
    required this.leadingIcon,
    required this.leading,
    required this.trailing,
    required this.actionText,
    required this.actionCallback,
    this.bottomPadding = 0,
    Key? key,
  }) : super(key: key);

  final SnackbarState state;

  final String message;
  final double bottomPadding;

  final IconData? leadingIcon;
  final Widget? leading;

  final Widget? trailing;
  final String? actionText;
  final void Function()? actionCallback;

  final ValueNotifier<bool> _isClicked = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    var _bgColor = AppColors.grey[0];
    var _borderColor = AppColors.grey[0];
    Color _textColor = AppColors.grey;

    switch (state) {
      case SnackbarState.success:
        _bgColor = AppColors.success;
        _textColor = AppColors.grey[0]!;
        _borderColor = Colors.transparent;
        break;
      case SnackbarState.error:
        _bgColor = AppColors.error;
        _textColor = AppColors.grey[0]!;
        _borderColor = Colors.transparent;
        break;
      case SnackbarState.warning:
        _bgColor = AppColors.warning;
        _textColor = AppColors.grey[0]!;
        _borderColor = Colors.transparent;
        break;
      case SnackbarState.neutral:
        _bgColor = AppColors.primary;
        _textColor = AppColors.grey[0]!;
        _borderColor = Colors.transparent;
        break;
    }

    return Container(
      width: 1.sw,
      padding: EdgeInsets.all(12.w),
      margin: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        bottom: bottomPadding,
      ),
      decoration: BoxDecoration(
        color: _bgColor,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: _borderColor, width: 1.sp),
      ),
      child: Row(
        children: [
          /* Custom Leading */
          if (leading != null)
            Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: leading,
            ),

          /* Icon Leading */
          if (leadingIcon != null)
            Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: Icon(
                leadingIcon!,
                color: _textColor,
                size: 20.sp,
              ),
            ),

          /* Text */
          Expanded(
            child: Text(
              message,
              textAlign: TextAlign.left,
              style: AppTextStyle.headingBold16(_textColor),
            ),
          ),

          /* Custom Trailing */
          if (trailing != null) trailing!,

          /* Action Trailing  */
          if (actionCallback != null)
            Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: GestureDetector(
                onTap: () {
                  if (!_isClicked.value) {
                    /* Prevent button debounce */
                    _isClicked.value = true;

                    /* Trigger the callback */
                    actionCallback!();

                    /* Hide SnackBar */
                    getIt<MessengerService>()
                        .rootScaffoldMessengerKey
                        .currentState
                        ?.hideCurrentSnackBar();
                  } else {}
                },
                child: Text(
                  actionText ?? 'Retry',
                  style: AppTextStyle.headingBold16(_textColor),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
