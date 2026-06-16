import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';

class TechnicianShell extends StatelessWidget {
  const TechnicianShell({
    required this.currentIndex,
    required this.child,
    super.key,
  });

  final int currentIndex;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        backgroundColor: AppColors.surface,
        indicatorColor: AppColors.primary,
        onDestinationSelected: (index) {
          switch (index) {
            case 0:
              context.go(AppRoutes.technicianDashboard);
            case 1:
              context.go(AppRoutes.technicianRequests);
            case 2:
              context.go(AppRoutes.technicianJobs);
            case 3:
              context.go(AppRoutes.technicianEarnings);
          }
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(
              Icons.dashboard_rounded,
              color: AppColors.surface,
            ),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.inbox_outlined),
            selectedIcon: Icon(Icons.inbox_rounded, color: AppColors.surface),
            label: 'Request',
          ),
          NavigationDestination(
            icon: Icon(Icons.build_outlined),
            selectedIcon: Icon(Icons.build_rounded, color: AppColors.surface),
            label: 'Job',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_balance_wallet_outlined),
            selectedIcon: Icon(
              Icons.account_balance_wallet_rounded,
              color: AppColors.surface,
            ),
            label: 'Earning',
          ),
        ],
      ),
    );
  }
}
