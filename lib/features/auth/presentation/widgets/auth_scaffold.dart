import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';

class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    required this.children,
    super.key,
    this.appBar,
    this.bottom,
    this.backgroundColor,
  });

  final PreferredSizeWidget? appBar;
  final List<Widget> children;
  final Widget? bottom;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    final isKeyboardVisible = bottomInset > 0;

    return Scaffold(
      appBar: appBar,
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.fromLTRB(
            AppSpacing.screenPadding,
            AppSpacing.screenPadding,
            AppSpacing.screenPadding,
            AppSpacing.screenPadding + (bottomInset > 0 ? AppSpacing.xl : 0),
          ),
          children: children,
        ),
      ),
      bottomNavigationBar: bottom == null
          ? null
          : AnimatedSwitcher(
              duration: const Duration(milliseconds: 180),
              child: isKeyboardVisible
                  ? const SizedBox.shrink()
                  : ColoredBox(
                      color: backgroundColor ?? AppColors.background,
                      child: SafeArea(
                        minimum: const EdgeInsets.all(AppSpacing.screenPadding),
                        child: bottom!,
                      ),
                    ),
            ),
    );
  }
}
