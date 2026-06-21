import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';

class CustomerShell extends StatelessWidget {
  const CustomerShell({required this.child, super.key, this.currentIndex});

  final int? currentIndex;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: currentIndex == null
          ? null
          : NavigationBar(
              selectedIndex: currentIndex!,
              backgroundColor: AppColors.surface,
              indicatorColor: AppColors.primary,
              onDestinationSelected: (index) {
                switch (index) {
                  case 0:
                    context.go(AppRoutes.customerHome);
                  case 1:
                    context.go(AppRoutes.customerActivity);
                  case 2:
                    context.go(AppRoutes.customerSearch);
                  case 3:
                    context.go(AppRoutes.customerProfile);
                }
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(
                    Icons.home_rounded,
                    color: AppColors.surface,
                  ),
                  label: 'Beranda',
                ),
                NavigationDestination(
                  icon: Icon(Icons.assignment_outlined),
                  selectedIcon: Icon(
                    Icons.assignment_rounded,
                    color: AppColors.surface,
                  ),
                  label: 'Aktivitas',
                ),
                NavigationDestination(
                  icon: Icon(Icons.search_rounded),
                  selectedIcon: Icon(
                    Icons.search_rounded,
                    color: AppColors.surface,
                  ),
                  label: 'Cari',
                ),
                NavigationDestination(
                  icon: Icon(Icons.person_outline_rounded),
                  selectedIcon: Icon(
                    Icons.person_rounded,
                    color: AppColors.surface,
                  ),
                  label: 'Profil',
                ),
              ],
            ),
    );
  }
}
