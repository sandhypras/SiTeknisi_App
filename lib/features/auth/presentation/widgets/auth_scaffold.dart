import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: appBar,
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.screenPadding),
          children: children,
        ),
      ),
      bottomNavigationBar: bottom == null
          ? null
          : SafeArea(
              minimum: const EdgeInsets.all(AppSpacing.screenPadding),
              child: bottom!,
            ),
    );
  }
}
