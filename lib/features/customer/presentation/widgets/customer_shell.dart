import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';

// Ganti angka ini untuk simulasi jumlah aktivitas aktif (0 = tidak ada badge)
final _activeJobCountProvider = Provider<int>((ref) => 2);

class CustomerShell extends ConsumerWidget {
  const CustomerShell({required this.child, super.key, this.currentIndex});

  final int? currentIndex;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeCount = ref.watch(_activeJobCountProvider);

    return Scaffold(
      body: child,
      bottomNavigationBar: currentIndex == null
          ? null
          : NavigationBar(
              selectedIndex: currentIndex!,
              onDestinationSelected: (index) {
                switch (index) {
                  case 0:
                    context.go(AppRoutes.customerHome);
                  case 1:
                    context.go(AppRoutes.customerActivity);
                  case 2:
                    context.go(AppRoutes.customerMessages);
                  case 3:
                    context.go(AppRoutes.customerProfile);
                }
              },
              destinations: [
                const NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home_rounded),
                  label: 'Beranda',
                ),
                NavigationDestination(
                  icon: activeCount > 0
                      ? Badge.count(
                          count: activeCount,
                          child: const Icon(Icons.assignment_outlined),
                        )
                      : const Icon(Icons.assignment_outlined),
                  selectedIcon: activeCount > 0
                      ? Badge.count(
                          count: activeCount,
                          child: const Icon(Icons.assignment_rounded),
                        )
                      : const Icon(Icons.assignment_rounded),
                  label: 'Aktivitas',
                ),
                const NavigationDestination(
                  icon: Icon(Icons.chat_bubble_outline_rounded),
                  selectedIcon: Icon(Icons.chat_bubble_rounded),
                  label: 'Pesan',
                ),
                const NavigationDestination(
                  icon: Icon(Icons.person_outline_rounded),
                  selectedIcon: Icon(Icons.person_rounded),
                  label: 'Profil',
                ),
              ],
            ),
    );
  }
}
